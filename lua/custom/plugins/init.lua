-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {},
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
        -- TODO: more in ~/.local/share/nvim/lazy/navigator.lua/
        keymaps = {
          { key = 'gr', func = require('navigator.reference').async_ref, desc = '[G]o to [R]ererences' },
          { key = 'gd', func = remap(require('navigator.definition').definition, 'gd'), desc = '[G]o to [D]efinition' },
          {
            key = 'gD',
            func = vim.lsp.buf.declaration,
            desc = 'declaration',
            fallback = fallback_fn 'gD',
          }, -- fallback used
        },
      }
    end,
  },
}
