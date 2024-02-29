return {
  {
	  'nvim-telescope/telescope.nvim',
	  dependencies = { 'nvim-lua/plenary.nvim'},
    config = function()
      local telescope = require("telescope.builtin")
      vim.keymap.set('n', '<leader>rc',
        function() telescope.find_files({ search_dirs = { "app/controllers" } }) end,
        { desc = "Open Rails Controllers" })
      vim.keymap.set('n', '<leader>rm',
        function() telescope.find_files({ search_dirs = { "app/models" } }) end,
        { desc = "Open Rails Models" })
      vim.keymap.set('n', '<leader>rv',
        function() telescope.find_files({ search_dirs = { "app/views" } }) end,
        { desc = "Open Rails Views" })
      vim.keymap.set('n', '<leader>rj',
        function() telescope.find_files({ search_dirs = { "app/javascript", "app/assets/javascripts" } }) end,
        { desc = "Open Rails Javascripts" })
      vim.keymap.set('n', '<leader>rs',
        function() telescope.find_files({ search_dirs = { "app/assets/stylesheets" } }) end,
        { desc = "Open Rails Stylesheets" })
      vim.keymap.set('n', '<leader>rh',
        function() telescope.find_files({ search_dirs = { "app/helpers" } }) end,
        { desc = "Open Rails Helpers" })
      vim.keymap.set('n', '<leader>ro',
        function() telescope.oldfiles({ cwd_only = true }) end,
        { desc = "Open Old Files" })
      vim.keymap.set('n', '<leader>rz',
        function() telescope.resume() end,
        { desc = "Resume previous find" })
      vim.keymap.set('n', '<leader>rb',
        function() telescope.buffers({ search_dirs = { "." } }) end,
        { desc = "Open Old Buffers" })
      vim.keymap.set('n', '<leader>pf', telescope.find_files, { desc = "File Files" })
      vim.keymap.set('n', '<C-p>', telescope.git_files, { desc = "Git Files" })
      vim.keymap.set('n', '<leader>ps',
        function() telescope.grep_string({ search = vim.fn.input("Grep > ") }) end,
        { desc = "Grep Files" })
      vim.keymap.set('n', '<leader>vh', telescope.help_tags, { desc = "Help Tags" })
      vim.keymap.set('n', '<leader>rf',
        function()
          cwd = vim.fn.getcwd()
          vim.notify(cwd)
          fp = vim.fn.expand("%:h")
          vim.notify(fp)
          p = fp:gsub("^" .. cwd, "")
          vim.notify(p)
          telescope.find_files({ search_dirs = { p } })
        end,
        { desc = "Browse files in current file directory" })
     end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").setup({
        extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown { }  } }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}
