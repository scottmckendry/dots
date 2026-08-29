--- @type vim.lsp.Config
return {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = function(bufnr, done)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, {
            ".clangd",
            "compile_commands.json",
            "compile_flags.txt",
            ".git",
        })
        if root then
            return done(root)
        end
    end,
    settings = {
        clangd = {
            InlayHints = {
                Designators = true,
                Enabled = true,
                ParameterNames = true,
                DeducedTypes = true,
            },
            fallbackStyle = "llvm",
        },
    },
}
