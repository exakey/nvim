return {
        "snacks.nvim",
        opts = {
                styles = {

                        input = {
                                backdrop = true,
                                row      = 4,
                                wo       = {
                                        cursorline   = false,
                                        winhighlight =
                                        "NormalFloat:SnacksInputNormal,NormalFloat:SnacksInputBorder,FloatBorder:SnacksInputTitle",
                                },
                        },
                },
                input  = {
                        enabled = true,
                        icon    = ">",
                },
        }
}
