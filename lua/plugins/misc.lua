return {
        {
                'stevearc/oil.nvim',
                ---@module 'oil'
                ---@type oil.SetupOpts
                opts = {},
                -- Optional dependencies
                dependencies = { { "echasnovski/mini.icons", opts = {} } },
                -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
                -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
                lazy = false,
        },
        {
                "folke/persistence.nvim",
                lazy = false,
                opts = {
                        dir    = vim.fn.stdpath("state") .. "/sessions/",
                        need   = 1,
                        branch = true,
                },
        },
        {
                "cappyzawa/trim.nvim",
                event  = "VeryLazy",
                config = function()
                        require("trim").setup()
                end
        },
        {
                'jsongerber/thanks.nvim',
                event  = "VimEnter",
                config = true,
        },
        {
                "anuvyklack/keymap-amend.nvim",
                event = "VeryLazy",
        },
}
