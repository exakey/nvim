-- ABBREVIATIONS
local abbr = require("core.utils").bufAbbrev

abbr("//", "#")
abbr("delay", "sleep")
abbr("const", "local")
abbr("~=", "=~") -- lua uses `=~`

--------------------------------------------------------------------------------
-- KEYMAPS
local bkeymap = require("core.utils").bufKeymap

bkeymap("n", "<A-s>", function()
    vim.cmd([[% substitute_/Users/\w\+/_$HOME/_e]]) -- replace `/Users/…` with `$HOME/`
    vim.lsp.buf.format()
end, { desc = " Format" })
