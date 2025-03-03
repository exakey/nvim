local nodeMode = function(ctx)
        local success, node = pcall(vim.treesitter.get_node)
        if vim.bo.filetype == 'lua' then
                return { 'lsp', 'path' }
        elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                return { 'buffer' }
        else
                return { 'lsp', 'path', 'snippets', 'buffer' }
        end
end

local normalBuf = function()
        return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ''
        end, vim.api.nvim_list_bufs())
end

return {
        "saghen/blink.cmp",
        event        = { "InsertEnter" },
        build        = "cargo build --release",

        dependencies = {
                {
                        "L3MON4D3/LuaSnip",
                        -- version      = "v2.*",
                        dependencies = {
                                "rafamadriz/friendly-snippets",
                                config = function()
                                        require('luasnip.loaders.from_vscode').lazy_load()
                                end
                        },
                        config       = function() require('luasnip') end,
                },
        },

        opts         = {
                snippets   = { preset = "luasnip" },

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
                                selection = { preselect = false, auto_insert = false },
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
                                                kind_icon   = {
                                                        text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                                                },
                                                source_name = {
                                                        text = function(ctx) return "[" .. ctx.source_name .. "]" end,
                                                },
                                        }
                                }
                        },
                        documentation = { auto_show = true, auto_show_delay_ms = 250 },
                        ghost_text    = { enabled = false },
                        trigger       = { prefetch_on_insert = true }
                },

                sources    = {
                        per_filetype = { ["rip-substitute"] = { "buffer" }, gitcommit = {} },
                        -- default      = nodeMode,
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
                                        score_offset = 80,
                                        enabled      = function()
                                                if vim.bo.ft ~= "lua" then return true end

                                                local col                 = vim.api.nvim_win_get_cursor(0)[2]
                                                local charsBefore         = vim.api.nvim_get_current_line():sub(col - 2,
                                                        col)
                                                local luadocButNotComment = not charsBefore:find("^%-%-?$")
                                                    and not charsBefore:find("%s%-%-?")
                                                return luadocButNotComment
                                        end,
                                },

                                snippets = {
                                        name = "Snip",
                                        score_offset = 90,
                                },

                                path     = {
                                        name         = "Path",
                                        module       = 'blink.cmp.sources.path',
                                        score_offset = 110,
                                        opts         = {
                                                trailing_slash               = true,
                                                label_trailing_slash         = true,
                                                -- get_cwd                      = function(context)
                                                --         return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
                                                -- end,
                                                show_hidden_files_by_default = false,
                                        }
                                },

                                buffer   = {
                                        name               = "Buf",
                                        score_offset       = 60,
                                        max_items          = 8,
                                        min_keyword_length = 3,
                                        opts               = {
                                                -- get_bufnrs = normalBuf,
                                                get_bufnrs = vim.api.nvim_list_bufs,
                                        }
                                }
                        },
                },

                keymap     = {
                        preset        = "none",
                        ["<C-h>"]     = { "snippet_backward", "fallback" },
                        ["<C-l>"]     = { "snippet_forward", "fallback" },
                        ["<C-j>"]     = { "select_next", "fallback" },
                        ["<C-k>"]     = { "select_prev", "fallback" },
                        ["<C-c>"]     = { function(cmp) if cmp.is_menu_visible() then cmp.hide() else cmp.show() end end },
                        ["<C-Space>"] = {
                                function(cmp)
                                        if cmp.is_menu_visible() then
                                                cmp.accept()
                                                cmp.hide()
                                        else
                                                cmp.show()
                                        end
                                end
                        },
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

                signature  = { enabled = false, window = { scrollbar = false } },
        },
        opts_extend  = { "sources.default" }
}
