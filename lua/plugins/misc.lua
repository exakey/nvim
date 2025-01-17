return {
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
                event  = "VeryLazy",
                config = true,
        },
        {
                "anuvyklack/keymap-amend.nvim",
                event = "VeryLazy",
        },
}
