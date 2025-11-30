return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        -- explorer = { enabled = true },
        gh = { enabled = true },
        indent = { enabled = true },
        -- input = { enabled = true },
        lazygit = { enabled = true },
        -- picker = { enabled = true },
        -- notifier = { enabled = true },
        profiler = { enabled = true },
        quickfile = { enabled = true },
        -- scope = { enabled = true },
        -- scroll = { enabled = true },
        -- statuscolumn = { enabled = true },
        words = { enabled = true },
        dim = { enabled = true },
        zen = { enabled = true },
    },
}
