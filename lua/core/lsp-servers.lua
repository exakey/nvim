local M             = {}
--------------------------------------------------------------------------------
-- DOCS https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
--------------------------------------------------------------------------------

---since nvim-lspconfig and mason.nvim use different package names
---mappings from https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
---@type table<string, string>
local lspToMasonMap = {
        asm_lsp               = "asm-lsp",
        basedpyright          = "basedpyright",                  -- python lsp (fork of pyright)
        bashls                = "bash-language-server",          -- also used for zsh
        biome                 = "biome",                         -- ts/js/json/css linter/formatter
        css_variables         = "css-variables-language-server", -- support css variables across multiple files
        cssls                 = "css-lsp",
        clangd                = "clangd",
        efm                   = "efm",                   -- linter/formatter integration
        emmet_language_server = "emmet-language-server", -- css/html snippets
        -- gh_actions_ls         = "gh-actions-language-server",
        gopls                 = "gopls",
        glsl_analyzer         = "glsl_analyzer",
        html                  = "html-lsp",
        jsonls                = "json-lsp",
        jdtls                 = "jdtls",
        -- ltex_plus             = "ltex-ls-plus",               -- ltex-fork, languagetool (natural language linter)
        lua_ls                = "lua-language-server",
        marksman              = "marksman",                   -- markdown lsp
        ruff                  = "ruff",                       -- python linter & formatter
        stylelint_lsp         = "stylelint-lsp",              -- css linter
        -- stylua3p_ls           = "lua-3p-language-servers",    -- stylua wrapper
        taplo                 = "taplo",                      -- toml lsp
        ts_ls                 = "typescript-language-server", -- also used for javascript
        ts_query_ls           = "ts_query_ls",                -- tree-sitter queries
        -- typos_lsp             = "typos-lsp",                  -- spellchecker for code
        yamlls                = "yaml-language-server",
}

---@module "lspconfig"
---@class myLspConfig : lspconfig.Config
---@field cmd? string -- make this optional

---@type table<string, myLspConfig>
M.serverConfigs     = {}
for lspName, _ in pairs(lspToMasonMap) do
        M.serverConfigs[lspName] = {}
end

--------------------------------------------------------------------------------

local extraDependencies                   = {
        "shfmt",        -- used by bashls for formatting
        "shellcheck",   -- used by bashls/efm for diagnostics, PENDING https://github.com/bash-lsp/bash-language-server/issues/663
        "stylua",       -- lua-3p-ls
        "markdown-toc", -- efm
        "markdownlint", -- efm
}

-- for auto-installation via `mason-tool-installer`
M.masonDependencies                       = vim.list_extend(extraDependencies, vim.tbl_values(lspToMasonMap))

--------------------------------------------------------------------------------
-- EFM

-- DOCS https://github.com/mattn/efm-langserver#configuration-for-neovim-builtin-lsp-with-nvim-lspconfig
local asmfmt                              = {
        formatCommand = "asmfmt",
        formatStdin   = true
}

local lua                                 = {
        {
                formatCommand =
                -- "stylua --search-parent-directories --stdin-filepath='${INPUT}' --respect-ignores -",
                "lua-format -c ~/.config/nvim/lua-format.yaml",
                formatStdin   = true,
                rootMarkers   = { "stylua.toml", ".stylua.toml", "lua-format.yaml", ".lua-format.yaml" },
        },
}

local shfmt                               = {
        {
                formatCommand = "shfmt",
                formatStdin   = true,
                rootMarkers   = { ".editorconfig" }
        }
}

local clang                               = {
        { formatCommand = "clang-format", formatStdin = true, rootMarkers = { "clang-format", ".clang-format" } },
}

local go                                  = {
        { formatCommand = "gofmt",     formatStdin = true },
        { formatCommand = "goimports", formatStdin = true },
}

local markdown                            = {
        { -- HACK use `cat` due to https://github.com/mattn/efm-langserver/issues/258
                formatCommand = "markdown-toc --indent=$'\t' -i '${INPUT}' && cat '${INPUT}'",
                formatStdin   = false,
        },
        { -- HACK use `cat` due to https://github.com/mattn/efm-langserver/issues/258
                formatCommand = "markdownlint --fix '${INPUT}' && cat '${INPUT}'",
                rootMarkers   = { ".markdownlint.yaml" },
                formatStdin   = false,
        },
        {
                lintSource         = "markdownlint",
                lintCommand        = "markdownlint --stdin",
                lintIgnoreExitCode = true,
                lintStdin          = true,
                lintSeverity       = 3, -- 3: info, 2: warning
                lintFormats        = { "%f:%l:%c %m", "%f:%l %m", "%f: %l: %m" },
        },
}

local prettier                            = {
        { formatCommand = "prettierd '${INPUT}'", formatStdin = false, rootMarkers = { "prettierrc.json", ".prettierrc.json" } },
        { formatCommand = "prettier",             formatStdin = false, rootMarkers = { "prettierrc.json", ".prettierrc.json" } },
}

local python                              = {
        { formatCommand = "ruff ", formatStdin = true, rootMarkers = ".git/" },
        { formatCommand = "isort", formatStdin = true, rootMarkers = ".git/" },
        { formatCommand = "black", formatStdin = true, rootMarkers = ".git/" },
}

local efmConfig                           = {
        -- lua      = lua,
        -- asm        = asmfmt,
        bash       = shfmt,
        zsh        = shfmt,
        go         = go,
        c          = clang,
        cpp        = clang,
        glsl       = clang,
        markdown   = markdown,
        jsonc      = prettier,
        json       = prettier,
        html       = prettier,
        css        = prettier,
        javascript = prettier,
        py         = python
}

M.serverConfigs.efm                       = {
        -- cleanup useless empty folder `efm` creates on startup
        on_attach    = function() os.remove(vim.fs.normalize("~/.config/efm-langserver")) end,

        filetypes    = vim.tbl_keys(efmConfig),
        settings     = { languages = efmConfig },
        init_options = { documentFormatting = true },
        root_dir     = function()
                local allRootMarkers = vim.iter(vim.tbl_values(efmConfig))
                    :flatten()
                    :map(function(config) return config.rootMarkers end)
                    :flatten()
                    :totable()
                return vim.fs.root(0, allRootMarkers)
        end,
}

--------------------------------------------------------------------------------
-- ASM
M.serverConfigs.asm_lsp                   = {
        filetypes = { "nasm", "asm" }
}

--------------------------------------------------------------------------------
-- BASH / ZSH

-- DOCS https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
M.serverConfigs.bashls                    = {
        filetypes = { "bash", "sh", "zsh" }, -- force it to work in zsh as well
        settings  = {
                bashIde = {
                        includeAllWorkspaceSymbols = true,
                        globPattern                = "**/*@(.sh|.bash)",
                        shellcheckArguments        = "--shell=bash",
                },
        },
}

--------------------------------------------------------------------------------
-- GO

M.serverConfigs.gopls                     = {
        settings = {
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

--------------------------------------------------------------------------------
-- C/C++

M.serverConfigs.clangd                    = {
        settings = {
                clangd = {
                        InlayHints    = {
                                Designators    = true,
                                Enabled        = true,
                                ParameterNames = true,
                                DeducedTypes   = true,
                        },
                        fallbackFlags = { "-std=c++20" },
                },
        },
}

--------------------------------------------------------------------------------
-- GLSL

M.serverConfigs.glsl_analyzer             = {}

--------------------------------------------------------------------------------
-- LUA

-- DOCS https://luals.github.io/wiki/settings/
-- M.serverConfigs.lua_ls                    = {}
M.serverConfigs.lua_ls                    = {
        settings = {
                Lua = {
                        completion  = {
                                callSnippet    = "Replace", -- functions -> no replace snippet
                                keywordSnippet = "Replace", -- keywords -> replace
                                showWord       = "Disable", -- already done by completion plugin
                                workspaceWord  = false,     -- already done by completion plugin
                                postfix        = ".",       -- useful for `table.insert` and the like
                        },
                        diagnostics = {
                                disable = {
                                        -- formatter already handles that
                                        "trailing-space",
                                        -- don't dim content of unused functions
                                        -- (no loss of diagnostic, used `unused-local` will still inform
                                        -- us about these functions)
                                        "unused-function",
                                },
                        },
                        hint        = { -- inlay hints
                                enable     = true,
                                setType    = true,
                                arrayIndex = "Disable", -- too noisy
                                semicolon  = "Disable", -- mostly wrong on invalid code
                        },
                        format      = {
                                enable = false, -- using `stylua` instead
                        },
                        -- FIX https://github.com/sumneko/lua-language-server/issues/679#issuecomment-925524834
                        workspace   = { checkThirdParty = "Disable" },
                },
        },
}

--------------------------------------------------------------------------------
-- PYTHON

-- DOCS https://docs.astral.sh/ruff/editors/settings/
M.serverConfigs.ruff                      = {
        init_options = {
                settings = {
                        organizeImports = false,                                       -- if "I" ruleset is added, already included in "fixAll"
                        codeAction      = { disableRuleComment = { enable = false } }, -- using nvim-rulebook instead
                },
        },
        -- disable in favor of basedpyright's hover info
        on_attach    = function(ruff) ruff.server_capabilities.hoverProvider = false end,
}

--------------------------------------------------------------------------------
-- CSS

-- DOCS
-- https://github.com/sublimelsp/LSP-css/blob/master/LSP-css.sublime-settings
-- https://github.com/microsoft/vscode-css-languageservice/blob/main/src/services/lintRules.ts
M.serverConfigs.cssls                     = {
        -- using `biome` instead (this key overrides `settings.format.enable = true`)
        init_options = { provideFormatter = false },

        settings     = {
                css = {
                        lint = {
                                vendorPrefix        = "ignore", -- needed for scrollbars
                                duplicateProperties = "warning",
                                zeroUnits           = "warning",
                        },
                },
        },
}

M.serverConfigs.css_variables             = {
        -- Add `biome.jsonc` as root marker for Obsidian snippet folders
        root_dir = function() return vim.fs.root(0, { "biome.jsonc", ".git" }) end,
}

-- DOCS https://github.com/bmatcuk/stylelint-lsp#settings
M.serverConfigs.stylelint_lsp             = {
        settings = {
                stylelintplus = { autoFixOnFormat = true },
        },
}

-- DOCS https://github.com/olrtg/emmet-language-server#neovim
M.serverConfigs.emmet_language_server     = {
        init_options = {
                showSuggestionsAsSnippets = true,
        },
}

--------------------------------------------------------------------------------
-- JS/TS

-- DOCS https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
M.serverConfigs.ts_ls                     = {
        settings = {
                -- "Cannot re-declare block-scoped variable" -> not useful for single-file-JXA
                -- (biome works only on single-file and so already check for unintended re-declarations.)
                diagnostics                  = { ignoredCodes = { 2451 } },

                typescript                   = {
                        inlayHints = {
                                includeInlayEnumMemberValueHints                      = true,
                                includeInlayFunctionLikeReturnTypeHints               = true,
                                includeInlayFunctionParameterTypeHints                = true,
                                includeInlayParameterNameHints                        = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayPropertyDeclarationTypeHints              = true,
                                includeInlayVariableTypeHints                         = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName      = true,
                        },
                        -- even with formatting disabled still relevant for `organizeImports` code-action
                        format     = { convertTabsToSpaces = false },
                },

                -- enable checking javascript without a `jsconfig.json`
                -- DOCS https://www.typescriptlang.org/tsconfig
                implicitProjectConfiguration = { checkJs = true, target = "ES2022" },
        },
        on_attach = function(client)
                -- disable formatting in favor of biome
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
        end,
}
M.serverConfigs.ts_ls.settings.javascript = M.serverConfigs.ts_ls.settings.typescript

--------------------------------------------------------------------------------
-- JSON & YAML

-- DOCS https://github.com/Microsoft/vscode/tree/main/extensions/json-language-features/server#configuration
M.serverConfigs.jsonls                    = {
        -- Disable formatting in favor of biome
        init_options = {
                provideFormatter                = false,
                documentRangeFormattingProvider = false,
        },
}

-- DOCS https://github.com/redhat-developer/yaml-language-server/tree/main#language-server-settings
M.serverConfigs.yamlls                    = {
        settings = {
                yaml = {
                        format = {
                                enable     = true,
                                printWidth = 100,
                                proseWrap  = "always",
                        },
                },
        },
}

--------------------------------------------------------------------------------
-- LTEX (LanguageTool LSP)

-- DOCS of the original https://valentjn.github.io/ltex/settings.html
-- DOCS of the fork https://ltex-plus.github.io/ltex-plus/settings.html
M.serverConfigs.ltex_plus                 = {
        filetypes = { "markdown" },
        settings  = {
                ltex = {
                        language           = "en-US", -- can also be set per file via markdown yaml header (e.g. `de-DE`)
                        dictionary         = {
                                -- HACK since reading external file does not work https://github.com/ltex-plus/ltex-ls-plus/issues/56
                                -- ["en-US"] = vim.o.spellfile and vim.iter(io.lines(vim.o.spellfile)):totable() or {},
                        },

                        diagnosticSeverity = { default = "info" },
                        disabledRules      = {
                                ["en-US"] = {
                                        "EN_QUOTES",       -- don't expect smart quotes
                                        "WHITESPACE_RULE", -- too many false positives
                                },
                        },
                        additionalRules    = {
                                enablePickyRules = true,
                                mothersTongue = "de-DE",
                        },
                        markdown           = {
                                nodes = { Link = "dummy" }, -- don't check link text
                        },
                },
        },
        ---@type fun(client: vim.lsp.Client, bufnr: number)
        on_attach = function(client, bufnr)
                -- have `zg` update ltex' dictionary file as well as vim's spellfile
                vim.keymap.set({ "n", "x" }, "zg", function()
                        local word
                        if vim.fn.mode() == "n" then
                                word = vim.fn.expand("<cword>")
                                vim.cmd.normal { "zg", bang = true } -- do regular `zg` from vim
                        else
                                vim.cmd.normal { 'zggv"zy', bang = true }
                                word = vim.fn.getreg("z")
                        end
                        local ltexSettings = client.config.settings or {}
                        table.insert(ltexSettings.ltex.dictionary["en-US"], word)
                        vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = ltexSettings })
                end, { desc = "󰓆 Add Word", buffer = bufnr })
        end,
}

-- TYPOS
-- DOCS https://github.com/tekumara/typos-lsp/blob/main/docs/neovim-lsp-config.md
-- M.serverConfigs.typos_lsp                 = {
--         init_options = { diagnosticSeverity = "Hint" },
-- }

--------------------------------------------------------------------------------
return M
