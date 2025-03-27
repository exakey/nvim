return {
        "neovim/nvim-lspconfig",
        enabled = true,
        event   = "BufReadPre",
        keys    = {
                { "<leader>ol", vim.cmd.LspRestart, desc = "󰑓 LSP restart" },
        },
        config  = function()
                -- local capabilities          = vim.lsp.protocol.make_client_capabilities()
                local capabilities          = vim.tbl_deep_extend("force", {},
                        vim.lsp.protocol.make_client_capabilities())

                -- completion capabilities (blink.cmp)
                local blinkInstalled, blink = pcall(require, "blink.cmp")
                if blinkInstalled then capabilities = blink.get_lsp_capabilities() end

                local myServerConfigs = require("core.lsp-servers").serverConfigs
                for lsp, config in pairs(myServerConfigs) do
                        config.capabilities = capabilities
                        require("lspconfig")[lsp].setup(config)
                end
        end,
}
