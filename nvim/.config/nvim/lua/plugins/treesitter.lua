return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup({
            -- Directory to install parsers and queries to
            install_dir = vim.fn.stdpath('data') .. '/site',
        })
        require('nvim-treesitter').install({ 'lua', 'javascript', 'bash' })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'lua', 'javascript', 'bash' },
            callback = function()
                vim.treesitter.start()
            end,
        })

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
}
