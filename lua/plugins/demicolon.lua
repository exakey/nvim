return {
        "mawkler/demicolon.nvim",
        enabled = false,
        event = "VeryLazy",
        keys  = { ";", ",", "t", "T", "]", "[", "]d", "[d" },
        opts  = {
                diagnostic = {
                        float = false
                },
                keymaps    = {
                        diagnostic_motions = true
                }
        },
}
