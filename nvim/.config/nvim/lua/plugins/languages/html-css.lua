return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        html = {},
        css = {},
      },
      setup = {
        html = function()
          require('lspconfig').html.setup {}
        end,
        cssls = function()
          require('lspconfig').cssls.setup {}
        end,
      },
    },
  },
}
