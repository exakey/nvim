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
                { "bydlw98/blink-cmp-env" },
                { "MahanRahmati/blink-nerdfont.nvim" },
                { "niuiic/blink-cmp-rg.nvim" }
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
                                                        ellipsis = true,
                                                        text     = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
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

                fuzzy      = {
                        implementation = "prefer_rust_with_warning",
                        use_frecency   = true,
                        use_proximity  = true,
                        sorts          = { "score", "sort_text" }
                },

                cmdline    = {
                        enabled    = true,
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
                        sources    = function()
                                local type = vim.fn.getcmdtype()
                                -- Search forward and backward
                                if type == '/' or type == '?' then return { 'buffer' } end
                                -- Commands
                                if type == ':' or type == '@' then return { 'cmdline' } end
                                return {}
                        end,
                        completion = {
                                trigger = {
                                        show_on_blocked_trigger_characters   = {},
                                        show_on_x_blocked_trigger_characters = {},
                                },
                                list    = {
                                        selection = {
                                                preselect   = false,
                                                auto_insert = false,
                                        },
                                },
                                menu    = { auto_show = false },
                        },
                },

                sources    = {
                        per_filetype = { ["rip-substitute"] = { "ripgrep" }, gitcommit = {} },
                        default      = function(ctx)
                                local success, node = pcall(vim.treesitter.get_node)
                                if vim.bo.filetype == "lua" then
                                        return { "snippets", "lazydev", "lsp", "path", "ripgrep", "nerdfont" }
                                elseif vim.bo.filetype == "c" or "cpp" then
                                        return { "snippets", "lazydev", "lsp", "path", "buffer", "nerdfont" }
                                elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
                                        return { "ripgrep" }
                                else
                                        return { "snippets", "lsp", "path", "ripgrep", "nerdfont" }
                                end
                        end,

                        providers    = {

                                lazydev  = {
                                        name         = "LazyDev",
                                        module       = "lazydev.integrations.blink",
                                        score_offset = 220,
                                },

                                snippets = {
                                        name         = "Snip",
                                        score_offset = 160,
                                },

                                lsp      = {
                                        name         = "LSP",
                                        module       = "blink.cmp.sources.lsp",
                                        score_offset = 140,
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

                                path     = {
                                        name         = "Path",
                                        module       = 'blink.cmp.sources.path',
                                        score_offset = 110,
                                        opts         = {
                                                trailing_slash               = true,
                                                label_trailing_slash         = true,
                                                get_cwd                      = function(context)
                                                        return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
                                                end,
                                                show_hidden_files_by_default = true,
                                        }
                                },

                                buffer   = {
                                        name               = "Buf",
                                        score_offset       = 60,
                                        max_items          = 8,
                                        min_keyword_length = 1,
                                        opts               = {
                                                get_bufnrs = vim.api.nvim_list_bufs,
                                                -- get_bufnrs = function()
                                                --         return vim.tbl_filter(function(bufnr)
                                                --                 return vim.bo[bufnr].buftype == ''
                                                --         end, vim.api.nvim_list_bufs())
                                                -- end
                                        }
                                },

                                omni     = {
                                        name         = "Omni",
                                        module       = "blink.cmp.sources.complete_func",
                                        score_offset = 60,
                                        opts         = {
                                                disable_omnifunc = { "v:lua.vim.lsp.omnifunc" }
                                        }
                                },

                                env      = {
                                        name         = "Env",
                                        module       = "blink-cmp-env",
                                        max_items    = 10,
                                        score_offset = 10,
                                        opts         = {
                                                show_braces               = true,
                                                show_documentation_window = true,
                                        }
                                },

                                nerdfont = {
                                        module       = "blink-nerdfont",
                                        name         = "Nerd",
                                        score_offset = 200,
                                        opts         = { insert = true }
                                },

                                ripgrep  = {
                                        module       = "blink-cmp-rg",
                                        name         = "RG",
                                        score_offset = 60,
                                        max_items    = 20,
                                        opts         = {
                                                prefix_min_len = 3,
                                                get_command    = function(context, prefix)
                                                        return {
                                                                "rg",
                                                                "--no-config",
                                                                "--json",
                                                                "--word-regexp",
                                                                "--smart-case",
                                                                "--",
                                                                prefix .. "[\\w_-]+",
                                                                vim.fs.root(0, ".git") or vim.fn.getcwd(),
                                                        }
                                                end,
                                                get_prefix     = function(context)
                                                        return context.line:sub(1, context.cursor[2]):match("[%w_-]+$") or
                                                            ""
                                                end,
                                        }
                                }
                        },
                },

                keymap     = {
                        preset        = "none",
                        ["<A-h>"]     = { "snippet_backward", "fallback" },
                        ["<A-l>"]     = { "snippet_forward", "fallback" },
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
