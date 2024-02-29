return {
  "nvim-treesitter/nvim-treesitter",
  build =  ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      endwise = { enable = true },
      ensure_installed = {"lua", "javascript", "ruby", "html", "embedded_template"},
      highlight = { enable = true },
      indent = { enable = true },
      vim.treesitter.language.register('yaml', 'eruby.yaml')
    })
  end
}
