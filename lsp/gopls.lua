vim.lsp.config.gopls = {
        cmd          = { "gopls" },
        root_markers = { ".git", "git" },
        filetypes    = { "go", "gomod", "gowork", "gotmpl" },
        settings     = {
                gopls   = {
                        semanticTokens  = false,
                        usePlaceholders = false,
                        hints           = {
                                assignVariableTypes    = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes  = true,
                                constantValues         = true,
                                functionTypeParameters = true,
                                parameterNames         = true,
                                rangeVariableTypes     = true,
                        }
                },
                gofumpt = true,
        }
}
