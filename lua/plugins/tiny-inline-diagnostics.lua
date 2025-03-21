return {
        "rachartier/tiny-inline-diagnostic.nvim",
        lazy     = false,
        priority = 1000,
        config   = function()
                require("tiny-inline-diagnostic").setup({
                        signs   = {
                                left = "",
                                right = "",
                                diag = "■",
                                arrow = "",
                                up_arrow = "    ",
                                vertical = " │",
                                vertical_end = " └",
                        },
                        blend   = {
                                factor = 0.15,
                        },
                        hi      = {
                                error = "DiagnosticError",
                                warn  = "DiagnosticWarn",
                                info  = "DiagnosticInfo",
                                hint  = "DiagnosticHint",
                                arrow = "NonText",
                        },
                        options = {
                                show_source                  = true,
                                throttle                     = 0,
                                softwrap                     = 30,
                                multiple_diag_under_cursor   = true,
                                multilines                   = true,
                                show_all_diags_on_cursorline = true,
                                enable_on_insert             = false,
                                overwrite_events             = nil,
                                overflow                     = {
                                        mode = "wrap",
                                },
                                break_line                   = {
                                        enabled = false,
                                        after   = 30,
                                },
                                virt_texts                   = {
                                        priority = 99,
                                },
                                severity                     = {
                                        vim.diagnostic.severity.ERROR,
                                        vim.diagnostic.severity.WARN,
                                        vim.diagnostic.severity.INFO,
                                        vim.diagnostic.severity.HINT,
                                },
                                format                       = function(diagnostic)
                                        return diagnostic.message
                                end,
                        },
                })
        end
}
