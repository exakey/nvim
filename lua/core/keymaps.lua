---@diagnostic disable: missing-parameter
local map = require("core.utils").uniqueKeymap

-- vim.g.mapleader = " "
map({ "n", "v" }, "<RightMouse>", function()
        require('menu.utils').delete_old_menus()

        vim.cmd.exec '"normal! \\<RightMouse>"'

        -- clicked buf
        local buf     = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
        local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

        require("menu").open(options, { mouse = true })
end, {})
--------------------------------------------------------------------------------------------------------------------------------------------
-- META

map("n", "ZZ", "<cmd>qall<CR>", { desc = " Quit" })

local pluginDir = vim.fn.stdpath("data") --[[@as string]]
map("n", "<leader>pd", function() vim.ui.open(pluginDir) end, { desc = "󰝰 Plugin dir" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- NAVIGATION

-- j/k should on wrapped lines
map({ "n", "x" }, "j", "gj")
map({ "n", "x" }, "k", "gk")

-- hjkl in INSERT mode
map("i", "<C-h>", "<Left>", { desc = "Left with h in INSERT mode" })
map("i", "<C-j>", "<Down>", { desc = "Down with j in INSERT mode" })
map("i", "<C-k>", "<Up>", { desc = "Up with k in INSERT mode" })
map("i", "<C-l>", "<Right>", { desc = "Right with l in INSERT mode" })

-- Better scroll
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Search
map("n", "-", "/")
map("x", "-", "<Esc>/\\%V", { desc = " Search in sel" })
map("n", "n", "nzz", { desc = "Search next" })
map("n", "N", "Nzz", { desc = "Search previous" })
map({ "i", "n" }, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Goto matching parenthesis (`remap` needed to use builtin `MatchIt` plugin)
map("n", "gm", "%", { desc = "󰅪 Goto match", remap = true })

-- Open first URL in file
map("n", "<A-u>", function()
        local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
        local url = text:match([[%l%l%l-://[^%s)"'`]+]])
        if url then
                vim.ui.open(url)
        else
                vim.notify("No URL found in file.", vim.log.levels.WARN)
        end
end, { desc = " Open first URL in file" })

-- make `fF` use `nN` instead of `;,`
map("n", "f", function() require("functions.misc").fF("f") end, { desc = "f" })
map("n", "F", function() require("functions.misc").fF("F") end, { desc = "F" })

-- Move to the end of previous word
map({ "n", "v" }, "W", "ge", { desc = "Jump to the end of previous word" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- EDITING

-- Undo
map("n", "u", "<cmd>silent undo<CR>zv", { desc = "󰜊 Silent undo" })
map("n", "U", "<cmd>silent redo<CR>zv", { desc = "󰛒 Silent redo" })
map("n", "<leader>uu", ":earlier ", { desc = "󰜊 Undo to earlier" })
map("n", "<leader>ur", function() vim.cmd.later(vim.o.undolevels) end, { desc = "󰛒 Redo all" })

-- Duplicate
-- stylua: ignore
-- map("n", "ww", function() require("functions.misc").smartDuplicate() end, { desc = "󰲢 Duplicate line" })

-- Toggles
map("n", "~", "v~", { desc = "󰬴 Toggle char case (w/o moving)" })
map("n", "<", function() require("functions.misc").toggleTitleCase() end, { desc = "󰬴 Toggle lower/Title case" })
-- map("n", ">", "gUiw", { desc = "󰬴 Toggle UPPER case" })

map("n", ">", function()
        require("functions.nano-plugins").camelSnakeToggle()
end, { desc = "󰬴 Toggle camel and snake case" })

-- Delete trailing character
map("n", "<A-x>", function()
        local updatedLine = vim.api.nvim_get_current_line():gsub("%S%s*$", "")
        vim.api.nvim_set_current_line(updatedLine)
end, { desc = "󱎘 Delete char at EoL" })

-- Append to EoL
local trailChars = { ",", "\\", "{", "}", ")", ";", "." }
for _, key in pairs(trailChars) do
        local pad = key == "\\" and " " or ""
        map("n", "<leader>" .. key, ("mzA%s%s<Esc>`z"):format(pad, key))
end

-- Whitespace & indentation
map("n", "<CR>", '@="m`o<C-V><Esc>``"<cr>', { desc = " blank below", silent = true })
map("n", "<S-CR>", '@="m`O<C-V><Esc>``"<cr>', { desc = " blank above", silent = true })

map("n", "<Tab>", ">>", { desc = "󰉶 indent" })
map("n", "<S-Tab>", "<<", { desc = "󰉵 outdent" })
map("x", "<Tab>", ">gv", { desc = "󰉶 indent" })
map("x", "<S-Tab>", "<gv", { desc = "󰉵 outdent" })
map("i", "<Tab>", "<C-t>", { desc = "󰉶 indent" })
map("i", "<S-Tab>", "<C-d>", { desc = "󰉵 outdent" })

-- Spelling (these work even with `spell=false`)
map("n", "z.", "1z=", { desc = "󰓆 Fix spelling" })
-- stylua: ignore
map("n", "zl", function() require("functions.misc").spellSuggest(9) end, { desc = "󰓆 Spell suggestions" })

-- Merging
map("n", "m", "J", { desc = "󰽜 Merge line up" })
map("n", "M", "<cmd>. move +1<CR>kJ", { desc = "󰽜 Merge line down" }) -- `:move` preserves marks

-- Last line
map("n", "G", "Gzz", { desc = "Goto last line" })

-- Make file executable
map("n", "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })

-- Backspace in INSERT mode
map({ "i", "c" }, "<C-d>", "<Backspace>", { desc = "Delete" })

-- Select all
map("n", "<C-q>", "ggVG", { desc = "Select all" })

-- Save file
map({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "i", "n" }, "<A-s>", "<cmd>wa<cr><esc>", { desc = "Save File" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- SURROUND

-- map("n", '"', [[wBi"<Esc>ea"<Esc>b]], { desc = ' " surround cword' })
-- map("n", "'", [[wBi'<Esc>ea'<Esc>b]], { desc = " ' surround cword" })
-- map("n", "(", [[wBi(<Esc>ea)<Esc>b]], { desc = "󰅲 surround cword" })
-- map("n", "[", [[wBi[<Esc>ea]<Esc>b]], { desc = "󰅪 surround cword", nowait = true })
-- map("n", "{", [[wBi{<Esc>ea}<Esc>b]], { desc = " surround cword" })
map("n", "<A-e>", [[wBi`<Esc>ea`<Esc>b]], { desc = " Inline Code cword" })
map("x", "<A-e>", "<Esc>`<i`<Esc>`>la`<Esc>", { desc = " Inline Code selection" })
map("i", "<A-e>", "``<Left>", { desc = " Inline Code" })

--------------------------------------------------------------------------------------------------------------------------------------------
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
map("o", "J", "2j")
map("n", "<C-Space>", '"_ciw', { desc = "󰬞 change word" })
map("x", "<C-Space>", '"_c', { desc = "󰒅 change selection" })
map("n", "<S-Space>", '"_daw', { desc = "󰬞 delete word" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- COMMENTS

map({ "n", "x" }, "q", "gc", { desc = "󰆈 Comment operator", remap = true })
map("n", "qq", "gcc", { desc = "󰆈 Comment line", remap = true })
do
        map("o", "u", "gc", { desc = "󰆈 Multiline comment", remap = true })
        map("n", "guu", "guu") -- prevent `omap u` above from overwriting `guu`
end

map("n", "qw", function() require("functions.comment").commentHr() end, { desc = "󰆈 Horizontal Divider" })
map("n", "qy", function() require("functions.comment").duplicateLineAsComment() end,
        { desc = "󰆈 Duplicate Line as Comment" })
map("n", "qf", function() require("functions.comment").docstring() end, { desc = "󰆈 Function Docstring" })
map("n", "Q", function() require("functions.comment").addComment("eol") end, { desc = "󰆈 Append Comment" })
map("n", "qo", function() require("functions.comment").addComment("below") end, { desc = "󰆈 Comment Below" })
map("n", "qO", function() require("functions.comment").addComment("above") end, { desc = "󰆈 Comment Above" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- LINE & CHARACTER MOVEMENT

map("n", "<A-h>", [["zdh"zph]], { desc = "󰜱 Move char left" })
map("n", "<A-j>", [[<cmd>. move +1<CR>==]], { desc = "󰜮 Move line down" })
map("n", "<A-k>", [[<cmd>. move -2<CR>==]], { desc = "󰜷 Move line up" })
map("n", "<A-l>", [["zx"zp]], { desc = "󰜴 Move char right" })
map("x", "<A-h>", [["zxhh"zpgvhoho]], { desc = "󰜱 Move selection left" })
map("x", "<A-j>", [[:move '>+1<CR>gv=gv]], { desc = "󰜮 Move selection down", silent = true })
map("x", "<A-k>", [[:move '<-2<CR>gv=gv]], { desc = "󰜷 Move selection up", silent = true })
map("x", "<A-l>", [["zx"zpgvlolo]], { desc = "󰜴 Move selection right" })

--------------------------------------------------------------------------------
-- LSP
map({ "n", "i", "v" }, "<A-i>", vim.lsp.buf.signature_help, { desc = "󰏪 LSP Signature" })
-- map({ "n", "x" }, "<C-s>", function() require("functions.misc").formatWithFallback() end, { desc = "󱉯 Save & Format" })
map({ "n", "x" }, "<leader><leader>c", function()
        require("tiny-code-action").code_action()
end, { desc = "󰒕 Code Action" })

do
        map({ "n", "x" }, "<leader>h", vim.lsp.buf.hover, { desc = "󰋽 LSP hover" })

        local function scrollLspWin(lines)
                local winid = vim.b.lsp_floating_preview --> stores id of last `vim.lsp`-generated win
                if not winid or not vim.api.nvim_win_is_valid(winid) then return end
                vim.api.nvim_win_call(winid, function()
                        local topline = vim.fn.winsaveview().topline
                        vim.fn.winrestview { topline = topline + lines }
                end)
        end
        map("n", "<PageDown>", function() scrollLspWin(5) end, { desc = "↓ Scroll LSP window" })
        map("n", "<PageUp>", function() scrollLspWin(-5) end, { desc = "↑ Scroll LSP window" })
end

--------------------------------------------------------------------------------

-- INSERT MODE
map("n", "i", function()
        local lineEmpty = vim.trim(vim.api.nvim_get_current_line()) == ""
        return (lineEmpty and [["_cc]] or "i")
end, { expr = true, desc = "indented i on empty line" })

-- VISUAL MODE
map("x", "V", "j", { desc = "repeated `V` selects more lines" })
map("x", "v", "<C-v>", { desc = "`vv` starts visual block" })

--------------------------------------------------------------------------------
-- INSPECT & EVAL

map("n", "<leader>ip", vim.show_pos, { desc = " Position at cursor" })
map("n", "<leader>it", vim.treesitter.inspect_tree, { desc = " TS tree" })
map("n", "<leader>iq", vim.treesitter.query.edit, { desc = " TS query" })
-- map("n", "<leader>ih", vim.cmd.inspect, { desc = " TS query" })

map("n", "<leader>il", function() require("functions.inspect-and-eval").lspCapabilities() end,
        { desc = "󱈄 LSP capabilities" })
map("n", "<leader>in", function() require("functions.inspect-and-eval").nodeAtCursor() end,
        { desc = " Node at cursor" })
map("n", "<leader>ib", function() require("functions.inspect-and-eval").bufferInfo() end,
        { desc = "󰽙 Buffer info" })
map({ "n", "x" }, "<leader>ie", function() require("functions.inspect-and-eval").evalNvimLua() end,
        { desc = " Eval" })
map("n", "<leader><leader>x", function() require("functions.inspect-and-eval").runFile() end, { desc = "󰜎 Run file" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- WINDOWS

-- Create split
map("n", "<A-w>", "<C-W>c", { desc = "Delete Window" })
map("n", "<A-->", "<C-W>s", { desc = "Split Window Below" })
map("n", "<A-Bslash>", "<C-W>v", { desc = "Split Window Right" })

-- Move to window
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", })
-- map("n", "<w-j>", "<C-w>j", { desc = "Go to Lower Window", })
-- map("n", "<w-k>", "<C-w>k", { desc = "Go to Upper Window", })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", unique = false })

-- Resize window
local delta = 5
map("n", "<C-up>", "<C-w>" .. delta .. "-")
map("n", "<C-down>", "<C-w>" .. delta .. "+")
map("n", "<C-left>", "<C-w>" .. delta .. "<")
map("n", "<C-right>", "<C-w>" .. delta .. ">")

--------------------------------------------------------------------------------------------------------------------------------------------
-- BUFFERS & FILES

-- do
--         -- stylua: ignore
--         map({ "n", "x" }, "<CR>", function() require("functions.alt-alt").gotoAltFile() end,
--                 { desc = "󰬈 Goto alt-file" })
--         vim.api.nvim_create_autocmd("FileType", {
--                 desc = "User: restore default behavior of `<CR>` for quickfix buffers.",
--                 pattern = "qf",
--                 callback = function(ctx) vim.keymap.set("n", "<CR>", "<CR>", { buffer = ctx.buf }) end,
--         })
-- end

map("n", "<A-r>", vim.cmd.edit, { desc = "󰽙 Reload buffer" })
map("n", "H", "<cmd>bprevious<cr>zz", { desc = "Prev Buffer" })
map("n", "L", "<cmd>bnext<cr>zz", { desc = "Next Buffer" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- MACROS

do
        local reg = "r"
        local toggleKey = "0"
        map(
                "n",
                toggleKey,
                function() require("functions.misc").startOrStopRecording(toggleKey, reg) end,
                { desc = "󰃽 Start/stop recording" }
        )
        -- stylua: ignore
        map("n", "c0", function() require("functions.misc").editMacro(reg) end, { desc = "󰃽 Edit recording" })
        map("n", "9", "@" .. reg, { desc = "󰃽 Play recording" })
end

--------------------------------------------------------------------------------------------------------------------------------------------
-- REFACTORING

map("n", "<leader>vr", vim.lsp.buf.rename, { desc = "󰑕 LSP rename" })

map("n", "<leader>fd", ":global //d<Left><Left>", { desc = " delete matching lines" })

map("n", "<leader>rc", function() require("functions.misc").camelSnakeLspRename() end,
        { desc = "󰑕 LSP rename: camel/snake" })

map("n", "<leader>rq", function()
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
map("n", "<leader>f<Tab>", function() retabber("tabs") end, { desc = "󰌒 Use Tabs" })
map("n", "<leader>f<Space>", function() retabber("spaces") end, { desc = "󱁐 Use Spaces" })

--------------------------------------------------------------------------------

-- TEMPLATE STRINGS

map("i", "<A-t>", function() require("functions.auto-template-str").insertTemplateStr() end,
        { desc = "󰅳 Insert template string" })

-- MULTI-EDIT
-- map("n", "<D-j>", '*N"_cgn', { desc = "󰆿 Multi-edit cword" })
-- map("x", "<D-j>", function()
--     local selection = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = "v" })[1]
--     vim.fn.setreg("/", "\\V" .. vim.fn.escape(selection, [[/\]]))
--     return '<Esc>"_cgn'
-- end, { desc = "󰆿 Multi-edit selection", expr = true })

--------------------------------------------------------------------------------------------------------------------------------------------
-- OPTION TOGGLING

map("n", "<leader>on", "<cmd>set number!<CR>", { desc = " Line numbers" })
map("n", "<leader>ow", "<cmd>set wrap!<CR>", { desc = "󰖶 Wrap" })

map("n", "<leader>od", function()
        local isEnabled = vim.diagnostic.is_enabled { bufnr = 0 }
        vim.diagnostic.enable(not isEnabled, { bufnr = 0 })
end, { desc = "󰋽 Diagnostics" })

map("n", "<leader>oc", function() vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0 end,
        { desc = "󰈉 Conceal" })

--------------------------------------------------------------------------------------------------------------------------------------------
-- PLUGINS

-- TELESCOPE
map("n", "<leader><leader><leader>", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find old files" })
map("n", "<leader><leader>f", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
map("n", "<leader><leader>b", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find opened buffers" })
map("n", "<leader><leader>d", "<cmd>Telescope diagnostics<cr>", { desc = "Fuzzy find diagnostics" })
map("n", "<leader><leader>h", "<cmd>Telescope highlights<cr>", { desc = "Fuzzy find highlight groups" })
map("n", "<leader><leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find text in cwd" })
map("n", "<leader><leader>s", "<cmd>Telescope grep_string<cr>", { desc = "Fuzzy find string under cursor" })

-- TREE
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Tree" })
map("n", "<leader>fe", "<cmd>Neotree toggle filesystem selector=false<cr>", { desc = "Tree" })
map("n", "<leader>ge", "<cmd>Neotree toggle git_status selector=false<cr>", { desc = "Git status" })
map("n", "<leader>be", "<cmd>Neotree toggle buffers selector=false<cr>", { desc = "Buffers" })
-- map("n", "<leader>de", "<cmd>Neotree toggle document_symbols selector=false right<cr>", { desc = "Symbols" })

-- UNDOTREE
map("n", "<leader>ut", "<cmd>UndotreeToggle<cr>", { desc = "Undo tree" })

-- SYMBOLS
map("n", "<C-o>", "<cmd>Outline<cr>", { desc = "Outline" })

-- WINSHIFT
map("n", "<leader>w", "<Cmd>WinShift<cr>", { desc = "Start Win-Move mode" })
map("n", "<leader>wt", "<Cmd>WindowsToggleAutowidth<cr>", { desc = "Toggle window autowidth" })

--------------------------------------------------------------------------------
-- DROPBAR
-- vim.keymap.set("n", "<A-q>", require('dropbar.api').dropbar_api.pick())
