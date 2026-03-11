return {
    -- This imports oil, which is the plugin used for file exploring
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },

    -- Adds in support for async marking of files with git status
    { "malewicz1337/oil-git.nvim", dependencies = { "stevearc/oil.nvim" } }
}
