return {
        "saghen/blink.cmp",
        event        = { "InsertEnter" },
        dependencies = {
                -- "rafamadriz/friendly-snippets",
                -- "L3MON4D3/LuaSnip",
        },
        build        = "cargo build --release",

        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts         = {
                snippets   = { preset = "default" },
                completion = {
                        keyword       = { range = "prefix" },
                        accept        = {
                                auto_brackets = {
                                        enabled                   = true,
                                        default_brackets          = { "(", ")" },
                                        semantic_token_resolution = { enabled = true, timeout_ms = 400 },
                                },
                        },
                        list          = {
                                selection = { preselect = true, auto_insert = false },
                                cycle     = { from_bottom = true, from_top = true }
                        },
                        menu          = {
                                min_width  = 30,
                                max_height = 20,
                                winblend   = 0,
                                scrolloff  = 3,
                                scrollbar  = false,
                                auto_show  = function(ctx) return ctx.mode ~= 'cmdline' end,
                                draw       = {
                                        treesitter = { "lsp" },
                                        columns    = {
                                                { "kind_icon",   gap = 1 },
                                                { "label",       gap = 1 },
                                                { "source_name", gap = 1 },
                                                { "kind",        gap = 1 },
                                        },
                                        components = {
                                                kind_icon = {
                                                        text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                                                },
                                                source_name = {
                                                        text = function(ctx) return "[" .. ctx.source_name .. "]" end
                                                },
                                        }
                                }
                        },
                        documentation = { auto_show = true, auto_show_delay_ms = 250 },
                        ghost_text    = { enabled = false },
                        trigger       = { prefetch_on_insert = true }
                },
                sources    = {
                        per_filetype = {
                                ["rip-substitute"] = { "buffer" },
                                gitcommit          = {},
                        },
                        default      = { "snippets", "lazydev", "lsp", "path", "buffer" },
                        providers    = {
                                lazydev  = {
                                        name         = "LazyDev",
                                        module       = "lazydev.integrations.blink",
                                        score_offset = 140,
                                },
                                lsp      = {
                                        name         = "LSP",
                                        module       = "blink.cmp.sources.lsp",
                                        score_offset = 90,
                                        -- fallback     = {},
                                        enabled      = function()
                                                if vim.bo.ft ~= "lua" then return true end

                                                -- prevent useless suggestions when typing `--` in lua, but
                                                -- keep the useful `---@param;@return` suggestion
                                                local col                 = vim.api.nvim_win_get_cursor(0)[2]
                                                local charsBefore         = vim.api.nvim_get_current_line():sub(col - 2, col)
                                                local luadocButNotComment = not charsBefore:find("^%-%-?$")
                                                    and not charsBefore:find("%s%-%-?")
                                                return luadocButNotComment
                                        end,

                                },
                                snippets = {
                                        name         = "Snip",
                                        score_offset = 80,
                                },
                                path     = {
                                        name         = "Path",
                                        score_offset = 110
                                },
                                buffer   = {
                                        name               = "Buf",
                                        score_offset       = 60,
                                        max_items          = 4,
                                        min_keyword_length = 4,
                                        opts               = {
                                                get_bufnrs = function()
                                                        return vim.tbl_filter(function(bufnr)
                                                                return vim.bo[bufnr].buftype == ''
                                                        end, vim.api.nvim_list_bufs())
                                                end
                                        }
                                }
                        },
                },
                keymap     = {
                        preset        = "none",
                        ["<C-c>"]     = { "show" },
                        ["<C-e>"]     = { "hide" },
                        ["<C-k>"]     = { "select_prev", "fallback" },
                        ["<C-j>"]     = { "select_next", "fallback" },
                        ["<C-Space>"] = { "select_and_accept" },
                },
                appearance = {
                        nerd_font_variant = "mono",
                        kind_icons        = {
                                Class         = "",
                                Color         = "",
                                Constant      = "",
                                Constructor   = "",
                                Enum          = "",
                                EnumMember    = "",
                                Event         = "",
                                Field         = "",
                                File          = "",
                                Folder        = "",
                                Function      = "",
                                Interface     = "",
                                Variable      = "",
                                Value         = "",
                                Unit          = "",
                                Keyword       = "",
                                Module        = "",
                                Method        = "",
                                Operator      = "",
                                Property      = "",
                                Reference     = "",
                                Snippet       = "",
                                Struct        = "",
                                Text          = "",
                                TypeParameter = "",
                        }
                },
                signature  = { enabled = true, window = { scrollbar = false } },
        },
}
