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
				ensure_installed = { "lua_ls", "tsserver", "jdtls"},
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
      lspconfig.cssls.setup({
        capabilities = capabilities
      })
			lspconfig.tsserver.setup({
        capabilities = capabilities
			})
			lspconfig.html.setup({
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
			lspconfig.kotlin_language_server.setup({
        capabilities = capabilities,
        filetypes = {'kt', 'kotlin'},

			})
      lspconfig.bashls.setup({
        capabilities = capabilities,
        filetypes = {'zsh'},
      })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
		end,
	},
}