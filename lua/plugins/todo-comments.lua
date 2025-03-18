return {
        "folke/todo-comments.nvim",
        event        = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },

        keys         = {
                { "t,", function() require("todo-comments").jump_prev() end,  { desc = "Previous todo comment" } },
                { "t.", function() require("todo-comments").jump_next() end,  { desc = "Next todo comment" } },
        },

        opts         = {
                signs          = false,

                keywords       = {
                        -- FIX
                        FIX = { color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                        -- TODO
                        TODO = { color = "#f5e0dc", alt = { "PENDING", "GUARD", "REQUIRED", "VALIDATE", "TEMP", "TEMPLATE", "DEBUG" } },
                        -- WARN
                        WARN = { color = "warning", alt = { "WARNING", "SIC", "CAVEAT", "DEPRECATION" } },
                        -- NOTE
                        NOTE = { color = "info", alt = { "INFO", "CONFIG", "SOURCE", "DATA", "EXAMPLE", "IMPORTANT" } },
                        -- TEST
                        TEST = { color = "#89b4fa", alt = { "TESTING", "PASSED", "FAILED" } },
                        -- HINT
                        HINT = { color = "#dce0e8", alt = { "HACK", "CLUE" } },
                },

                highlight      = {
                        multiline         = true,
                        multiline_pattern = "^.",
                        multiline_context = 10,
                        keyword           = "wide_bg",
                        before            = "",
                        after             = "",
                        pattern           = [[.*<(KEYWORDS)\s*]],
                },
                merge_keywords = false,
                gui_style      = { fg = "NONE", bg = "BOLD" },
                pattern        = [[\b(KEYWORDS)\b]]
        },
}
