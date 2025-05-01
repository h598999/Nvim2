-- SET --initlvim
vim.g.mapleader = " "
-- Makes it so that i can see the current linenumber
vim.opt.nu = true
-- Makes the linenumbers relative
vim.opt.relativenumber = true
-- Makes it so that the cursor blinks
vim.opt.confirm = true

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
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
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    desc = "Highlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
    end,
})

vim.g.vimtex_complete_enabled = 1
vim.g.vimtex_complete_resolve = 1

vim.g.vimtex_complete_popup_position = 'bottom'

-- SET DONE --

-- REMAPS --
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>pv", ":Neotree position=current<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>pv', ':Ex<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>popen_currentv', ':Ex<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mdv", ":MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>S", vim.cmd.wa)
vim.keymap.set("t", "<leader>nn", vim.cmd.bd)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>gv", ":Neogit<CR>", { noremap = true, silent = true })
-- Toggle wrap function
local function toggle_wrap()
  vim.opt.wrap = not vim.opt.wrap:get()  -- Toggle wrap
end

-- Normal mode mapping (e.g., <leader>tw)
vim.keymap.set('n', '<leader>tw', toggle_wrap, { noremap = true, silent = true, desc = "Toggle line wrapping" })

-- vim.keymap.set("v", "<leader>gcc", "jkI//<esc>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "gb", ":b#<CR>", { noremap = true, silent = true })

-- vim.keymap.set('i', '<RIGHT>', 'copilot#Accept("\\<CR>")', {
    --     expr = true,
    --     replace_keycodes = false
    -- })
    -- vim.g.copilot_no_tab_map = true

    -- REMAP DONE --
    vim.api.nvim_set_hl(0, "FloatBorder", {bg='#3B4252', fg='#5E81AC'});
    vim.api.nvim_set_hl(0, "NormalFloat", {bg='#3B4252'});
    vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="#3B4252"});
    vim.api.nvim_set_hl(0, "TelescopeBorder", {bg="#3B4252"});

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

    -- Toggle wrap function
local function toggle_wrap()
  vim.opt.wrap = not vim.opt.wrap:get()
end

-- Normal mode mapping (e.g., <leader>tw)
vim.keymap.set('n', '<leader>tw', toggle_wrap, { noremap = true, silent = true, desc = "Toggle line wrapping" })
    vim.opt.rtp:prepend(lazypath)

    local plugins = {}
    local opts = {}
    require("lazy").setup("plugins")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    -- Set buffer-local keymaps for tex files
    vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "v", "j", "gj", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "v", "k", "gk", { noremap = true, silent = true })
  end
})

local schemeFile = vim.fn.stdpath("cache").."/last_colorscheme.txt"
local colorSchemes = {"catppuccin", "rose-pine", "gruvbox", "github_dark", "onedark", "material"}

local fileRead = io.open(schemeFile, "r")
local i = 1;
if fileRead then
    local contents = tonumber(fileRead:read("*a"))
    if contents then
        i = contents
    end
end

local function toggleScheme()
    if (i >= #colorSchemes) then
        i = 1
    else
        i = i+1
    end
    local color = colorSchemes[i]
    ColorMyPencils(color)

    local writeFile = io.open(schemeFile, "w")
    if writeFile then
        writeFile:write(i)
        writeFile:close()
    end
    print(colorSchemes[i])
end

vim.keymap.set('n', '<leader>cs', toggleScheme,{ noremap = true, silent = true, desc = "Toggle colorScheme" })

ColorMyPencils(colorSchemes[i]);
