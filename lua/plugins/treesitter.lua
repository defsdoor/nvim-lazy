return {
  "nvim-treesitter/nvim-treesitter",
  build =  ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      endwise = { enable = true },
      ensure_installed = {"lua", "javascript", "ruby", "html", "embedded_template"},
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
