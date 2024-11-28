return{
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>df", ":Gvdiffsplit<CR>")
    end
}
