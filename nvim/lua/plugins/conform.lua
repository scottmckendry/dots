return {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
        vim.g.autoformat = true
        require("conform").setup({
            formatters_by_ft = {
                bicep = { "bicep" },
                cs = { "csharpier" },
                css = { "prettier" },
                go = { "goimports_reviser", "gofmt", "golines" },
                html = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                nix = { "nixfmt" },
                rust = { "rustfmt" },
                scss = { "prettier" },
                sh = { "shfmt" },
                templ = { "templ" },
                toml = { "taplo" },
                yaml = { "prettier" },
            },

            format_after_save = function()
                if not vim.g.autoformat then
                    return
                else
                    if vim.bo.filetype == "ps1" then
                        vim.lsp.buf.format()
                        return
                    end
                    return { lsp_format = "fallback" }
                end
            end,

            formatters = {
                goimports_reviser = {
                    command = "goimports-reviser",
                    args = { "-output", "stdout", "$FILENAME" },
                },
            },
        })

        -- Override bicep's default indent size
        require("conform").formatters.bicep = {
            args = { "format", "--stdout", "$FILENAME", "--indent-size", "4" },
        }
    end,
}
