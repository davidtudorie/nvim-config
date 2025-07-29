return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag", -- Auto close JSX tags
  },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { 
        -- Existing languages
        "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "html",
        
        -- JavaScript/TypeScript ecosystem
        "javascript", "typescript", "tsx", "json", 
        "css", "yaml", "markdown"
      },
      
      sync_install = false,
      auto_install = true,
      
      highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      
      indent = { 
        enable = true,
      },
      
      -- Auto tag pentru JSX/HTML
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = false,
        filetypes = { "html", "xml", "javascriptreact", "typescriptreact" },
      },
    })
  end
}
