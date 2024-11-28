return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "jdtls"}
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
        capabilities = capabilities
			})
			lspconfig.svelte.setup({
        capabilities = capabilities
			})
      lspconfig.sqlls.setup({
        capabilities = capabilities
      })
      lspconfig.csharp_ls.setup({
        capabilities = capabilities
      })
      lspconfig.sqls.setup({
        capabilities = capabilities
      })
      lspconfig.cssls.setup({
        capabilities = capabilities
      })
      lspconfig.angularls.setup({
        capabilities = capabilities
      })
			-- lspconfig.ts_ls.setup({
			--         capabilities = capabilities,
			--         init_options = {
			--             plugins = {
			--                 {
			--                     name = "@vue/typescript-plugin",
			--                     location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
			--                     languages = {"javascript", "typescript", "vue"},
			--                 },
			--             },
			--         },
			--
			--         filetypes = {'javascript', 'js', 'ts', 'svelte', 'vue'},
			-- })
      lspconfig.hls.setup({
        capabilities = capabilities
      })

      lspconfig.ts_ls.setup {
          capabilities = capabilities,
          init_options = {
              plugins = {
                  {
                      name = '@vue/typescript-plugin',
                      location = '/usr/local/lib/@vue/typescript-plugin',
                      languages = { 'vue' },
                  },
              },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      }
      lspconfig.volar.setup ({
          filetypes = {'vue'},
          capabilities = capabilities
      })

			lspconfig.html.setup({
          filetypes = {'html, cshtml'},
        capabilities = capabilities
			})
			lspconfig.htmx.setup({
        capabilities = capabilities
			})
			lspconfig.jdtls.setup({
        capabilities = capabilities
			})
			lspconfig.gopls.setup({
        capabilities = capabilities
      })
			lspconfig.clangd.setup({
        capabilities = capabilities
      })
      lspconfig.pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = {'W391','E501'},
                maxLineLength = 100
              }
            }
          }
        },
        capabilities = capabilities
      })
			lspconfig.kotlin_language_server.setup({
        capabilities = capabilities,
        filetypes = {'kt', 'kotlin'},

			})
      lspconfig.bashls.setup({
        capabilities = capabilities,
        filetypes = {'zsh', 'sh'},
      })

      require('lspconfig.ui.windows').default_options = {
          border = 'rounded',
          col = 20,
          row = 10,
          relative = 'editor',  -- Change to 'editor' or 'win' as needed
          width = 50,
          height = 20
      }


      vim.keymap.set("n", "<leader>mm", function() vim.diagnostic.open_float() end, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
		end,
	},
}
