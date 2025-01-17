return {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            automatic_installation = false,
            ensure_installed = {
                "bashls",
                "clangd",
                "cssls",
                "jsonls",
                "lua_ls",
            }
        })
    end
}
