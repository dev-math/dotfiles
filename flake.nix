{
  description = "Terminal-focused dev container built from dev-math/dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    # nvim config no longer lives inside dotfiles (it dropped lazy.nvim for
    # Neovim's native vim.pack) -- it's its own repo, pinned separately here.
    nvimConfig = {
      url = "github:dev-math/nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, nvimConfig }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        user = "dev";

        # Direct dependencies. Edit this list to change what ships in the
        # image. Transitive deps (every library each of these pulls in) are
        # pinned automatically by flake.lock's nixpkgs revision.
        directDeps = with pkgs; [
          zsh
          tmux
          neovim
          ripgrep
          fd
          fzf
          bat
          eza
          git
          git-lfs
          openssh
          curl
          wget
          jq
          htop
          tealdeer
          dust
          procs
          less
          man-db
          chezmoi
          cacert
          coreutils
          findutils
          gnugrep
          gnused
          which
        ];

        # dot_config/zsh/aliases hardcodes the `exa` command name. eza
        # replaces the unmaintained `exa` package, so keep the alias working
        # with a compatibility symlink instead of editing the dotfiles repo.
        exaCompat = pkgs.runCommand "exa-compat" { } ''
          mkdir -p $out/bin
          ln -s ${pkgs.eza}/bin/eza $out/bin/exa
        '';

        chezmoiData = pkgs.writeText "chezmoi.toml" ''
          [data]
            name = "Matheus Rocha"
            email = "01devmath@gmail.com"
            font = "Hack Nerd Font Mono"
        '';

        # Renders this repo's chezmoi-managed configs into a $HOME tree at
        # build time, using `self` since flake.nix now lives inside the
        # dotfiles repo it builds (no separate pinned input needed --
        # every build always uses the exact checkout it's part of).
        # run_once_* scripts are excluded: they assume Arch/pacman, and do
        # network installs (asdf plugins, nerd fonts, tpm, Bitwarden CLI,
        # flatpak GUI apps) that don't belong in a locked, sandboxed build.
        # Externals are excluded too -- .chezmoiexternal.toml clones
        # dev-math/nvim over the network at apply time, which the
        # sandboxed Nix build can't do; nvimConfig is fetched as a pinned
        # flake input instead and copied in below.
        homeConfig = pkgs.runCommand "home-config"
          {
            nativeBuildInputs = [ pkgs.chezmoi ];
          } ''
          export HOME=$out
          mkdir -p "$HOME/.config/chezmoi"
          cp ${chezmoiData} "$HOME/.config/chezmoi/chezmoi.toml"
          chezmoi apply --source=${self} --exclude=scripts,externals --force
          mkdir -p "$HOME/.config/nvim"
          cp -r ${nvimConfig}/. "$HOME/.config/nvim/"
        '';

        # dockerTools images have no real user database; stub one out so
        # tools that call getpwnam (ssh, git, ...) don't fail.
        userSetup = pkgs.runCommand "user-setup" { } ''
          mkdir -p $out/etc $out/tmp
          echo "root:x:0:0:root:/root:${pkgs.zsh}/bin/zsh" > $out/etc/passwd
          echo "${user}:x:1000:1000:${user}:/home/${user}:${pkgs.zsh}/bin/zsh" >> $out/etc/passwd
          echo "root:x:0:" > $out/etc/group
          echo "${user}:x:1000:" >> $out/etc/group
          echo "127.0.0.1 localhost" > $out/etc/hosts
        '';

        requiredBins = [
          "zsh" "tmux" "nvim" "rg" "fd" "fzf" "bat" "eza" "git" "jq" "tldr" "dust" "procs"
        ];

        smokeTest = pkgs.runCommand "smoke-test"
          {
            nativeBuildInputs = directDeps;
          } ''
          set -euo pipefail
          for bin in ${builtins.concatStringsSep " " requiredBins}; do
            command -v "$bin" >/dev/null || { echo "missing binary on PATH: $bin"; exit 1; }
          done

          test -f ${homeConfig}/.zshenv || { echo "missing ~/.zshenv from chezmoi apply"; exit 1; }
          test -f ${homeConfig}/.config/zsh/.zshrc || { echo "missing ~/.config/zsh/.zshrc"; exit 1; }
          test -f ${homeConfig}/.config/tmux/tmux.conf || { echo "missing ~/.config/tmux/tmux.conf"; exit 1; }
          test -f ${homeConfig}/.config/nvim/init.lua || { echo "missing ~/.config/nvim/init.lua"; exit 1; }

          # desktop-only paths must NOT be present (server profile via
          # .chezmoiignore hostname check, see dotfiles' .chezmoiignore)
          for desktop_path in .config/sway .config/dunst .config/mopidy .config/ncmpcpp .config/zathura; do
            if [ -e "${homeConfig}/$desktop_path" ]; then
              echo "unexpected desktop path present: $desktop_path"
              exit 1
            fi
          done

          echo exa | ${exaCompat}/bin/exa --version >/dev/null 2>&1 || true
          ${exaCompat}/bin/exa --version >/dev/null || { echo "exa compat symlink broken"; exit 1; }

          touch $out
        '';
      in
      {
        packages.dockerImage = pkgs.dockerTools.buildLayeredImage {
          name = "terminal-devenv";
          tag = "latest";
          contents = directDeps ++ [ exaCompat userSetup ];

          extraCommands = ''
            mkdir -p home/${user}
            cp -r ${homeConfig}/. home/${user}/
          '';

          # buildLayeredImage's extraCommands run unprivileged, so files
          # copied in are still owned by the build uid. fakeRootCommands +
          # enableFakechroot lets us chown them to the container's non-root
          # user, so zsh/nvim can actually write history, compinit caches,
          # etc. at runtime instead of hitting a read-only $HOME.
          enableFakechroot = true;
          fakeRootCommands = ''
            chown -R 1000:1000 /home/${user}
          '';

          config = {
            Cmd = [ "${pkgs.zsh}/bin/zsh" ];
            User = "1000:1000";
            Env = [
              "HOME=/home/${user}"
              "USER=${user}"
              "LANG=en_US.UTF-8"
              "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              "PATH=/home/${user}/.local/bin:/bin"
            ];
            WorkingDir = "/home/${user}";
            Hostname = "devcontainer";
          };
        };

        packages.default = self.packages.${system}.dockerImage;

        checks.smoke-test = smokeTest;

        devShells.default = pkgs.mkShell {
          packages = [ pkgs.docker ];
        };
      });
}
