return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  lazy = true,
  dependencies = {
    {'neovim/nvim-lspconfig'},
    -- Autocompletion
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},
    {'onsails/lspkind.nvim'},
    -- Snippets
    -- {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
  },
--  {
--    "williamboman/mason.nvim",
--    config = function()
--      require("mason").setup()
--    end
--  },
--  {
--    "williamboman/mason-lspconfig.nvim",
--    config = function()
--      require("mason-lspconfig").setup({
--        ensure_installed = { "rubocop" }
--      })
--    end
--  }
}
