return {
        "snacks.nvim",
        opts = {
                styles = {
                        notification = {
                                wo      = { winblend = 40 },
                                icons   = { error = " ■", warn = " ■", info = " ■", debug = " ■", trace = " ■" },
                                enabled = true,
                                timeout = 2000,
                                style   = "minimal",
                        },
                },
                notifier = {
                        icons   = { error = " ■", warn = " ■", info = " ■", debug = " ■", trace = " ■" },
                        style   = "minimal",
                        enabled = true,
                        timeout = 2000,
                },
        }
}
