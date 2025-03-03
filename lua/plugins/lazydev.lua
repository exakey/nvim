return {
        "folke/lazydev.nvim",
        ft           = "lua",
        opts         = {
                library = {
                        -- vim.env.LAZY .. "/luvit-meta/library",
                        "lazy.nvim",
                        "LazyVim",
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
        },
        integrations = {
                lspconfig = true
        },
}
