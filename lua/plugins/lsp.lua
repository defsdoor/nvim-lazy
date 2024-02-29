return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  lazy = true,
  dependencies = {
    {'neovim/nvim-lspconfig'},
    {'nvim-telescope/telescope.nvim'},
    -- Autocompletion
    -- Snippets
    -- {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
  },
  config = function()
    local lsp = require("lsp-zero")
    lsp.extend_lspconfig()
    lsp.preset("recommended")

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
      vim.keymap.set("n", "gd",          vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K",           vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d",          vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "]d",          vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
      vim.keymap.set("i", "<C-h>",       vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>f",   vim.lsp.buf.format)
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

    end
}
