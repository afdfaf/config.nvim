vim.schedule(function()
  require('jdtls').start_or_attach(require('config.java').config)
end)
