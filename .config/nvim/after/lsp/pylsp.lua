return {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 88, -- same as Black
                },
                black = { enabled = true },
                yapf = { enabled = false },
            },
        },
    },
}
