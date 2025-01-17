return {     -- better `:substitute`
    "chrisgrieser/nvim-rip-substitute",
    cmd  = "RipSubstitute",
    keys = {
        {
            "<leader>fs",
            function() require("rip-substitute").sub() end,
            mode = { "n", "x" },
            desc = " substitute (rip-sub)",
        },
        {
            "<leader>fS",
            function() require("rip-substitute").rememberCursorWord() end,
            desc = " remember cword (rip-sub)",
        },
    },
    opts = {
        popupWin        = {
            border                  = vim.g.borderStyle,
            hideSearchReplaceLabels = true,
        },
        prefill         = {
            startInReplaceLineIfPrefill = true,
            alsoPrefillReplaceLine      = false,
        },
        keymaps         = {
            insertModeConfirm = "<CR>",
        },
        editingBehavior = {
            autoCaptureGroups = true,
        },
    },
}
