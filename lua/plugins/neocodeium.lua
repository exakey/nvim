return {
        "monkoose/neocodeium",
        enabled = false,
        lazy    = false,
        config  = function()
                local neocodeium = require("neocodeium")
                neocodeium.setup({
                        bin        = ".codeium/bin/1.26.0/language_server_linux_x64",
                        silent     = true,
                        enabled    = true,
                        show_label = true,
                        manual     = true,
                        debounce   = false,
                        max_lines  = -1,
                })
                vim.keymap.set("i", "<A-a>", function()
                        neocodeium.accept()
                end)
                vim.keymap.set("i", "<A-w>", function()
                        neocodeium.accept_word()
                end)
                -- vim.keymap.set("i", "<A-q>", function()
                --         neocodeium.accept_line()
                -- end)
                vim.keymap.set("i", "<A-c>", function()
                        neocodeium.clear()
                end)
                vim.keymap.set("i", "<A-.>", function()
                        neocodeium.cycle_or_complete()
                end)
                vim.keymap.set("i", "<A-,>", function()
                        neocodeium.cycle_or_complete(-1)
                end)
        end,
}
