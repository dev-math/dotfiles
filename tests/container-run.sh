#!/usr/bin/env bash
# Runtime smoke test: builds the image, loads it into a container engine,
# and checks it actually works as a container (not just as a Nix build).
# Complements the build-time `nix flake check` (checks.smoke-test in
# flake.nix), which only checks the store paths chezmoi/Nix produced.
set -euo pipefail
cd "$(dirname "$0")/.."

ENGINE="${CONTAINER_ENGINE:-}"
if [ -z "$ENGINE" ]; then
  if command -v docker >/dev/null 2>&1; then ENGINE=docker
  elif command -v podman >/dev/null 2>&1; then ENGINE=podman
  else echo "no docker or podman found on PATH" >&2; exit 1
  fi
fi

echo "==> nix build .#dockerImage"
nix build .#dockerImage

echo "==> $ENGINE load"
"$ENGINE" load -i result

echo "==> checking binaries, config, ownership, permissions"
"$ENGINE" run --rm --entrypoint /bin/zsh localhost/terminal-devenv:latest -c '
set -euo pipefail

for b in zsh tmux nvim rg fd fzf bat eza exa git jq tldr dust procs; do
  command -v "$b" >/dev/null || { echo "missing binary: $b"; exit 1; }
done

test "$(id -u)" = "1000" || { echo "expected to run as uid 1000, got $(id -u)"; exit 1; }

for f in "$HOME/.zshenv" "$HOME/.config/zsh/.zshrc" "$HOME/.config/tmux/tmux.conf" "$HOME/.config/nvim/init.lua"; do
  test -f "$f" || { echo "missing config file: $f"; exit 1; }
done

for d in "$HOME/.config/sway" "$HOME/.config/dunst" "$HOME/.config/mopidy" "$HOME/.config/zathura"; do
  test ! -e "$d" || { echo "unexpected desktop path present: $d"; exit 1; }
done

touch "$HOME/.zsh_history" || { echo "cannot write to \$HOME as non-root user"; exit 1; }

echo "all checks passed"
'

echo "==> OK"
