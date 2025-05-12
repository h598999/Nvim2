return {
    {
  	  'nvim-telescope/telescope.nvim',
  	  tag = '0.1.5',
  	  dependecies = { 'nvim-lua/plenary.nvim' },
      config = function()
          local builtin = require("telescope.builtin")
          vim.keymap.set('n', '<leader>pf', builtin.find_files,{})
          vim.keymap.set('n', '<leader>pd', builtin.live_grep,{})

          require('telescope').setup{
              defaults = {
                  file_ignore_patterns = { "%.class", "%.Identifier", "%.cmd", "env/*", "squashfs-root/*", "%.so", "target/*"},
                  border = false
              }
          }
      end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
        require("telescope").setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown{
                    }
                }
            }
        })
        require("telescope").load_extension("ui-select")
    end
  },
}

