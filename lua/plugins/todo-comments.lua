return {
        "folke/todo-comments.nvim",
        event        = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts         = {
                keywords = {
                        --[[ FIX:]]
                        FIX = {
                                icon  = "■",
                                color = "error",
                                alt   = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                        },
                        --[[ TODO:]]
                        TODO = { icon = "■", color = "#f5e0dc" },
                        --[[ HACK:]]
                        HACK = { icon = "■", color = "#cba6f7" },
                        --[[ WARN:]]
                        WARN = { icon = "■", color = "warning", alt = { "WARNING", "XXX" } },
                        --[[ PERF:]]
                        PERF = { icon = "■", color = "#a6e3a1", alt = { "STYLING", "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                        --[[ NOTE:]]
                        NOTE = { icon = "■", color = "info", alt = { "INFO" } },
                        --[[ TEST:]]
                        TEST = { icon = "■", color = "#89b4fa", alt = { "TESTING", "PASSED", "FAILED" } },
                        --[[ HINT:]]
                        HINT = { icon = "■", color = "#dce0e8" },
                },
                gui_style = { fg = "NONE", bg = "BOLD" },
        },
}
