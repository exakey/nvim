---@diagnostic disable: redundant-parameter, deprecated
local cmp_kinds = {
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

return {
    {
        "hrsh7th/nvim-cmp",
        enabled      = false,
        event        = { "InsertEnter" },
        dependencies = {
            { "hrsh7th/cmp-calc",     lazy = true },
            { "hrsh7th/cmp-nvim-lsp", lazy = true },
            { "hrsh7th/cmp-nvim-lua", lazy = true },
            { "hrsh7th/cmp-buffer",   lazy = true },
            { "hrsh7th/cmp-path",     lazy = true },
            { "hrsh7th/cmp-cmdline",  lazy = true },
            {
                "onsails/lspkind.nvim",
                config = function()
                    require("lspkind").init({
                        mode       = "symbol_text",
                        preset     = "codicons",
                        symbol_map = cmp_kinds,
                    })
                end,
            },
            "saadparwaiz1/cmp_luasnip",
            event = "VeryLazy",
            {
                "L3MON4D3/LuaSnip",
                event        = "VeryLazy",
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
        },

        config       = function()
            local ls               = require("luasnip")
            local cmp              = require("cmp")
            local compare          = require("cmp.config.compare")
            -- local cmp_autopairs    = require("nvim-autopairs.completion.cmp")
            local cmp_select       = { behavior = cmp.SelectBehavior.Select }
            local custom_menu_icon = { calc = "󰃬" }
            local blend            = 0
            local default_sources  = cmp.config.sources({
                { name = "luasnip",  max_item_count = 20 },
                { name = "nvim_lsp", max_item_count = 40 },
                -- { name = "nvim_lua", max_item_count = 40 },
                { name = "buffer",   max_item_count = 10 },
                { name = "calc",     max_item_count = 2 },
                { name = "path",     max_item_count = 10 },
            })
            cmp.setup({
                matching            = {
                    disallow_fuzzy_matching            = true,
                    disallow_fullfuzzy_matching        = true,
                    disallow_partial_fuzzy_matching    = true,
                    disallow_partial_matching          = false,
                    disallow_prefix_unmatching         = false,
                    disallow_symbol_nonprefix_matching = false,
                },
                sorting             = {
                    priority_weight = 2,
                    comparators     = {
                        compare.score,
                        compare.offset,
                        compare.kind,
                        compare.locality,
                        compare.exact,
                        compare.scopes,
                        compare.recently_used,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                },
                performance         = {
                    debounce                 = 60,
                    throttle                 = 30,
                    fetching_timeout         = 600,
                    filtering_context_budget = 3,
                    confirm_resolve_timeout  = 80,
                    async_budget             = 2,
                    max_view_entries         = 100,
                },
                view                = {
                    entries = { name = "custom", selection_order = "near_cursor" },
                },
                history             = true,
                delete_check_events = "TextChanged",
                completion          = {
                    completeopt = "menu,menuone,noinsert",
                },
                window              = {
                    completion = {
                        -- border       = { "", "", "", "", "", "", "", "" },
                        border       = vim.g.borderStyle,
                        winhighlight = "Normal:CustomPmenu,FloatBorder:CustomBorder,CursorLine:PmenuSel,Search:None",
                        winblend     = blend,
                        scrollbar    = false,
                    },
                    -- documentation = false,
                    documentation = {
                        -- border       = { "", "", "", "", "", "", "", "" },
                        border       = vim.g.borderStyle,
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                        winblend     = blend,
                        scrollbar    = false,
                    },
                },
                snippet             = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                formatting          = {
                    mode                 = "symbol",
                    maxwidth             = {
                        menu = 50,
                        abbr = 30,
                    },
                    ellipsis_char        = "...",
                    show_labelDetails    = true,
                    expandable_indicator = true,
                    fields               = { "kind", "abbr", "menu" },
                    format               = function(entry, item)
                        local completion_item = entry:get_completion_item()
                        local highlights_info =
                            require("colorful-menu").highlights(completion_item, vim.bo.filetype)

                        -- error, such as missing parser, fallback to use raw label.
                        if highlights_info == nil then
                            item.abbr = completion_item.label
                        else
                            item.abbr_hl_group = highlights_info.highlights
                            item.abbr = highlights_info.text
                        end

                        local kind = require("lspkind").cmp_format({ maxwidth = 40 })(entry, item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = "" .. (strings[1] or "") .. " "
                        kind.menu = "   " .. (strings[2] or "")
                        item.kind = string.format("%s", item.kind)
                        if entry.source.name == "calc" then
                            item.kind = custom_menu_icon.calc
                        end
                        item.menu = ({
                            buffer   = "[Buf]",
                            lazydev  = "[LazyDev]",
                            luasnip  = "[LuaSnip]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]",
                            path     = "[Path]",
                        })[entry.source.name]
                        return kind
                    end,
                },
                mapping             = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.config.disable,
                    ["<C-p>"] = cmp.config.disable,
                    ["<C-space>"] = cmp.mapping.confirm({ select = true }, { "i", "c" }),
                    ["<A-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<A-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(cmp_select), { "i", "c" }),
                    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(cmp_select), { "i", "c" }),
                    -- ["<C-x>"] = cmp.mapping(cmp.mapping.select_next_item(cmp_select), { "i", "c" }),
                    -- ["<C-z>"] = cmp.mapping(cmp.mapping.select_prev_item(cmp_select), { "i", "c" }),
                    ['<C-e>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if ls.expandable() then
                                ls.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<A-n>"] = cmp.mapping(function(fallback)
                        if ls.locally_jumpable(1) then
                            ls.jump(1)
                        else
                            fallback()
                        end
                    end, { "n", "i", "s", "x" }),
                    ["<A-p>"] = cmp.mapping(function(fallback)
                        if ls.locally_jumpable(-1) then
                            ls.jump(-1)
                        else
                            fallback()
                        end
                    end, { "n", "i", "s", "x" }),
                    -- Toggle completion menu
                    ["<C-c>"] = cmp.mapping({
                        i = function()
                            if cmp.visible() then
                                cmp.abort()
                            else
                                cmp.complete()
                            end
                        end,
                        c = function()
                            if cmp.visible() then
                                cmp.close()
                            else
                                cmp.complete()
                            end
                        end,
                    }),
                }),

                sources             = default_sources,

                cmp.setup.filetype({ "markdown", "help" }, {
                    sources = {
                        { name = "luasnip", max_item_count = 20 },
                        { name = "buffer",  max_item_count = 10 },
                        { name = "calc",    max_item_count = 2 },
                        { name = "path",    max_item_count = 10 },
                        window = {
                            documentation = cmp.config.disable,
                        },
                    },
                }),

                cmp.setup.filetype({ "lua" }, {
                    sources = {
                        { name = "luasnip",  max_item_count = 20 },
                        { name = "lazydev",  max_item_count = 60 },
                        { name = "nvim_lsp", max_item_count = 60 },
                        { name = "nvim_lua", max_item_count = 40 },
                        { name = "buffer",   max_item_count = 10 },
                        { name = "calc",     max_item_count = 2 },
                        { name = "path",     max_item_count = 10 },
                        window = {
                            documentation = cmp.config.disable,
                        },
                    },
                }),

                cmp.setup.filetype({ "c", "cpp" }, {
                    sources = {
                        { name = "luasnip",  max_item_count = 20 },
                        { name = "nvim_lsp", max_item_count = 60 },
                        { name = "nvim_lua", max_item_count = 40 },
                        { name = "buffer",   max_item_count = 10 },
                        { name = "calc",     max_item_count = 2 },
                        { name = "path",     max_item_count = 10 },
                        window = {
                            documentation = cmp.config.disable,
                        },
                    },
                }),

                cmp.setup.cmdline(":", {
                    mapping = {
                        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                    },
                    sources = {
                        {
                            name = "cmdline",
                            option = {
                                ignore_cmds = { "Man", "!" },
                            },
                        },
                        { name = "path" },
                    },
                    enabled = function()
                        local disabled = {
                            IncRename = true,
                        }
                        local cmd = vim.fn.getcmdline():match("%S+")
                        return not disabled[cmd] or cmp.close()
                    end,
                }),

                cmp.setup.cmdline("/", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "buffer" },
                    },
                }),

                cmp.setup({
                    enabled = function()
                        -- Disable cmp in Telescope prompt
                        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                        if buftype == "prompt" then
                            return false
                        end
                        local context = require("cmp.config.context")
                        if vim.api.nvim_get_mode().mode == "c" then
                            return true
                        else
                            return not context.in_treesitter_capture("comment") and
                                not context.in_syntax_group("Comment")
                        end
                    end,
                }),
                -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()),
            })
        end
    },
}
