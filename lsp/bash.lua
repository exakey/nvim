vim.lsp.config.bashls = {
        cmd          = { "bash-language-server start", "start" },
        root_markers = { ".git", "git" },
        filetypes    = { "bash", "sh", "zsh" },
        settings     = {
                bashIde = {
                        includeAllWorkspaceSymbols = true,
                        globPattern                = "**/*@(.sh|.bash)",
                        shellcheckArguments        = "--shell=bash",
                },
        },
}
