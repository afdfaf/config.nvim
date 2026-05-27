vim.pack.add { 'https://github.com/mfussenegger/nvim-jdtls' }

local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'

local launcher = mason_path .. '/bin/jdtls'
local config_dir = mason_path .. '/config_linux'

-- Autocommand group
local group = vim.api.nvim_create_augroup('JdtlsStart', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = group,
  pattern = 'java',
  callback = function()
    local jdtls = require 'jdtls'

    local root_dir = jdtls.setup.find_root {
      '.git',
      'mvnw',
      'gradlew',
      'pom.xml',
      'build.gradle',
    }
    if not root_dir then
      vim.notify('Java project root not found, using current directory', vim.log.levels.WARN)
      root_dir = vim.fn.getcwd()
    end

    local workspace_dir = vim.fs.joinpath(root_dir, '.jdtls') -- no unused variable

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.formatting = nil -- nil removes the field
    capabilities.textDocument.rangeFormatting = nil

    local lombok_path = mason_path .. '/lombok.jar'
    local has_lombok = vim.uv.fs_stat(lombok_path) ~= nil

    local cmd = {
      launcher,
      '-configuration',
      config_dir,
      '-data',
      workspace_dir,
    }
    if has_lombok then
      table.insert(cmd, '--jvm-arg=-javaagent:' .. lombok_path)
    end

    jdtls.start_or_attach {
      cmd = cmd,
      root_dir = root_dir,
      capabilities = capabilities,
    }
  end,
})
