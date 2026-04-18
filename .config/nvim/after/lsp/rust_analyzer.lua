return {
    settings = {
        ["rust-analyzer"] = {
            server = {
                extraEnv = {
                    RUSTFLAGS = vim.env.RUSTFLAGS,
                    CARGO_TARGET_DIR = vim.env.CARGO_TARGET_DIR,
                },
            }
        }
    }
}
