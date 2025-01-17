-- EDITOR
vim.cmd(" highlight MatchParen guifg=#f38ba8 guibg=NONE ")
vim.cmd(" highlight CursorLine guifg=NONE    guibg=NONE ")
vim.cmd(" highlight IncSearch  guifg=#11111b guibg=#f38ba8 ")
-- vim.cmd(" highlight lCursor    guifg=#11111b guibg=#f38ba8 ")
-- vim.cmd(" highlight TermCursor guifg=#11111b guibg=#f38ba8 ")
-- vim.cmd(" highlight CursorIM   guifg=#11111b guibg=#f38ba8 ")

--------------------------------------------------------------------------------
-- LUA SYNTAX

vim.cmd(" highlight @method                   guifg=#dce0e8 ")
vim.cmd(" highlight Function                  guifg=#dce0e8 ")
vim.cmd(" highlight @keyword.function         guifg=#dce0e8 ")
vim.cmd(" highlight @keyword.function.lua     guifg=#dce0e8 ")
-- vim.cmd(" highlight @Number                   guifg=#eba0ac ")
-- vim.cmd(" highlight @number.lua               guifg=#eba0ac ")
-- vim.cmd(" highlight @variable                 guifg=#f38ba8 ")
-- vim.cmd(" highlight @variable.lua             guifg=#f38ba8 ")
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

--------------------------------------------------------------------------------
-- C/C++ SYNTAX

vim.cmd(" highlight cBlock                                   guifg=#cdd6f4 ")
vim.cmd(" highlight cRepeat                                  guifg=#74c7ec ")
vim.cmd(" highlight cConditional                             guifg=#74c7ec ")
vim.cmd(" highlight cInclude                                 guifg=#f38ba8 ")

vim.cmd(" highlight @lsp.type.function.cpp                   guifg=#dce0e8 ")
vim.cmd(" highlight @lsp.type.method.cpp                     guifg=#dce0e8 ")
vim.cmd(" highlight @function.cpp                            guifg=#dce0e8 ")
-- vim.cmd(" highlight @lsp.type.operator.cpp                   guifg=#89dceb ")
vim.cmd(" highlight @keyword.conditional.cpp                 guifg=#74c7ec ")
vim.cmd(" highlight @keyword.repeat.cpp                      guifg=#74c7ec ")
vim.cmd(" highlight @lsp.type.namespace.cpp                  guifg=#f38ba8 ")
vim.cmd(" highlight @lsp.typemod.variable.defaultLibrary.cpp guifg=#f9e2af ")
vim.cmd(" highlight @lsp.typemod.function.defaultLibrary.cpp guifg=#f9e2af ")

vim.cmd(" highlight @lsp.type.function.c                     guifg=#dce0e8 ")
vim.cmd(" highlight @lsp.type.method.c                       guifg=#dce0e8 ")
vim.cmd(" highlight @function.c                              guifg=#dce0e8 ")
vim.cmd(" highlight @lsp.type.operator.c                     guifg=#cdd6f4 ")
vim.cmd(" highlight @keyword.conditional.c                   guifg=#74c7ec ")
vim.cmd(" highlight @keyword.repeat.c                        guifg=#74c7ec ")
vim.cmd(" highlight @lsp.type.namespace.c                    guifg=#f38ba8 ")
vim.cmd(" highlight @lsp.typemod.variable.defaultLibrary.c   guifg=#f9e2af ")
vim.cmd(" highlight @lsp.typemod.function.defaultLibrary.c   guifg=#f9e2af ")

-- vim.cmd(" highlight @lsp.type.variable.cpp                guifg=#f38ba8 ")
-- vim.cmd(" highlight @keyword.cpp                          guifg=#f9e2af ")
-- vim.cmd(" highlight @lsp.type.parameter.cpp               guifg=#b4befe ")

-- vim.cmd("highlight @punctuation.bracket.cpp               guifg=#f2cdcd")
-- vim.cmd("highlight @lsp.type.operator.cpp                 guifg=#f2cdcd")

--------------------------------------------------------------------------------
-- SHELL SYNTAX

vim.cmd(" highlight @keyword.conditional.bash guifg=#74c7ec ")
vim.cmd(" highlight @keyword.repeat.bash      guifg=#74c7ec ")
vim.cmd(" highlight @variable.parameter.bash  guifg=#b4befe ")
vim.cmd(" highlight @function.call.bash       guifg=#f38ba8 ")
vim.cmd(" highlight @variable.bash            guifg=#cba6f7 ")

vim.cmd(" highlight zshConditional            guifg=#74c7ec ")
vim.cmd(" highlight zshCommands               guifg=#f38ba8 ")
vim.cmd(" highlight zshFunction               guifg=#cba6f7 ")
vim.cmd(" highlight zshVariableDef            guifg=#cba6f7 ")
vim.cmd(" highlight zshBrackets               guifg=#6c7086 ")
vim.cmd(" highlight zshParentheses            guifg=#6c7086 ")
