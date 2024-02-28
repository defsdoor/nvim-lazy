local lsp = require("lsp-zero")

lsp.extend_lspconfig()

lsp.preset("recommended")

-- Fix Undefined global 'vim'
-- lsp.configure('lua-language-server', {
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = { 'vim' }
--             }
--         }
--     }
-- })

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')

local cmp_select = {behavior = cmp.SelectBehavior.Select}

--  ['<CR>'] = vim.NIL,
--  ['<Tab>'] = vim.NIL,
--  ['<S-Tab>'] = vim.NIL,

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
--    completion = cmp.config.window.bordered(),
--    documentation = cmp.config.window.bordered(),
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

lsp.set_sign_icons( {
  error = '✘',
  warn = '⚠',
  hint = '⚑',
  info = 'ℹ'
})

lsp.set_preferences({
    suggest_lsp_servers = true,
--    sign_icons = {
--        error = 'E',
--        warn = 'W',
--        hint = 'H',
        info = 'I'
--    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
end)

lsp.setup()

-- adds ShowRubyDeps command to show dependencies in the quickfix list.
-- add the `all` argument to show indirect dependencies as well
local function add_ruby_deps_command(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps",
                                          function(opts)

        local params = vim.lsp.util.make_text_document_params()

        local showAll = opts.args == "all"

        client.request("rubyLsp/workspace/dependencies", params,
                        function(error, result)
            if error then
                print("Error showing deps: " .. error)
                return
            end

            local qf_list = {}
            for _, item in ipairs(result) do
                if showAll or item.dependency then
                    table.insert(qf_list, {
                        text = string.format("%s (%s) - %s",
                                              item.name,
                                              item.version,
                                              item.dependency),

                        filename = item.path
                    })
                end
            end

            vim.fn.setqflist(qf_list)
            vim.cmd('copen')
        end, bufnr)
    end, {nargs = "?", complete = function()
        return {"all"}
    end})
end

require("lspconfig").ruby_ls.setup({
  on_attach = function(client, buffer)
    --    setup_diagnostics(client, buffer)
    add_ruby_deps_command(client, buffer)
  end,
})

vim.diagnostic.config({
    virtual_text = true
})

