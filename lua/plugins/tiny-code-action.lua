return {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-telescope/telescope.nvim" },
        },
        event        = "LspAttach",
        config       = function()
                require('tiny-code-action').setup({
                        backend        = "delta",
                        backend_opts   = {
                                delta = {
                                        header_lines_to_remove = 4,
                                        args                   = {},
                                },
                        },
                        telescope_opts = {
                                layout_strategy = "vertical",
                                layout_config   = {
                                        vertical = {
                                                -- width          = 0.5,
                                                -- height         = 0.7,
                                                preview_cutoff = 1,
                                                preview_height = function(_, _, max_lines)
                                                        local h = math.floor(max_lines * 0.6)
                                                        return math.max(h, 10)
                                                end,
                                        },
                                },
                        },
                        signs          = {
                                quickfix                   = { "󰁨", { link = "DiagnosticInfo" } },
                                others                     = { "?", { link = "DiagnosticWarning" } },
                                refactor                   = { "", { link = "DiagnosticWarning" } },
                                ["refactor.move"]          = { "", { link = "DiagnosticInfo" } },
                                ["refactor.extract"]       = { "", { link = "DiagnosticError" } },
                                ["source.organizeImports"] = { "", { link = "TelescopeResultVariable" } },
                                ["source.fixAll"]          = { "", { link = "TelescopeResultVariable" } },
                                ["source"]                 = { "", { link = "DiagnosticError" } },
                                ["rename"]                 = { "", { link = "DiagnosticWarning" } },
                                ["codeAction"]             = { "", { link = "DiagnosticError" } },
                        },
                        filters        = {
                                kind = "refactor",
                                str  = "Wrap"
                        }
                })
        end
}
