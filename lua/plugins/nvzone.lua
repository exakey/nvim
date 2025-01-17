return {
        {
                "nvzone/typr",
                cmd          = "TyprStats",
                dependencies = "nvzone/volt",
                opts         = {}
        },
        {
                "nvzone/menu",
                lazy         = true,
                dependencies = { "nvzone/volt" },
        },
        {
                "nvzone/minty",
                cmd          = { "Shades", "Huefy" },
                dependencies = { "nvzone/volt" },
        }
}
