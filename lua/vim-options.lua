vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.api.nvim_set_option("clipboard","unnamed")
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
vim.api.nvim_create_user_command("JavaNewProject", function()
  require("tools.java_tools").create_project()
end, {})

vim.api.nvim_create_user_command("JavaNewPackage", function()
  require("tools.java_tools").create_package()
end, {})

vim.api.nvim_create_user_command("JavaNewClass", function()
  require("tools.java_tools").create_class()
end, {})
vim.wo.number = true
