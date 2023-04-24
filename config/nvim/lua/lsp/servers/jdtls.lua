local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify("unable to load jdtls", "error")
  return
end

local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/lsp_servers/packages/jdtls/jdtls"

-- Data directory - change it to your liking
local HOME = os.getenv "HOME"
local WORKSPACE_PATH = HOME .. "/Projects/java/"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local default_config = require('lsp.servers.default')

local opts = {
  autostart = default_config.autostart,
  on_attach = function(client, bufnr)
    jdtls.setup.add_commands() -- important to ensure you can update configs when build is updated
    default_config.on_attach(client, bufnr)
  end,
  cmd = {
    JDTLS_LOCATION,
    "-data",
    workspace_dir,
  },
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      completion = {
        favoriteStaticMembers = {},
        filteredTypes = {
          -- "com.sun.*",
          -- "io.micrometer.shaded.*",
          -- "java.awt.*",
          -- "jdk.*",
          -- "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },

      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath "config" .. "/after/ftplugin/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      import = { enabled = true },
      rename = { enabled = true },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}

return opts
