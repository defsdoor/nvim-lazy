return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {"VonHeikemen/lsp-zero.nvim"},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},
    {'onsails/lspkind.nvim'},
  },
  config = function()
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    local cmp_select = {behavior = cmp.SelectBehavior.Select}
    local lspkind = require('lspkind')
    cmp.setup({
      sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-s>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true, })
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          menu = ({
            path = '[Path]',
            nvim_lsp = '[LSP]',
            nvim_lua = '[Lua]',
            buffer = '[Buf]',
            luasnip = '[Snip]',
          })
        })
      }

    })

  end
}
