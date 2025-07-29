return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "pylsp", 
          "lua_ls", 
          "jdtls",
          -- JavaScript/TypeScript servers
          "eslint",             -- ESLint Language Server
          "tailwindcss",        -- Tailwind CSS Language Server
          "emmet_ls",           -- Emmet Language Server
          "cssls",              -- CSS Language Server
          "html",               -- HTML Language Server
          "jsonls",             -- JSON Language Server
        }
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic UI
      vim.diagnostic.config({
        virtual_text = {
          prefix = "■",
          spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Existing Language servers
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Java (jdtls)
      lspconfig.jdtls.setup({
        cmd = { "jdtls" },
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            format = { enabled = true },
          },
        },
      })

      -- ESLint Language Server
      lspconfig.eslint.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(".eslintrc.js", ".eslintrc.json", ".eslintrc", "package.json"),
        settings = {
          workingDirectory = { mode = "auto" },
        },
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      -- Tailwind CSS Language Server
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "postcss.config.ts", "package.json"),
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning"
            },
            validate = true
          }
        }
      })

      -- CSS Language Server
      lspconfig.cssls.setup({
        capabilities = capabilities,
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore"
            }
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore"
            }
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore"
            }
          }
        }
      })

      -- HTML Language Server
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "htmldjango" }
      })

      -- JSON Language Server
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- Emmet Language Server
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { 
          "html", "htmldjango", "typescriptreact", "javascriptreact", 
          "css", "sass", "scss", "less", "vue" 
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        }
      })

      -- Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
      vim.keymap.set('n', '<leader>e', function()
        vim.diagnostic.open_float(nil, { border = "rounded" })
      end, { desc = "Show line diagnostics" })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

      -- JavaScript/React specific keymaps
      vim.keymap.set('n', '<leader>rf', function()
        vim.lsp.buf.code_action({
          filter = function(action)
            return action.kind and vim.startswith(action.kind, "refactor")
          end,
          apply = true
        })
      end, { desc = "Refactor" })

      vim.keymap.set('n', '<leader>oi', function()
        vim.lsp.buf.code_action({
          filter = function(action)
            return action.kind and vim.startswith(action.kind, "source.organizeImports")
          end,
          apply = true
        })
      end, { desc = "Organize Imports" })

      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          })
        end
      })
    end,
  },

  -- Schema store for JSON files
  {
    "b0o/schemastore.nvim",
  },
}
