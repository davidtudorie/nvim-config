vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false
vim.wo.number = true
vim.opt.relativenumber = true

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Clipboard integration
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.api.nvim_set_option("clipboard","unnamed")

-- Clear search highlighting
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Neo-tree toggle function
local function toggle_neotree()
  local manager = require("neo-tree.sources.manager")
  local state = manager.get_state("filesystem")
  if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
    -- Neo-tree e deschis, închide-l
    vim.cmd("Neotree close")
  else
    -- Neo-tree e închis, deschide-l
    vim.cmd("Neotree filesystem reveal left")
  end
end

-- Neo-tree toggle
vim.keymap.set('n', '<C-n>', toggle_neotree, { desc = "Toggle Neo-tree" })

-- Telescope keymaps (wrapped in functions pentru lazy loading)
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Help tags' })

-- Java project commands
vim.api.nvim_create_user_command("JavaNewProject", function()
  require("java-newproj").create_project()
end, {})

vim.api.nvim_create_user_command("JavaNewPackage", function()
  require("java-newproj").create_package()
end, {})

vim.api.nvim_create_user_command("JavaNewClass", function()
  require("java-newproj").create_class()
end, {})

-- JavaScript/React project commands
vim.api.nvim_create_user_command("ReactNewProject", function()
  require("js-newproj").create_react_project()
end, { desc = "Create new React project" })

vim.api.nvim_create_user_command("NodeNewProject", function()
  require("js-newproj").create_nodejs_project()
end, { desc = "Create new Node.js project" })

vim.api.nvim_create_user_command("ReactNewComponent", function()
  require("js-newproj").create_component()
end, { desc = "Create new React component" })

-- JavaScript/React specific keymaps
vim.keymap.set('n', '<leader>np', ':ReactNewProject<CR>', { desc = "New React Project" })
vim.keymap.set('n', '<leader>nn', ':NodeNewProject<CR>', { desc = "New Node.js Project" })
vim.keymap.set('n', '<leader>nc', ':ReactNewComponent<CR>', { desc = "New React Component" })

-- Terminal keymaps
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { desc = "Open terminal" })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })

-- Package.json shortcuts
vim.keymap.set('n', '<leader>pi', ':!npm install<CR>', { desc = "npm install" })
vim.keymap.set('n', '<leader>ps', ':!npm start<CR>', { desc = "npm start" })
vim.keymap.set('n', '<leader>pt', ':!npm test<CR>', { desc = "npm test" })
vim.keymap.set('n', '<leader>pb', ':!npm run build<CR>', { desc = "npm build" })

-- Quick save and close
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save file" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit" })
