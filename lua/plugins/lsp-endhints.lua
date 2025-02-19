return { -- display type hints at EoL, not in the middle of a line
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts  = {
                icons = {
                        type      = "󰜁 ",
                        parameter = "󰏪 ",
                        offspec   = " ", -- hint kind not defined in official LSP spec
                        unknown   = "? ", -- hint kind is nil
                },
                label = { sameKindSeparator = " " },
        },
        keys  = {
                { "<leader>oh", function() require("lsp-endhints").toggle() end, desc = "󰑀 Endhints" },
        },
}
