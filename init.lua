-- SET --
vim.g.mapleader = " "
-- Makes it so that i can see the current linenumber
vim.opt.nu = true
-- Makes the linenumbers relative
vim.opt.relativenumber = true
-- Makes it so that the cursor blinks
vim.opt.confirm = true


vim.opt.tabstop = 2
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

--Makes it so that there is always min 8 lines between cursor and end of screen
vim.opt.updatetime = 50

-- Makes it so that yanked text is highlighted
vim.api.nvim_create_autocmd('TextYankPost', {
 group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Highlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100}
  end,
})

-- SET DONE --

-- REMAPS --
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<leader>pv', ':Neotree position=current<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>popen_currentv', ':Ex<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>S", vim.cmd.wa)
vim.keymap.set('t', "<leader>nn", vim.cmd.bd)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<leader>gv', ':Neogit<CR>', {noremap = true, silent = true})
-- vim.keymap.set("v", "<leader>gcc", "jkI//<esc>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dp")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', 'gb', ':b#<CR>', { noremap = true, silent = true })


-- vim.keymap.set('i', '<RIGHT>', 'copilot#Accept("\\<CR>")', {
--     expr = true,
--     replace_keycodes = false
-- })
-- vim.g.copilot_no_tab_map = true


-- REMAP DONE --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {}
local opts = {}
require("lazy").setup("plugins")
