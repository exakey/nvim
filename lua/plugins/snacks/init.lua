return {
        "folke/snacks.nvim",
        priority = 1000,
        lazy     = false,
        import   = "plugins.snacks",
        opts     = {
                styles  = {
                        float                = { backdrop = 40 },
                        notification_history = { width = 0.9, height = 0.9 }
                },
                lazygit = { enabled = true },
                words   = { enabled = false },
        },
}
