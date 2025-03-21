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
                        -- FIX  fix
                        FIX = { color = "error", alt = { "FIXME", "BUG", "ERROR", "FIXIT", "ISSUE" } },
                        -- TODO  todo
                        TODO = { color = "#f5e0dc", alt = { "PENDING", "GUARD", "REQUIRED", "VALIDATE", "TEMP", "TEMPLATE", "DEBUG" } },
                        -- WARN  warn
                        WARN = { color = "warning", alt = { "WARNING", "SIC", "CAVEAT", "DEPRECATION" } },
                        -- NOTE  note
                        NOTE = { color = "info", alt = { "INFO", "CONFIG", "SOURCE", "DATA", "EXAMPLE", "IMPORTANT" } },
                        -- TEST  test
                        TEST = { color = "#89b4fa", alt = { "TESTING", "PASSED", "FAILED" } },
                        -- HINT  hint
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
