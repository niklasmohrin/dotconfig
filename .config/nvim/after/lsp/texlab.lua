return {
    cmd = { vim.env.CARGO_TARGET_DIR .. "/release/texlab" },
    settings = {
        texlab = {
            bibtexFormatter = "latexindent",
        },
    },
}
