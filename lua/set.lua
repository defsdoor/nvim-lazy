vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.breakindex = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight =1
vim.opt.cursorline = true
vim.opt.fileformat = "unix"
vim.opt.hlsearch = true

vim.opt.wrap = true
vim.opt.tildeop = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- fold settings
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.go.foldlevelstart = 99
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

vim.opt.background = "dark"

-- Strip trailing spaces on save - finally shared with the world by TSV
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

