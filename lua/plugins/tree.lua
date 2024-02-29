return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      filters = {
        dotfiles = false,
      },
    })
    vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
  end
}

