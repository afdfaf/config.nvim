return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java', -- Only loads for Java files
    config = function()
      require('config.java').setup()
    end,
  },
}
