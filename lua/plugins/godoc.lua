return {
        "fredrikaverpil/godoc.nvim",
        event   = "VeryLazy",
        version = "*",
        build   = "go install github.com/lotusirous/gostdsym/stdsym@latest",
        cmd     = { "GoDoc" },
        opts    = {
                window       = {
                        type = "vsplit",
                },
                highlighting = {
                        language = "go",
                },
                picker       = {
                        type = "snacks",
                        snacks_options = {
                                layout = {
                                        layout = {
                                                height = 0.8,
                                                width  = 0.9,
                                                box    = "horizontal",
                                                {
                                                        box    = "vertical",
                                                        width  = 0.3,
                                                        border = "rounded",
                                                        { win = "input", height = 1,     border = "bottom" },
                                                        { win = "list",  border = "none" },
                                                },
                                                { win = "preview", border = "rounded", width = 0.7 },
                                        },
                                },
                                win    = {
                                        preview = {
                                                wo = { wrap = true },
                                        },
                                },
                        },
                }
        },
}
