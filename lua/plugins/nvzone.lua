return {
        {
                "nvzone/typr",
                cmd          = "TyprStats",
                dependencies = "nvzone/volt",
                opts         = {}
        },
        {
                "nvzone/menu",
                dependencies = { "nvzone/volt" },
        },
        {
                "nvzone/minty",
                cmd          = { "Shades", "Huefy" },
                dependencies = { "nvzone/volt" },
        }
}
