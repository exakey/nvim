return {
        "Wansmer/symbol-usage.nvim",
        -- lazy   = false,
        -- even   = "BufReadPre",
        keys   = { { "<leader>os", function() require("symbol-usage").toggle_globally() end, desc = "Toggle symbol usage signs", mode = { "n" } } },
        config = function()
                local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

                vim.api.nvim_set_hl(0, "SymbolUsageRef",
                        { fg = h("Normal").bg, bg = h("@function.macro").fg, bold = true })
                vim.api.nvim_set_hl(0, "SymbolUsageRefRound", { fg = h("@function.macro").fg })

                vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Normal").bg, bg = h("Type").fg, bold = true })
                vim.api.nvim_set_hl(0, "SymbolUsageDefRound", { fg = h("Type").fg })

                vim.api.nvim_set_hl(0, "SymbolUsageImpl",
                        { fg = h("Normal").bg, bg = h("DiagnosticError").fg, bold = true })
                vim.api.nvim_set_hl(0, "SymbolUsageImplRound", { fg = h("DiagnosticError").fg })

                local function box(symbol)
                        local res = {}

                        -- Indicator that shows if there are any other symbols in the same line
                        local stacked_functions_content = symbol.stacked_count > 0
                            and ("+%s"):format(symbol.stacked_count)
                            or ""

                        if symbol.references then
                                table.insert(res, { "█", "SymbolUsageRefRound" })
                                table.insert(res, { "󰌹 " .. tostring(symbol.references), "SymbolUsageRef" })
                                table.insert(res, { "█", "SymbolUsageRefRound" })
                        end

                        if symbol.definition then
                                if #res > 0 then
                                        table.insert(res, { " ", "NonText" })
                                end
                                table.insert(res, { "█", "SymbolUsageDefRound" })
                                table.insert(res, { " " .. tostring(symbol.definition), "SymbolUsageDef" })
                                table.insert(res, { "█", "SymbolUsageDefRound" })
                        end

                        if symbol.implementation then
                                if #res > 0 then
                                        table.insert(res, { " ", "NonText" })
                                end
                                table.insert(res, { "█", "SymbolUsageImplRound" })
                                table.insert(res, { " " .. tostring(symbol.implementation), "SymbolUsageImpl" })
                                table.insert(res, { "█", "SymbolUsageImplRound" })
                        end

                        if stacked_functions_content ~= "" then
                                if #res > 0 then
                                        table.insert(res, { " ", "NonText" })
                                end
                                table.insert(res, { "█", "SymbolUsageImplRound" })
                                table.insert(res, { " " .. tostring(stacked_functions_content), "SymbolUsageImpl" })
                                table.insert(res, { "█", "SymbolUsageImplRound" })
                        end

                        return res
                end

                require("symbol-usage").setup({
                        references           = { enabled = true, include_declaration = true },
                        definition           = { enabled = true },
                        implementation       = { enabled = true },
                        vt_position          = "end_of_line",
                        vt_priority          = 1,     -- gitsigns have priority of 6
                        request_pending_text = false, -- disable "loading…"
                        text_format          = box,

                        kinds                = {
                                vim.lsp.protocol.SymbolKind.File,
                                vim.lsp.protocol.SymbolKind.Function,
                                vim.lsp.protocol.SymbolKind.Method,
                                vim.lsp.protocol.SymbolKind.Class,
                                vim.lsp.protocol.SymbolKind.Interface,
                                vim.lsp.protocol.SymbolKind.Object,
                                vim.lsp.protocol.SymbolKind.Array,
                                vim.lsp.protocol.SymbolKind.Property,
                        },
                })
        end
}
