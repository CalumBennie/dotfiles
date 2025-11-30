return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.1.9',
        dependencies = { 'nvim-lua/plenary.nvim' },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            },
            {
                ['ui-select'] = {
                    require('telescope.themes').get_cursor({}),
                },
            },
        },
        pickers = {
            -- Possible Themes:
            -- get_dropdown
            -- get_cursor
            -- get_ivy
            -- find_files = { theme = "dropdown" },
        },
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require('telescope').load_extension('ui-select')
        end,
    },
    {
        'nvim-telescope/telescope-frecency.nvim',
        -- install the latest stable version
        version = '*',
        config = function()
            require('telescope').load_extension('frecency')
        end,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        mappings = {
                            ['i'] = {
                                -- your custom insert mode mappings
                            },
                            ['n'] = {
                                -- your custom normal mode mappings
                            },
                        },
                    },
                },
            })
            -- To get telescope-file-browser loaded and working with telescope,
            -- you need to call load_extension, somewhere after setup function:
            require('telescope').load_extension('file_browser')
        end,
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
}
