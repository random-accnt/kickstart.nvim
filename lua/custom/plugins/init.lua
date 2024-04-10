-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
<<<<<<< HEAD
=======
    'numToStr/FTerm.nvim',
    opts = {
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    },
  },
  {
>>>>>>> 35bb272 (small changes)
    'AckslD/nvim-neoclip.lua',
    requires = {
      -- you'll need at least one of these
      { 'nvim-telescope/telescope.nvim' },
      { 'ibhagwan/fzf-lua' },
    },
    config = function()
      require('neoclip').setup()
    end,
  },
  {
    'michaelb/sniprun',
    build = {
      'sh install.sh',
    },
    opts = {
      display = {
        'Terminal',
      },
    },
<<<<<<< HEAD
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
=======
>>>>>>> 35bb272 (small changes)
  },
  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePrompt', 'guihua', 'guihua_rust', 'clap_input' },
      }
      -- If you want to automatically add `(` after selecting a function or method local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'ecthelionvi/NeoComposer.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    opts = {
      queue_most_recent = true,
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'dfendr/clipboard-image.nvim',
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown', -- or 'event = "VeryLazy"'
    opts = {
      on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }
        map({ 'n', 'i' }, '<M-l><M-o>', '<Cmd>MDListItemBelow<CR>', opts)
        map({ 'n', 'i' }, '<M-L><M-O>', '<Cmd>MDListItemAbove<CR>', opts)
        map('n', '<M-c>', '<Cmd>MDTaskToggle<CR>', opts)
        map('x', '<M-c>', ':MDTaskToggle<CR>', opts)
      end,
    },
  },
  {
    'dccsillag/magma-nvim',
    init = function()
      return ':UpdateRemotePlugins'
    end,
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>sv', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>sc', '<cmd>VenvSelectCached<cr>' },
    },
  },

  -- [[ PROGRAMMING TOOLS ]]
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    opts = {
      lsp_cfg = false,
    },
  },
  {
    'yanskun/gotests.nvim',
    ft = 'go',
    config = function()
      require('gotests').setup()
    end,
  },
  {
    'ray-x/navigator.lua',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
    },
    config = function()
      local util = require 'navigator.util'
      local remap = util.binding_remap
      local function fallback_keymap(key)
        -- when handler failed fallback to key
        vim.schedule(function()
          print('fallback to key', key)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), 'n', true)
        end)
      end

      local function fallback_fn(key)
        return function()
          fallback_keymap(key)
        end
      end

      require('navigator').setup {
        mason = true,
        default_mapping = false,
        keymaps = {
          -- Search / go to stuff
          { key = 'gr', func = require('navigator.reference').async_ref, desc = '[G]o to [R]ererences' },
          { key = 'gd', func = remap(require('navigator.definition').definition, 'gd'), desc = '[G]o to [D]efinition' },
          {
            key = 'gD',
            func = vim.lsp.buf.declaration,
            desc = 'declaration',
            fallback = fallback_fn 'gD',
          }, -- fallback used
          { key = '<leader>sW', func = require('navigator.workspace').workspace_symbol_live, desc = '[S]earh [W]orkspace' },
          { key = '<leader>k', func = remap(require('navigator.definition').definition_preview, 'gp'), desc = 'definition_preview' }, -- paste

          -- Code actions
          {
            key = '<Space>ca',
            mode = 'n',
            func = require('navigator.codeAction').code_action,
            desc = '[C]ode [A]ction',
          },
          {
            key = '<Space>cl',
            mode = 'n',
            func = require('navigator.codelens').run_action,
            desc = '[C]ode [L]ens action',
          },

          -- Diagnostics
          { key = '<leader>dt', func = require('navigator.diagnostics').toggle_diagnostics, desc = '[D]iagnostics [T]oggle' },
          { key = '<leader>dL', func = require('navigator.diagnostics').show_diagnostics, desc = '[D]iagnostics [L]ine' },
          { key = '<leader>dn', func = vim.diagnostic.goto_next, desc = '[D]iagnostics [N]ext' },
          { key = '<leader>dp', func = vim.diagnostic.goto_prev, desc = '[D]iagnostics [P]rev' },
          {
            key = '<Leader>di',
            func = require('navigator.cclshierarchy').incoming_calls,
            desc = '[D]iagnostics - [I]ncomming calls',
          },
          {
            key = '<Leader>do',
            func = require('navigator.cclshierarchy').outgoing_calls,
            desc = '[D]iagnostics - [O]utgoing calls',
          },
        },
      }
    end,
  },
}
