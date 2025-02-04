local bkeymap = require("core.utils").bufKeymap
local abbr    = require("core.utils").bufAbbrev

--------------------------------------------------------------------------------
-- FIXES HABITS FROM WRITING TOO MUCH IN OTHER LANGUAGES

abbr("//", "--")
abbr("const", "local")
abbr("let", "local")
abbr("===", "==")
abbr("!=", "~=")
abbr("!==", "~=")
abbr("=~", "~=") -- shell uses `=~`
abbr("fi", "end")

---@param sign "+"|"-"
local function plusPlusMinusMinus(sign)
        local row, col         = unpack(vim.api.nvim_win_get_cursor(0))
        local textBeforeCursor = vim.api.nvim_get_current_line():sub(col - 1, col)
        if not textBeforeCursor:find("%a%" .. sign) then
                vim.api.nvim_feedkeys(sign, "n", true) -- pass through the trigger char
        else
                local line    = vim.api.nvim_get_current_line()
                local updated = line:gsub("(%w+)%" .. sign, "%1 = %1 " .. sign .. " 1")
                vim.api.nvim_set_current_line(updated)
                local diff = #updated - #line
                vim.api.nvim_win_set_cursor(0, { row, col + diff })
        end
end
bkeymap("i", "+", function() plusPlusMinusMinus("+") end, { desc = "i++  i = i + 1" })
bkeymap("i", "-", function() plusPlusMinusMinus("-") end, { desc = "i--  i = i - 1" })

--------------------------------------------------------------------------------
-- AUTO-COMMA FOR TABLES

vim.api.nvim_create_autocmd("TextChangedI", {
        desc     = "User (buffer-specific): auto-comma for tables",
        buffer   = 0,
        group    = vim.api.nvim_create_augroup("lua-autocomma", { clear = true }),
        callback = function()
                local node = vim.treesitter.get_node()
                if node and node:type() == "table_constructor" then
                        local line = vim.api.nvim_get_current_line()
                        if line:find("^%s*[^,%s%-]$") then vim.api.nvim_set_current_line(line .. ",") end
                end
        end,
})

--------------------------------------------------------------------------------
-- REQUIRE MODULE FROM CWD

-- lightweight version of `telescope-import.nvim` import (just for lua)
-- REQUIRED `ripgrep` (optionally `telescope` for selector & syntax highlighting)
bkeymap("n", "<leader>ci", function()
        local isAtBlank = vim.api.nvim_get_current_line():match("^%s*$")

        local regex     = [[local (\w+) = require\(["'](.*?)["']\)(\.[\w.]*)?]]
        local rgArgs    = { "rg", "--no-config", "--only-matching", "--no-filename", regex }
        local rgResult  = vim.system(rgArgs):wait()
        assert(rgResult.code == 0, rgResult.stderr)
        local matches = vim.split(rgResult.stdout, "\n", { trimempty = true })

        -- unique matches only
        table.sort(matches)
        local uniqMatches = vim.fn.uniq(matches) ---@cast uniqMatches string[]

        -- sort by length of varname
        -- (enuring uniqueness needs separate sorting, since this one does not ensure
        -- ensure same items are next to each other)
        table.sort(uniqMatches, function(a, b)
                local varnameA = a:match("local (%S+) ?=")
                local varnameB = b:match("local (%S+) ?=")
                return #varnameA < #varnameB
        end)

        vim.api.nvim_create_autocmd("FileType", {
                desc     = "User (buffer-specific): Set filetype to `lua` for `TelescopeResults`",
                pattern  = "TelescopeResults",
                once     = true,
                callback = function(ctx)
                        vim.bo[ctx.buf].filetype = "lua"
                        -- make discernible as the results are now colored
                        local ns = vim.api.nvim_create_namespace("telescope-import")
                        vim.api.nvim_win_set_hl_ns(0, ns)
                        vim.api.nvim_set_hl(ns, "TelescopeMatching", { reverse = true })
                end,
        })

        vim.ui.select(uniqMatches, { prompt = " require", kind = "telescope" }, function(selection)
                if not selection then return end
                local lnum = vim.api.nvim_win_get_cursor(0)[1]
                if isAtBlank then
                        vim.api.nvim_set_current_line(selection)
                        vim.cmd.normal { "==", bang = true }
                else
                        vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { selection })
                        vim.cmd.normal { "j==", bang = true }
                end
        end)
end, { desc = "󰢱 Import module" })

--------------------------------------------------------------------------------
-- YANK MODULE NAME

bkeymap("n", "<leader>ym", function()
        local absPath = vim.api.nvim_buf_get_name(0)
        local relPath = absPath:sub(#(vim.uv.cwd()) + 2)
        local module  = relPath:gsub("%.lua$", ""):gsub("^lua/", ""):gsub("/", "."):gsub("%.init$", "")
        local req     = ("require(%q)"):format(module)
        vim.fn.setreg("+", req)
        vim.notify(req, nil, { icon = "󰅍", title = "Copied", ft = "lua" })
end, { desc = "󰢱 Module (require)" })

--------------------------------------------------------------------------------
-- REQUIRE MODULE FROM CWD

-- lightweight version of telescope-import.nvim import (just for lua)
-- REQUIRED `ripgrep`
bkeymap("n", "<leader>ci", function()
        local isAtBlank = vim.api.nvim_get_current_line():match("^%s*$")

        local regex = [[local (\w+) = require\(["'](.*?)["']\)(\.[\w.]*)?]]
        local rgArgs = { "rg", "--no-config", "--only-matching", "--no-filename", regex }
        local rgResult = vim.system(rgArgs):wait()
        assert(rgResult.code == 0, rgResult.stderr)
        local matches = vim.split(rgResult.stdout, "\n", { trimempty = true })

        table.sort(matches)
        local uniqMatches = vim.fn.uniq(matches) ---@cast uniqMatches string[]
        table.sort(uniqMatches, function(a, b)
                local varnameA = a:match("local (%S+) ?=")
                local varnameB = b:match("local (%S+) ?=")
                return #varnameA < #varnameB
        end)

        vim.api.nvim_create_autocmd("FileType", {
                desc     = "User (buffer-specific): Set filetype to `lua` for `TelescopeResults`",
                pattern  = "TelescopeResults",
                once     = true,
                callback = function(ctx)
                        vim.bo[ctx.buf].filetype = "lua"
                        -- make discernible as the results are now colored
                        local ns = vim.api.nvim_create_namespace("telescope-import")
                        vim.api.nvim_win_set_hl_ns(0, ns)
                        vim.api.nvim_set_hl(ns, "TelescopeMatching", { reverse = true })
                end,
        })

        vim.ui.select(uniqMatches, { prompt = " require" }, function(selection)
                if not selection then return end
                local lnum = vim.api.nvim_win_get_cursor(0)[1]
                if isAtBlank then
                        vim.api.nvim_set_current_line(selection)
                        vim.cmd.normal { "==", bang = true }
                else
                        vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { selection })
                        vim.cmd.normal { "j==", bang = true }
                end
        end)
end, { desc = " Import module" })

--------------------------------------------------------------------------------
-- LUA SYNTAX HIGHLIGHTING

vim.cmd(" highlight @method                   guifg=#dce0e8 ")
vim.cmd(" highlight Function                  guifg=#dce0e8 ")
vim.cmd(" highlight @keyword.function         guifg=#dce0e8 ")
vim.cmd(" highlight @keyword.function.lua     guifg=#dce0e8 ")
-- vim.cmd(" highlight @Number                   guifg=#eba0ac ")
-- vim.cmd(" highlight @number.lua               guifg=#eba0ac ")
-- vim.cmd(" highlight @variable                 guifg=#f38ba8 ")
-- vim.cmd(" highlight @variable.lua             guifg=#f38ba8 ")
-- vim.cmd(" highlight @variable.lua             guifg=#74c7ec ")
-- vim.cmd(" highlight @variable.builtin         guifg=#f38ba8 ")
-- vim.cmd(" highlight @lsp.type.variable        guifg=#f38ba8 ")
-- vim.cmd(" highlight @variable.member          guifg=#f5e0dc ")
-- vim.cmd(" highlight @variable.member.lua      guifg=#f5e0dc ")
vim.cmd(" highlight @keyword                  guifg=#f9e2af ")
vim.cmd(" highlight @keyword.lua              guifg=#f9e2af ")
vim.cmd(" highlight @keyword.return           guifg=#f38ba8 ")
vim.cmd(" highlight @keyword.return.lua       guifg=#f38ba8 ")
vim.cmd(" highlight @conditional              guifg=#74c7ec ")
vim.cmd(" highlight @keyword.conditional.lua  guifg=#74c7ec ")
-- vim.cmd(" highlight Comment                   guifg=#f2cdcd ")
-- vim.cmd(" highlight @comment                  guifg=#f2cdcd ")
-- vim.cmd(" highlight @lsp.type.comment         guifg=#f2cdcd ")
-- vim.cmd(" highlight @lsp.type.method          guifg=#f2cdcd ")
-- vim.cmd(" highlight @lsp.type.method.lua      guifg=#f2cdcd ")
-- vim.cmd(" highlight @lsp.type.property        guifg=#b4befe ")
-- vim.cmd(" highlight @lsp.type.property.lua    guifg=#b4befe ")
-- vim.cmd(" highlight @punctuation.bracket      guifg=#6c7086 ")
-- vim.cmd(" highlight @punctuation.bracket.lua  guifg=#6c7086 ")
