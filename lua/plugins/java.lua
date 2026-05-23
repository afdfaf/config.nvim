return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      local group = vim.api.nvim_create_augroup('JdtlsStart', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'java',
        callback = function()
          local jdtls = require 'jdtls'
          local root_dir = require('jdtls.setup').find_root {
            '.git',
            'mvnw',
            'gradlew',
            'pom.xml',
            'build.gradle',
          } or vim.fn.getcwd()

          local home = vim.env.HOME
          local launcher = vim.fn.glob(home .. '/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')
          if launcher == '' then
            vim.notify('jdtls launcher jar not found in ~/.local/share/jdtls/plugins', vim.log.levels.ERROR)
            return
          end

          local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')

          jdtls.start_or_attach {
            cmd = {
              'java',
              '-Declipse.application=org.eclipse.jdt.ls.core.id1',
              '-Dosgi.bundles.defaultStartLevel=4',
              '-Declipse.product=org.eclipse.jdt.ls.core.product',
              '-Dlog.protocol=true',
              '-Dlog.level=ALL',
              '-Xmx1g',
              '--add-modules=ALL-SYSTEM',
              '--add-opens',
              'java.base/java.util=ALL-UNNAMED',
              '--add-opens',
              'java.base/java.lang=ALL-UNNAMED',
              '-jar',
              launcher,
              '-configuration',
              home .. '/.local/share/jdtls/config_linux',
              '-data',
              home .. '/.cache/jdtls/workspace/' .. project_name,
            },
            root_dir = root_dir,
          }
        end,
      })
    end,
  },
}
