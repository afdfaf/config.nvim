local M = {}

function M.setup()
  local jdtls = require 'jdtls'
  local HOME = os.getenv 'HOME'
  local JDTLS_DIR = HOME .. '/.local/share/nvim/jdtls'

   -- 1. Locate JDTLS and Java
  local jdtls_jar = vim.fn.glob(JDTLS_DIR .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local java_home = "/usr/lib/jvm/java-24-openjdk" -- Adjust for your system
  local workspace_dir = HOME .. "/.workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

   -- 2. Bundles (for debugging/tests)
  local bundles = {
    vim.fn.glob(JDTLS_DIR .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  }
  vim.list_extend(bundles, vim.split(vim.fn.glob(JDTLS_DIR .. "/vscode-java-test/server/*.jar"), "\n"))

  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

      'java', -- or '/path/to/java21_or_newer/bin/java'
      -- depends on if `java` is in your $PATH env variable and if it points to the right version.

      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', jdtls_jar,
      '-configuration', JDTLS_DIR .. '/config_linux',
      '-data', workspace_dir,
    },

    root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),

    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-24",
              path = java_home,
            }
          }
        }
      }
    },

    init_options = {
      bundles = bundles,
    },

  on_attach = function(client, bufnr)
      -- Shared LSP keymaps from your main config
      require("config.lsp").on_attach(client, bufnr)
      require('jdtls').setup_dap({ hotcodereplace = 'auto' })

      -- Java-specific keymaps
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map("n", "<leader>di", jdtls.organize_imports, "Organize Imports")
      map("n", "<leader>dt", jdtls.test_class, "Test Class")
      map("n", "<leader>dn", jdtls.test_nearest_method, "Test Nearest Method")
  end
}
  -- This starts a new client & server,
  -- or attaches to an existing client & server depending on the `root_dir`.
  require('jdtls').start_or_attach(config)
end

return M
