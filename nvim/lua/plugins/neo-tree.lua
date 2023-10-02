return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    keys = {
        { "<leader>ee", ":Neotree toggle<CR>", desc = "Toggle file explorer", silent = true },
    },
}