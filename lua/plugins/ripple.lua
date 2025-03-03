return {
        "ian-howell/ripple.nvim",
        event  = "VeryLazy",
        enabled = true,
        config = function()
                require("ripple").setup({
                        keys = {
                                expand_right = { "<C-right>", mode = { "n", "v" }, desc = "expand right" },
                                expand_left  = { "<C-left>", mode = { "n", "v" }, desc = "expand left" },
                                expand_up    = { "<C-up>", mode = { "n", "v" }, desc = "expand up" },
                                expand_down  = { "<C-down>", mode = { "n", "v" }, desc = "expand down" },
                        },
                })
        end,
        opts   = {},
}
