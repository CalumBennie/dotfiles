return {
    'nvimtools/none-ls.nvim',
    -- dependencies = {
    --     'nvimtools/none-ls-extras.nvim',
    -- },
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,

                -- TS
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.biome,

                -- Java
                null_ls.builtins.diagnostics.checkstyle.with({
                    extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
                }),
            },
        })
    end,
}
