---@diagnostic disable: missing-parameter
---@diagnostic disable: unused-local

local map              = require("core.utils").uniqueKeymap
local Map              = vim.api.nvim_set_keymap
local n, i, v, o, x, t = "n", "i", "v", "o", "x", "t"


local nx  = { n, x }
local nv  = { n, v }
local ni  = { n, i }
local niv = { n, i, v }

-- vim.g.mapleader = " "
map(nv, "<RightMouse>", function()
        require('menu.utils').delete_old_menus()

        vim.cmd.exec '"normal! \\<RightMouse>"'

        -- clicked buf
        local buf     = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
        local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

        require("menu").open(options, { mouse = true })
end, {})
--------------------------------------------------------------------------------
-- META

map(n, "ZZ", "<cmd>qall<CR>", { desc = " Quit", silent = true })

local pluginDir = vim.fn.stdpath("data") --[[@as string]]
map(n, "<leader>pd", function() vim.ui.open(pluginDir) end, { desc = "󰝰 Plugin dir", silent = true })

--------------------------------------------------------------------------------
-- NAVIGATION

-- j/k should on wrapped lines
map(nx, "j", "gj")
map(nx, "k", "gk")

-- hjkl in INSERT mode
map(i, "<C-h>", "<Left>", { desc = "Left with h in INSERT mode", silent = true })
map(i, "<C-j>", "<Down>", { desc = "Down with j in INSERT mode", silent = true })
map(i, "<C-k>", "<Up>", { desc = "Up with k in INSERT mode", silent = true })
map(i, "<C-l>", "<Right>", { desc = "Right with l in INSERT mode", silent = true })

-- Better scroll
Map(n, "<C-d>", "<C-d>zz", { desc = "Scroll down half page", silent = true })
map(n, "<C-u>", "<C-u>zz", { desc = "Scroll up half a page", silent = true })
map(n, "<C-f>", "<C-f>zz", { desc = "Scroll down a page", silent = true })
map(n, "<C-b>", "<C-b>zz", { desc = "Scroll up a page", silent = true })

-- Search
-- map(n, "-", "/")
-- map(x, "-", "<Esc>/\\%V", { desc = " Search in sel" })
map(n, "n", "nzz", { desc = "Search next", silent = true })
map(n, "N", "Nzz", { desc = "Search previous", silent = true })
map(ni, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "Escape and Clear hlsearch", silent = true })

-- Goto matching parenthesis (`remap` needed to use builtin `MatchIt` plugin)
map(n, "gm", "%", { desc = "󰅪 Goto match", remap = true, silent = true })

-- Open first URL in file
map(n, "<A-u>", function()
        local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
        local url = text:match([[%l%l%l-://[^%s)"'`]+]])
        if url then
                vim.ui.open(url)
        else
                vim.notify("No URL found in file.", vim.log.levels.WARN)
        end
end, { desc = " Open first URL in file", silent = true })

-- make `fF` use `nN` instead of `;,`
map(n, "f", function() require("functions.nano-plugins").fF("f") end, { desc = "f", silent = true })
map(n, "F", function() require("functions.nano-plugins").fF("F") end, { desc = "F", silent = true })

-- Folds
map(n, "zh", "zczz", { desc = "Close current fold", silent = true })
map(n, "zl", "zozz", { desc = "Open current fold", silent = true })
map(n, "zj", "zjzz", { desc = "Open current fold", silent = true })

-- Move to the end of previous word
map(nv, "W", "ge", { desc = "Jump to the end of previous word", silent = true })

-- center Ctrl-o
map(n, "<C-o>", "<C-o>zz", { silent = true, silent = true })

--------------------------------------------------------------------------------
-- EDITING

-- Undo
map(n, "u", "<cmd>silent undo<CR>zv", { desc = "󰜊 Silent undo", silent = true })
map(n, "U", "<cmd>silent redo<CR>zv", { desc = "󰛒 Silent redo", silent = true })
map(n, "<leader>uu", ":earlier ", { desc = "󰜊 Undo to earlier", silent = true })
map(n, "<leader>ur", function() vim.cmd.later(vim.o.undolevels) end, { desc = "󰛒 Redo all", silent = true })

-- Duplicate
map(n, "ww", function() require("functions.nano-plugins").smartDuplicate() end, { desc = "󰲢 Duplicate line", silent = true })

-- Toggles
map(n, "~", "v~", { desc = "󰬴 Toggle char case (w/o moving)", silent = true })
map(n, "<", function() require("functions.nano-plugins").toggleWordCasing() end, { desc = "󰬴 Toggle lower/Title case", silent = true })
-- map(n, ">", "gUiw", { desc = "󰬴 Toggle UPPER case" })

map(n, ">", function()
        require("functions.nano-plugins").camelSnakeToggle()
end, { desc = "󰬴 Toggle camel and snake case", silent = true })

-- Delete trailing character
map(n, "<C-S-x>", function()
        local updatedLine = vim.api.nvim_get_current_line():gsub("%S%s*$", "")
        vim.api.nvim_set_current_line(updatedLine)
end, { desc = "󱎘 Delete char at EoL", silent = true })

-- Append to EoL
local trailChars = { ",", "\\", "[", "]", "{", "}", ")", ";", "." }
for _, key in pairs(trailChars) do
        local pad = key == "\\" and " " or ""
        map(n, "<leader>" .. key, ("mzA%s%s<Esc>`z"):format(pad, key), { silent = true })
end

-- Whitespace & indentation
map(n, "<CR>", '@="m`o<C-V><Esc>``"<cr>', { desc = " blank below", silent = true })
map(n, "<S-CR>", '@="m`O<C-V><Esc>``"<cr>', { desc = " blank above", silent = true })

map(n, "<Tab>", ">>", { desc = "󰉶 indent", silent = true })
map(n, "<S-Tab>", "<<", { desc = "󰉵 outdent", silent = true })
map(x, "<Tab>", ">gv", { desc = "󰉶 indent", silent = true })
map(x, "<S-Tab>", "<gv", { desc = "󰉵 outdent", silent = true })
map(i, "<Tab>", "<C-t>", { desc = "󰉶 indent", silent = true })
map(i, "<S-Tab>", "<C-d>", { desc = "󰉵 outdent", silent = true })

-- Merging
map(n, "m", "J", { desc = "󰽜 Merge line up", silent = true })
map(n, "M", "<cmd>. move +1<CR>kJ", { desc = "󰽜 Merge line down", silent = true }) -- `:move` preserves marks

-- Last line
map(n, "G", "Gzz", { desc = "Goto last line", silent = true })

-- Make file executable
map(n, "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- Backspace in INSERT mode
map({ "i", "c" }, "<C-d>", "<Backspace>", { desc = "Delete", silent = true })

-- Select all
map(n, "<C-v>", "ggVG", { desc = "Select all", silent = true })

-- Save file
map(n, "<C-s>", "<cmd>w<CR>", { desc = "Save File", silent = true })
-- map(ni, "<C-S-s>", "<cmd>wa<CR>", { desc = "Save File", silent = true })

--------------------------------------------------------------------------------
-- SURROUND

map(n, "<A-`>", [[wBi`<Esc>ea`<Esc>b]], { desc = " Inline Code cword", silent = true })
map(x, "<A-`>", "<Esc>`<i`<Esc>`>la`<Esc>", { desc = " Inline Code selection", silent = true })
map(i, "<A-`>", "``<Left>", { desc = " Inline Code", silent = true })

--------------------------------------------------------------------------------
-- TEXTOBJECTS

local textobjRemaps = {
        { "c", "}", "", "curly" },
        { "r", "]", "󰅪", "rectangular" },
        { "m", "W", "󰬞", "WORD" },
        { "q", '"', "", "double" },
        { "z", "'", "", "single" },
        { "e", "`", "", "backtick" },
}
for _, value in pairs(textobjRemaps) do
        local remap, original, icon, label = unpack(value)
        map({ "o", "x" }, "i" .. remap, "i" .. original, { desc = icon .. " inner " .. label })
        map({ "o", "x" }, "a" .. remap, "a" .. original, { desc = icon .. " outer " .. label })
end

-- Special remaps
map(o, "J", "2j")
map(n, "<C-Space>", '"_ciw', { desc = "󰬞 change word", silent = true })
map(x, "<C-Space>", '"_c', { desc = "󰒅 change selection", silent = true })
map(n, "<S-Space>", '"_daw', { desc = "󰬞 delete word", silent = true })
map(x, "<S-Space>", '"_d', { desc = "󰬞 delete selection", silent = true })

--------------------------------------------------------------------------------
-- COMMENTS

map(nx, "q", "gc", { desc = "󰆈 Comment operator", remap = true, silent = true })
map(n, "qq", "gcc", { desc = "󰆈 Comment line", remap = true, silent = true })
do
        map(o, "u", "gc", { desc = "󰆈 Multiline comment", remap = true })
        map(n, "guu", "guu") -- prevent `omap u` above from overwriting `guu`
end

map(n, "qw", function() require("functions.comment").commentHr() end, { desc = "󰆈 Horizontal Divider", silent = true })
map(n, "qy", function() require("functions.comment").duplicateLineAsComment() end,
        { desc = "󰆈 Duplicate Line as Comment", silent = true })
map(n, "qf", function() require("functions.comment").docstring() end, { desc = "󰆈 Function Docstring", silent = true })
map(n, "Q", function() require("functions.comment").addComment("eol") end, { desc = "󰆈 Append Comment", silent = true })
map(n, "qo", function() require("functions.comment").addComment("below") end, { desc = "󰆈 Comment Below", silent = true })
map(n, "qO", function() require("functions.comment").addComment("above") end, { desc = "󰆈 Comment Above", silent = true })

--------------------------------------------------------------------------------
-- LSP

map(niv, "<C-.>", function() require("functions.quickfix").code_actions() end, { desc = "Quickfix", silent = true })
map(nv, "K", function()
        vim.lsp.buf.signature_help()
        vim.cmd("norm zz")
end, { desc = "󰏪 LSP Signature", silent = true })
map(nx, "<leader>f", function() require("functions.nano-plugins").formatWithFallback() end, { desc = "󱉯 Format", silent = true })
map(nx, "<leader><leader>c", function()
        require("tiny-code-action").code_action()
end, { desc = "Code Action", silent = true })

map(n, ",D", "gD", { desc = "Goto Declaration", silent = true })
map(n, ",d", "gd", { desc = "Goto Definition", silent = true })
map(n, ",i", vim.lsp.buf.implementation, { desc = "Goto Definition", silent = true })

do
        map(nx, "<leader>h", vim.lsp.buf.hover, { desc = "󰋽 LSP hover", silent = true })
        local function scrollLspWin(lines)
                local winid = vim.b.lsp_floating_preview --> stores id of last `vim.lsp`-generated win
                if not winid or not vim.api.nvim_win_is_valid(winid) then return end
                vim.api.nvim_win_call(winid, function()
                        local topline = vim.fn.winsaveview().topline
                        vim.fn.winrestview { topline = topline + lines }
                end)
        end
        map(n, "<PageDown>", function() scrollLspWin(5) end, { desc = "↓ Scroll LSP window", silent = true })
        map(n, "<PageUp>", function() scrollLspWin(-5) end, { desc = "↑ Scroll LSP window", silent = true })
end

--------------------------------------------------------------------------------
-- INSERT MODE

map(n, "i", function()
        local lineEmpty = vim.trim(vim.api.nvim_get_current_line()) == ""
        return (lineEmpty and [["_cc]] or "i")
end, { expr = true, desc = "indented i on empty line", silent = true })

-- VISUAL MODE
map(x, "V", "j", { desc = "repeated `V` selects more lines", silent = true })
map(x, "v", "<C-v>", { desc = "`vv` starts visual block", silent = true })

--------------------------------------------------------------------------------
-- INSPECT & EVAL

map(n, "<leader>ih", vim.show_pos, { desc = " Position at cursor", silent = true })
map(n, "<leader>it", vim.treesitter.inspect_tree, { desc = " TS tree", silent = true })
map(n, "<leader>iq", vim.treesitter.query.edit, { desc = " TS query", silent = true })
-- map(n, "<leader>ih", vim.cmd.inspect, { desc = " TS query" })

map(n, "<leader>il", function() require("functions.inspect-and-eval").lspCapabilities() end,
        { desc = "󱈄 LSP capabilities", silent = true })
map(n, "<leader>in", function() require("functions.inspect-and-eval").nodeAtCursor() end,
        { desc = " Node at cursor", silent = true })
map(n, "<leader>ib", function() require("functions.inspect-and-eval").bufferInfo() end,
        { desc = "󰽙 Buffer info", silent = true })
map(nx, "<leader>ie", function() require("functions.inspect-and-eval").evalNvimLua() end,
        { desc = " Eval", silent = true })
map(n, "<leader><leader>x", function() require("functions.inspect-and-eval").runFile() end, { desc = "󰜎 Run file", silent = true })

--------------------------------------------------------------------------------
-- WINDOWS

-- Create split
map(n, "<A-w>", "<C-W>czz", { desc = "Delete Window", silent = true })
map(n, "<A-->", "<C-W>szz", { desc = "Split Window Below", silent = true })
map(n, "<A-Bslash>", "<C-W>vzz", { desc = "Split Window Right", silent = true })

--------------------------------------------------------------------------------
-- BUFFERS & FILES

map(n, "<A-r>", vim.cmd.edit, { desc = "󰽙 Reload buffer", silent = true })
map(n, "H", "<cmd>bprevious<cr>zz", { desc = "Prev Buffer", silent = true })
map(n, "L", "<cmd>bnext<cr>zz", { desc = "Next Buffer", silent = true })

--------------------------------------------------------------------------------
-- MACROS

do
        local reg       = "r"
        local toggleKey = "0"
        map(
                "n",
                toggleKey,
                function() require("functions.nano-plugins").startOrStopRecording(toggleKey, reg) end,
                { desc = "󰃽 Start/stop recording", silent = true }
        )
        -- stylua: ignore
        map(n, "c0", function() require("functions.nano-plugins").editMacro(reg) end, { desc = "󰃽 Edit recording", silent = true })
        map(n, "9", "@" .. reg, { desc = "󰃽 Play recording", silent = true })
end

--------------------------------------------------------------------------------
-- REFACTORING

map(n, "<leader>vr", vim.lsp.buf.rename, { desc = "󰑕 LSP rename", silent = true })

map(n, "<leader>fd", ":global //d<Left><Left>", { desc = " delete matching lines", silent = true })

map(n, "<leader>rc", function() require("functions.nano-plugins").camelSnakeLspRename() end,
        { desc = "󰑕 LSP rename: camel/snake", silent = true })

map(n, "<leader>rq", function()
        local line        = vim.api.nvim_get_current_line()
        local updatedLine = line:gsub("[\"']", function(q) return (q == [["]] and [[']] or [["]]) end)
        vim.api.nvim_set_current_line(updatedLine)
end, { desc = " Switch quotes in line", silent = true })

---@param use "spaces"|"tabs"
local function retabber(use)
        vim.bo.expandtab  = use == "spaces"
        vim.bo.shiftwidth = 4
        vim.bo.tabstop    = 4
        vim.cmd.retab { bang = true }
        vim.notify("Now using " .. use)
end
map(n, "<leader>f<Tab>", function() retabber("tabs") end, { desc = "󰌒 Use Tabs", silent = true })
map(n, "<leader>f<Space>", function() retabber("spaces") end, { desc = "󱁐 Use Spaces", silent = true })

--------------------------------------------------------------------------------
-- TEMPLATE STRINGS

map(i, "<A-t>", function() require("functions.auto-template-str").insertTemplateStr() end,
        { desc = "󰅳 Insert template string", silent = true })

--------------------------------------------------------------------------------
-- OPTION TOGGLING

map(n, "<leader>or", "<cmd>set relativenumber!<CR>", { desc = " Relative line numbers", silent = true })
map(n, "<leader>on", "<cmd>set number!<CR>", { desc = " Line numbers", silent = true })
map(n, "<leader>ow", "<cmd>set wrap!<CR>", { desc = "󰖶 Wrap", silent = true })

map(n, "<leader>od", function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled)
end, { desc = "󰋽 Diagnostics", silent = true })

map(n, "<leader>oc", function() vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0 end,
        { desc = "󰈉 Conceal", silent = true })

map(n, "<leader>oo", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle IDE stuff", silent = true })

--------------------------------------------------------------------------------
-- RELOAD PLUGINS

map(n, "<leader>lr", function()
        local plugins      = require("lazy").plugins()
        local plugin_names = {}
        for _, plugin in ipairs(plugins) do
                table.insert(plugin_names, plugin.name)
        end

        vim.ui.select(
                plugin_names,
                { title = "Reload plugin" },
                function(selected)
                        require("lazy").reload({ plugins = { selected } })
                end
        )
end, { desc = "Reload plugin", silent = true })
