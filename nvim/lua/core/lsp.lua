vim.diagnostic.config({
    signs = true,
    underline = true,
    update_in_insert = true,
    virtual_text = {
        source = "if_many",
        prefix = "●",
    },
})

-- Add mason binaries to PATH
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

-- enable all lsp defs in nvim/lsp
local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
local servers = {}
local handle = vim.uv.fs_scandir(lsp_dir)
if handle then
    while true do
        local name, type = vim.uv.fs_scandir_next(handle)
        if not name then
            break
        end
        if type == "file" and name:match("%.lua$") then
            servers[#servers + 1] = name:gsub("%.lua$", "")
        end
    end
end
vim.lsp.enable(servers)
