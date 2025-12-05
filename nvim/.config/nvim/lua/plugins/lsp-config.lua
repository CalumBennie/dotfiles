local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
    -- lua_ls = {
    --     -- cmd = { ... },
    --     -- filetypes = { ... },
    --     -- capabilities = {},
    --     settings = {
    --         Lua = {
    --             completion = {
    --                 callSnippet = 'Replace',
    --             },
    --             -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
    --             -- diagnostics = { disable = { 'missing-fields' } },
    --         },
    --     },
    -- },
    bashls = {},
    lemminx = {},
    jdtls = {},
}
local ensure_installed = vim.tbl_keys(servers or {})

vim.list_extend(ensure_installed, {
    'stylua', -- Formats Lua code
    'xmlformatter', -- Formats xml
    'biome', -- TS Formatter
    'google-java-format',
    'checkstyle',
    -- 'sonarlint-language-server', -- Java+Others Linter
})

return {
    {
        'mason-org/mason.nvim',
        opts = {},
    },
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {
            automatic_enable = {
                exclude = {
                    'jdtls', -- Uses nvim-jdtls
                },
            },
        },
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'neovim/nvim-lspconfig',
        },
        automatic_installation = false,
        handlers = {
            function(server_name)
                local server = servers or {}
                -- This handles overriding only values explicitly passed
                -- by the server configuration above. Useful when disabling
                -- certain features of an LSP (for example, turning off formatting for ts_ls)
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end,
        },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {}, -- Handled by Mason-Tool-Installer
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        -- config = function()
        --     vim.api.nvim_create_autocmd('lspattach', {
        --         group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        --         callback = function(event)
        --             local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        --             vim.api.nvim_create_autocmd({ 'cursorhold', 'cursorholdi' }, {
        --                 buffer = event.buf,
        --                 group = highlight_augroup,
        --                 callback = vim.lsp.buf.document_highlight,
        --             })
        --
        --             vim.api.nvim_create_autocmd({ 'cursormoved', 'cursormovedi' }, {
        --                 buffer = event.buf,
        --                 group = highlight_augroup,
        --                 callback = vim.lsp.buf.clear_references,
        --             })
        --
        --             vim.api.nvim_create_autocmd('lspdetach', {
        --                 group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        --                 callback = function(event2)
        --                     vim.lsp.buf.clear_references()
        --                     vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
        --                 end,
        --             })
        --         end,
        --     })
        -- end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup({
                ensure_installed = ensure_installed,
                integrations = {
                    ['mason-lspconfig'] = true,
                    ['mason-null-ls'] = true,
                    ['mason-nvim-dap'] = true,
                },
            })
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        dependencies = {
            'mfussenegger/nvim-dap',
        }
    },
}
