-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- basic shortcuts
vim.keymap.set('n', '<leader>w', '<cmd>wa<CR>', { desc = 'Save all' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Save all' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Telescope ]]
-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- Telescope neoclip
vim.keymap.set('n', '<leader>sc', '<cmd>Telescope neoclip<CR>', { desc = '[S]earch neo[C]lip (yank history)' })

-- [[ Terminal ]]
local fterm = require 'FTerm'
local runners = { lua = 'lua', python = 'python', go = 'go' }
local gitui = require('FTerm'):new {
  ft = 'fterm_gitui',
  cmd = 'gitui',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
}

vim.keymap.set({ 'n', 't' }, '<M-t>', function()
  fterm.toggle()
end, { desc = '[T]oggle floating terminal' })

vim.keymap.set('n', '<leader>tr', function()
  local buf = vim.api.nvim_buf_get_name(0)
  local ftype = vim.filetype.match { filename = buf }
  local exec = runners[ftype]
  if exec ~= nil then
    require('FTerm').scratch { cmd = { exec, buf } }
  end
end, { desc = '[T]erminal - [R]un current file' })

vim.keymap.set('n', '<leader>tg', function()
  gitui:toggle()
end, { desc = '[T]erminal - run [G]itui' })

vim.api.nvim_create_user_command('FTermExit', fterm.exit, { bang = true })

-- [[ Harpoon ]]
local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():append()
end)
vim.keymap.set('n', '<C-h>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set('n', '<M-S-P>', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<M-S-N>', function()
  harpoon:list():next()
end)

-- other
local util = require 'util'
vim.keymap.set('n', '<leader>er', function()
  if vim.bo.filetype == 'go' then
    util.printErrGo()
  end
end)

-- [[ Magma ]]
vim.keymap.set('n', '<leader>rr', '<cmd>MagmaEvaluateLine<CR>', { desc = 'Evaluate single line in jupyter notebook' })
vim.keymap.set('n', '<leader>rc', '<cmd>MagmaReevaluateCell<CR>', { desc = 'Evaluate cell in jupyter notebook' })
vim.keymap.set('n', '<leader>rd', '<cmd>MagmaDelete<CR>', { desc = 'Delete cell in jupyter notebook' })
vim.keymap.set('v', '<leader>rr', ':<C-u><CR>:MagmaEvaluateVisual<CR>', { desc = 'Evaluate selected lines in jupyter notebook' })

-- [[ Snippets ]]
vim.keymap.set('v', '<leader>rs', ':SnipRun<CR>', { desc = '[R]un [S]nippet' })
vim.keymap.set({ 'v', 'n' }, '<leader>rC', '<cmd>SnipClose<CR>', { desc = '[R]un [S]nippet' })
