return {
        "roobert/action-hints.nvim",
        event = "VeryLazy",
        opts  = {
                template = {
                        definition = { text = " ■", color = "#add8e6" },
                        references = { text = " ↱%s", color = "#ff6666" },
                },
                use_virtual_text = true
        },
}
