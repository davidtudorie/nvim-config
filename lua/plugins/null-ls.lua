-- null-ls for Formatting, completion, linting, etc.
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- Spell checking
        null_ls.builtins.completion.spell,
        -- JavaScript/TypeScript formatter
        null_ls.builtins.formatting.prettier.with({
          filetypes = { 
            "javascript", "javascriptreact", "typescript", "typescriptreact", 
            "json", "jsonc", "css", "scss", "html", "yaml", "markdown"
          },
        }),
      },
    })
    -- Format keymap
    vim.keymap.set('n', "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
    -- Format on save pentru JavaScript/TypeScript
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html" },
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
