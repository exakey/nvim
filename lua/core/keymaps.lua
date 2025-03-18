---@diagnostic disable: missing-parameter
---@diagnostic disable: unused-local

local map              = require("core.utils").uniqueKeymap
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

map(n, "ZZ", "<cmd>qall<CR>", { desc = " Quit" })

local pluginDir = vim.fn.stdpath("data") --[[@as string]]
map(n, "<leader>pd", function() vim.ui.open(pluginDir) end, { desc = "󰝰 Plugin dir" })

--------------------------------------------------------------------------------
-- NAVIGATION

-- j/k should on wrapped lines
map(nx, "j", "gj")
map(nx, "k", "gk")

-- hjkl in INSERT mode
map(i, "<C-h>", "<Left>", { desc = "Left with h in INSERT mode" })
map(i, "<C-j>", "<Down>", { desc = "Down with j in INSERT mode" })
map(i, "<C-k>", "<Up>", { desc = "Up with k in INSERT mode" })
map(i, "<C-l>", "<Right>", { desc = "Right with l in INSERT mode" })

-- Better scroll
map(n, "<C-d>", "<C-d>zz", { desc = "Scroll down half page" })
map(n, "<C-u>", "<C-u>zz", { desc = "Scroll up half a page" })
map(n, "<C-f>", "<C-f>zz", { desc = "Scroll down a page" })
map(n, "<C-b>", "<C-b>zz", { desc = "Scroll up a page" })

-- Search
-- map(n, "-", "/")
-- map(x, "-", "<Esc>/\\%V", { desc = " Search in sel" })
map(n, "n", "nzz", { desc = "Search next" })
map(n, "N", "Nzz", { desc = "Search previous" })
map(ni, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Goto matching parenthesis (`remap` needed to use builtin `MatchIt` plugin)
map(n, "gm", "%", { desc = "󰅪 Goto match", remap = true })

-- Open first URL in file
map(n, "<A-u>", function()
        local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
        local url = text:match([[%l%l%l-://[^%s)"'`]+]])
        if url then
                vim.ui.open(url)
        else
                vim.notify("No URL found in file.", vim.log.levels.WARN)
        end
end, { desc = " Open first URL in file" })

-- make `fF` use `nN` instead of `;,`
map(n, "f", function() require("functions.nano-plugins").fF("f") end, { desc = "f" })
map(n, "F", function() require("functions.nano-plugins").fF("F") end, { desc = "F" })

-- Folds
map(n, "zh", "zczz", { desc = "Close current fold", silent = true })
map(n, "zl", "zozz", { desc = "Open current fold", silent = true })
map(n, "zj", "zjzz", { desc = "Open current fold", silent = true })

-- Move to the end of previous word
map(nv, "W", "ge", { desc = "Jump to the end of previous word" })

-- center Ctrl-o
map(n, "<C-o>", "<C-o>zz", { silent = true })

--------------------------------------------------------------------------------
-- EDITING

-- Undo
map(n, "u", "<cmd>silent undo<CR>zv", { desc = "󰜊 Silent undo" })
map(n, "U", "<cmd>silent redo<CR>zv", { desc = "󰛒 Silent redo" })
map(n, "<leader>uu", ":earlier ", { desc = "󰜊 Undo to earlier" })
map(n, "<leader>ur", function() vim.cmd.later(vim.o.undolevels) end, { desc = "󰛒 Redo all" })

-- Duplicate
map(n, "ww", function() require("functions.nano-plugins").smartDuplicate() end, { desc = "󰲢 Duplicate line" })

-- Toggles
map(n, "~", "v~", { desc = "󰬴 Toggle char case (w/o moving)" })
map(n, "<", function() require("functions.nano-plugins").toggleWordCasing() end, { desc = "󰬴 Toggle lower/Title case" })
-- map(n, ">", "gUiw", { desc = "󰬴 Toggle UPPER case" })

map(n, ">", function()
        require("functions.nano-plugins").camelSnakeToggle()
end, { desc = "󰬴 Toggle camel and snake case" })

-- Delete trailing character
map(n, "<C-S-x>", function()
        local updatedLine = vim.api.nvim_get_current_line():gsub("%S%s*$", "")
        vim.api.nvim_set_current_line(updatedLine)
end, { desc = "󱎘 Delete char at EoL" })

-- Append to EoL
local trailChars = { ",", "\\", "[", "]", "{", "}", ")", ";", "." }
for _, key in pairs(trailChars) do
        local pad = key == "\\" and " " or ""
        map(n, "<leader>" .. key, ("mzA%s%s<Esc>`z"):format(pad, key), { silent = true })
end

-- Whitespace & indentation
map(n, "<CR>", '@="m`o<C-V><Esc>``"<cr>', { desc = " blank below", silent = true })
map(n, "<S-CR>", '@="m`O<C-V><Esc>``"<cr>', { desc = " blank above", silent = true })

map(n, "<Tab>", ">>", { desc = "󰉶 indent" })
map(n, "<S-Tab>", "<<", { desc = "󰉵 outdent" })
map(x, "<Tab>", ">gv", { desc = "󰉶 indent" })
map(x, "<S-Tab>", "<gv", { desc = "󰉵 outdent" })
map(i, "<Tab>", "<C-t>", { desc = "󰉶 indent" })
map(i, "<S-Tab>", "<C-d>", { desc = "󰉵 outdent" })

-- Merging
map(n, "m", "J", { desc = "󰽜 Merge line up" })
map(n, "M", "<cmd>. move +1<CR>kJ", { desc = "󰽜 Merge line down" }) -- `:move` preserves marks

-- Last line
map(n, "G", "Gzz", { desc = "Goto last line" })

-- Make file executable
map(n, "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })

-- Backspace in INSERT mode
map({ "i", "c" }, "<C-d>", "<Backspace>", { desc = "Delete" })

-- Select all
map(n, "<C-q>", "ggVG", { desc = "Select all" })

-- Save file
map(ni, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map(ni, "<C-S-s>", "<cmd>wa<cr><esc>", { desc = "Save File" })

--------------------------------------------------------------------------------
-- SURROUND

map(n, "<A-`>", [[wBi`<Esc>ea`<Esc>b]], { desc = " Inline Code cword" })
map(x, "<A-`>", "<Esc>`<i`<Esc>`>la`<Esc>", { desc = " Inline Code selection" })
map(i, "<A-`>", "``<Left>", { desc = " Inline Code" })

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
map(n, "<C-Space>", '"_ciw', { desc = "󰬞 change word" })
map(x, "<C-Space>", '"_c', { desc = "󰒅 change selection" })
map(n, "<S-Space>", '"_daw', { desc = "󰬞 delete word" })

--------------------------------------------------------------------------------
-- COMMENTS

map(nx, "q", "gc", { desc = "󰆈 Comment operator", remap = true })
map(n, "qq", "gcc", { desc = "󰆈 Comment line", remap = true })
do
        map(o, "u", "gc", { desc = "󰆈 Multiline comment", remap = true })
        map(n, "guu", "guu") -- prevent `omap u` above from overwriting `guu`
end

map(n, "qw", function() require("functions.comment").commentHr() end, { desc = "󰆈 Horizontal Divider" })
map(n, "qy", function() require("functions.comment").duplicateLineAsComment() end,
        { desc = "󰆈 Duplicate Line as Comment" })
map(n, "qf", function() require("functions.comment").docstring() end, { desc = "󰆈 Function Docstring" })
map(n, "Q", function() require("functions.comment").addComment("eol") end, { desc = "󰆈 Append Comment" })
map(n, "qo", function() require("functions.comment").addComment("below") end, { desc = "󰆈 Comment Below" })
map(n, "qO", function() require("functions.comment").addComment("above") end, { desc = "󰆈 Comment Above" })

--------------------------------------------------------------------------------
-- LSP

map(niv, "<C-.>", function() require("functions.quickfix").code_actions() end, { desc = "Quickfix" })
map(nv, "K",   "<cmd>lua vim.lsp.buf.signature_help<CR>zz", { desc = "󰏪 LSP Signature" })
map(nx, "<leader>f", function() require("functions.nano-plugins").formatWithFallback() end, { desc = "󱉯 Format" })
map(nx, "<leader><leader>c", function()
        require("tiny-code-action").code_action()
end, { desc = "Code Action" })

map(n, ",R", function() Snacks.picker.lsp_references() end, { desc = "Goto Reference", silent = true, })
map(n, ",D", vim.lsp.buf.declaration, { desc = "Goto Declaration", silent = true, })
map(n, ",d", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition", silent = true, })
map(n, ",i", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation", silent = true, })
map(n, ",t", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition", silent = true, })
map(n, "<leader><leader>d", function() Snacks.picker.diagnostics_buffer() end,
        { desc = "Show Buffer Diagnostics", silent = true, })
map(n, "<leader><leader>D", function() Snacks.picker.diagnostics() end, { desc = "Show Diagnostics", silent = true, })
map(n, "<leader><leader>r", function() Snacks.picker.lsp_references() end, { desc = "Show Diagnostics", silent = true, })
map(n, "<leader><leader>z", vim.lsp.codelens.get())

do
        map(nx, "<leader>h", vim.lsp.buf.hover, { desc = "󰋽 LSP hover" })
        local function scrollLspWin(lines)
                local winid = vim.b.lsp_floating_preview --> stores id of last `vim.lsp`-generated win
                if not winid or not vim.api.nvim_win_is_valid(winid) then return end
                vim.api.nvim_win_call(winid, function()
                        local topline = vim.fn.winsaveview().topline
                        vim.fn.winrestview { topline = topline + lines }
                end)
        end
        map(n, "<PageDown>", function() scrollLspWin(5) end, { desc = "↓ Scroll LSP window" })
        map(n, "<PageUp>", function() scrollLspWin(-5) end, { desc = "↑ Scroll LSP window" })
end

--------------------------------------------------------------------------------
-- INSERT MODE

map(n, "i", function()
        local lineEmpty = vim.trim(vim.api.nvim_get_current_line()) == ""
        return (lineEmpty and [["_cc]] or "i")
end, { expr = true, desc = "indented i on empty line" })

-- VISUAL MODE
map(x, "V", "j", { desc = "repeated `V` selects more lines" })
map(x, "v", "<C-v>", { desc = "`vv` starts visual block" })

--------------------------------------------------------------------------------
-- INSPECT & EVAL

map(n, "<leader>ih", vim.show_pos, { desc = " Position at cursor" })
map(n, "<leader>it", vim.treesitter.inspect_tree, { desc = " TS tree" })
map(n, "<leader>iq", vim.treesitter.query.edit, { desc = " TS query" })
-- map(n, "<leader>ih", vim.cmd.inspect, { desc = " TS query" })

map(n, "<leader>il", function() require("functions.inspect-and-eval").lspCapabilities() end,
        { desc = "󱈄 LSP capabilities" })
map(n, "<leader>in", function() require("functions.inspect-and-eval").nodeAtCursor() end,
        { desc = " Node at cursor" })
map(n, "<leader>ib", function() require("functions.inspect-and-eval").bufferInfo() end,
        { desc = "󰽙 Buffer info" })
map(nx, "<leader>ie", function() require("functions.inspect-and-eval").evalNvimLua() end,
        { desc = " Eval" })
map(n, "<leader><leader>x", function() require("functions.inspect-and-eval").runFile() end, { desc = "󰜎 Run file" })

--------------------------------------------------------------------------------
-- WINDOWS

-- Create split
map(n, "<A-w>", "<C-W>c", { desc = "Delete Window" })
map(n, "<A-->", "<C-W>s", { desc = "Split Window Below" })
map(n, "<A-Bslash>", "<C-W>v", { desc = "Split Window Right" })

-- Move to window
-- map(n, "<C-h>", "<C-w>h", { desc = "Go to Left Window", })
-- map(n, "<C-j>", "<C-w>j", { desc = "Go to Lower Window", })
-- map(n, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", })
-- map(n, "<C-l>", "<C-w>l", { desc = "Go to Right Window", unique = false })

-- Resize window
local delta = 5
-- map(n, "<C-up>", "<C-w>" .. delta .. "-")
-- map(n, "<C-down>", "<C-w>" .. delta .. "+")
-- map(n, "<C-left>", "<C-w>" .. delta .. "<")
-- map(n, "<C-right>", "<C-w>" .. delta .. ">")

--------------------------------------------------------------------------------
-- BUFFERS & FILES

map(n, "<A-r>", vim.cmd.edit, { desc = "󰽙 Reload buffer" })
map(n, "H", "<cmd>bprevious<cr>zz", { desc = "Prev Buffer" })
map(n, "L", "<cmd>bnext<cr>zz", { desc = "Next Buffer" })

--------------------------------------------------------------------------------
-- MACROS

do
        local reg       = "r"
        local toggleKey = "0"
        map(
                "n",
                toggleKey,
                function() require("functions.nano-plugins").startOrStopRecording(toggleKey, reg) end,
                { desc = "󰃽 Start/stop recording" }
        )
        -- stylua: ignore
        map(n, "c0", function() require("functions.nano-plugins").editMacro(reg) end, { desc = "󰃽 Edit recording" })
        map(n, "9", "@" .. reg, { desc = "󰃽 Play recording" })
end

--------------------------------------------------------------------------------
-- REFACTORING

map(n, "<leader>vr", vim.lsp.buf.rename, { desc = "󰑕 LSP rename" })

map(n, "<leader>fd", ":global //d<Left><Left>", { desc = " delete matching lines" })

map(n, "<leader>rc", function() require("functions.nano-plugins").camelSnakeLspRename() end,
        { desc = "󰑕 LSP rename: camel/snake" })

map(n, "<leader>rq", function()
        local line        = vim.api.nvim_get_current_line()
        local updatedLine = line:gsub("[\"']", function(q) return (q == [["]] and [[']] or [["]]) end)
        vim.api.nvim_set_current_line(updatedLine)
end, { desc = " Switch quotes in line" })

---@param use "spaces"|"tabs"
local function retabber(use)
        vim.bo.expandtab  = use == "spaces"
        vim.bo.shiftwidth = 4
        vim.bo.tabstop    = 4
        vim.cmd.retab { bang = true }
        vim.notify("Now using " .. use)
end
map(n, "<leader>f<Tab>", function() retabber("tabs") end, { desc = "󰌒 Use Tabs" })
map(n, "<leader>f<Space>", function() retabber("spaces") end, { desc = "󱁐 Use Spaces" })

--------------------------------------------------------------------------------
-- TEMPLATE STRINGS

map(i, "<A-t>", function() require("functions.auto-template-str").insertTemplateStr() end,
        { desc = "󰅳 Insert template string" })

--------------------------------------------------------------------------------
-- OPTION TOGGLING

map(n, "<leader>or", "<cmd>set relativenumber!<CR>", { desc = " Relative line numbers" })
map(n, "<leader>on", "<cmd>set number!<CR>", { desc = " Line numbers" })
map(n, "<leader>ow", "<cmd>set wrap!<CR>", { desc = "󰖶 Wrap" })

map(n, "<leader>od", function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled)
end, { desc = "󰋽 Diagnostics" })

map(n, "<leader>oc", function() vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0 end,
        { desc = "󰈉 Conceal" })

map(n, "<leader>oo", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle IDE stuff" })

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
end, { desc = "Reload plugin" })
