return {
    "h598999/cs_picker",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = false,
    priority = 1000, -- make sure it loads early
    config = function()
        local scheme = require("cs_picker")
        require("cs_picker").setup({
            -- user_colorSchemes = {
            --     catppuccin = {"mocha"},
            --     ["rose-pine"] = {"moon"},
            --     onedark = {"dark"},
            --     gruvbox = {},
            -- }
        })
        vim.keymap.set("n", "<leader>fs", scheme.pick_colorscheme, { desc = "Pick colorscheme" })
        vim.keymap.set("n", "<leader>cs", scheme.toggle_next, { desc = "Toggle colorscheme" })
    end,
}

