-- lua/plugins/typescript.lua
return {
  -- TypeScript tools - cel mai bun plugin pentru TS/JS
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("typescript-tools").setup {
        on_attach = function(client, bufnr)
          -- Disable formatting (o să folosim Prettier)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          
          -- Keymaps specifice pentru TypeScript
          local opts = { buffer = bufnr, desc = "" }
          vim.keymap.set("n", "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", 
            vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
          vim.keymap.set("n", "<leader>tu", "<cmd>TSToolsRemoveUnused<cr>", 
            vim.tbl_extend("force", opts, { desc = "Remove Unused" }))
          vim.keymap.set("n", "<leader>tf", "<cmd>TSToolsFixAll<cr>", 
            vim.tbl_extend("force", opts, { desc = "Fix All" }))
          vim.keymap.set("n", "<leader>ta", "<cmd>TSToolsAddMissingImports<cr>", 
            vim.tbl_extend("force", opts, { desc = "Add Missing Imports" }))
        end,
        settings = {
          -- Performanță mai bună
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          -- Completări mai bune
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          -- JSX auto close tag
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
          -- Preferințe pentru server
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
            includePackageJsonAutoImports = "auto",
          },
        },
      }
    end,
  },

  -- ESLint integration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
          },
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },
      },
    },
  },
}
