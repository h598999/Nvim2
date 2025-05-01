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
                -- ensure_installed = { "lua_ls", "jdtls" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.rust_analyzer.setup({ capabilities = capabilities })
            lspconfig.svelte.setup({ capabilities = capabilities })
            lspconfig.sqlls.setup({ capabilities = capabilities })
            lspconfig.csharp_ls.setup({ capabilities = capabilities })
            lspconfig.sqls.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
            lspconfig.angularls.setup({ capabilities = capabilities })
            lspconfig.hls.setup({ capabilities = capabilities })
            lspconfig.intelephense.setup({ capabilities = capabilities })
            lspconfig.ltex.setup({
                capabilities = capabilities,
                filetypes = {"tex"},
                language = "en-GB",
            })
            lspconfig.texlab.setup({
                capabilities = capabilities,
                filetypes = {"tex"},
            })

            lspconfig.ltex_plus.setup({
                capabilities = capabilities,
                filetypes = {"tex"},
                language = "en-GB",
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = "/usr/local/lib/@vue/typescript-plugin",
                            languages = { "vue" },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            })

            lspconfig.volar.setup({ filetypes = { "vue" }, capabilities = capabilities })
            lspconfig.html.setup({ filetypes = { "html, cshtml" }, capabilities = capabilities })
            lspconfig.htmx.setup({ capabilities = capabilities })
            -- lspconfig.jdtls.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })

            lspconfig.pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = { "W391", "E501" },
                                maxLineLength = 100,
                            },
                        },
                    },
                },
                capabilities = capabilities,
            })

            lspconfig.kotlin_language_server.setup({
                capabilities = capabilities,
                settings = {
                    kotlin = {
                        diagnostics = {
                            enabled = true,
                            debounceTime = 100, -- make updates more responsive
                            level = "hint",     -- "error" | "warning" | "hint"
                        },
                        completion = {
                            snippets = {
                                enabled = true,
                            },
                        },
                        languageServer = {
                            watchFiles = {
                                "**/*.kt",
                                "**/*.kts",
                                "**/*.java",
                                "**/pom.xml",
                                "**/build.gradle",
                                "**/settings.gradle"
                            },
                            transport = "stdio",
                            enabled = true
                        },
                        codegen = {
                            enabled = true
                        },
                        debounceTime = 100, -- top-level debounce
                        indexing = {
                            enabled = true
                        },
                        trace = {
                            server = "verbose"
                        }
                    }
                }
            })
            lspconfig.bashls.setup({ capabilities = capabilities, filetypes = { "zsh", "sh" } })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_buf_set_option(args.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
                    end
                end,
            })

            vim.keymap.set("n", "<leader>mm", function() vim.diagnostic.open_float() end, {})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                max_width = 80,
                max_height = 20,
                border = "rounded",
                focusable = false
            })

            vim.diagnostic.config({
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    guibg = "none",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },

    -- Completion and hover documentation configuration
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                },
                window = {
                    completion = {
                        border = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                        max_width = 80,
                        max_height = 15,
                    },
                    documentation = {
                        border = "rounded",
                        max_width = 80,
                        max_height = 15,
                        zindex = 50, -- Ensure it's not drawn over completion menu
                    },
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "vimtex"},
                }),
            })
        end,
    },
}
