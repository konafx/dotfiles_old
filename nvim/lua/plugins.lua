local ok, packer = pcall(require, "packer")
if not ok then
  print("Packer is not installed")
  return
end

-- packer {{{
vim.cmd('packadd packer.nvim')

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- utility
  -- use 'nvim-lua/plenary.nvim'
  -- use 'vim-denops/denops.vim'

  -- icon
  use 'kyazdani42/nvim-web-devicons'

  -- ui
  use 'stevearc/dressing.nvim'

  if vim.fn.has('python') == 1 or vim.fn.has('python3') then
    -- fades inactive buffers
    use 'tadaa/vimade'
  end

  -- filer
  use 'lambdalisue/fern.vim'
  use 'lambdalisue/nerdfont.vim'
  use 'lambdalisue/fern-renderer-nerdfont.vim'

  -- lsp manager
  use {
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end,
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    requires = {
      'williamboman/mason.nvim',
      'hrsh7th/nvim-cmp',
      'neovim/nvim-lspconfig'
    },
    -- after = { 'mason.nvim', 'nvim-cmp', 'nvim-lspconfig' },
    config = function() require('mason-lspconfig').setup() end,
  }
  -- lsp
  use 'neovim/nvim-lspconfig'
  -- pictogram
  use 'onsails/lspkind.nvim'
  -- rich lsp
  use 'kkharji/lspsaga.nvim'

  -- snippet engine
  use 'l3mon4d3/luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip'
  -- complete
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'l3mon4d3/luasnip' }
  }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }

  -- linter
  use 'jose-elias-alvarez/null-ls.nvim'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':tsupdate'
  }

  -- autotag
  use {
    'windwp/nvim-ts-autotag',
    config = function() require('nvim-ts-autotag').setup() end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { 'telescopeprompt', 'vim', 'fern' }
      })
    end
  }
  -- auto closer
  use {
    'cohama/lexima.vim',
    disable = true,
  }
  -- small implement lexima
  use 'mattn/vim-lexiv'

  -- operator
  use 'kana/vim-operator-user'
  use {
    'kana/vim-operator-replace',
    requires = 'kana/vim-operator-user',
  }
  use {
    'rhysd/vim-operator-surround',
    requires = 'kana/vim-operator-user',
  }

  -- comment
  -- use 'tyru/caw.vim'
  use 'tpope/vim-commentary'

  -- search
  -- " e.g.) maekawa -> 前川
  use 'osyo-manga/vim-vigemo'
  use {
    'rhysd/clever-f.vim',
    config = function()
      vim.g.clever_f_not_overwrites_standard_mappings = 1
    end
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- easy motions
  use {
    'yuki-yano/fuzzy-motion.vim',
    requires = { 'vim-denops/denops.vim' },
    config = function()
      vim.g.fuzzy_motion_auto_jump = false
    end
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- git plugins
  use {
    'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
  }
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'lambdalisue/gina.vim',
    opt = true,
    cmd = { 'Gina' },
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('rc/gitsigns')
    end
  }

  -- buffers
  use {
    'jeetsukumaran/vim-buffergator',
    config = function()
      vim.g.buffergator_suppress_keymaps = 1
      vim.g.buffergator_viewport_split_policy = "N"
    end
  }

  use {
    'bkad/CamelCaseMotion',
    config = function()
      vim.g.camelcasemotion_key = '<Space>'
    end
  }

  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install'
    -- { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
  }

  -- 翻訳
  use {
    'skanehira/denops-translate.vim',
    requires = { 'vim-denops/denops.vim' }
  }

  use 'thinca/vim-quickrun'

  -- 辞書
  use {
    'thinca/vim-ref',
    config = function()
      require('rc/vim-ref')
    end
  }

  -- Gist
  use {
    'mattn/vim-gist',
    requires = 'mattn/webapi-vim'
  }

  -- GitHub
  use {
    'skanehira/denops-gh.vim',
    requires = { 'vim-denops/denops.vim' },
  }

  -- CheatSheet
  use {
    'reireias/vim-cheatsheet',
    config = function()
      vim.g['cheatsheet#cheat_file'] = '~/.config/nvim/cheatsheet.md'
      vim.g['cheatsheet#float_window'] = 1
      vim.g['cheatsheet#float_window_width_ratio'] = 0.8
      vim.g['cheatsheet#float_window_height_ratio'] = 0.9
      vim.api.nvim_create_user_command('CheatEdit', 'edit ~/.config/nvim/cheatsheet.md', {})
      vim.keymap.set('n', '<leader>?', '<Cmd>Cheat<CR>', {})
    end
  }
  -- Lua
  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- colorscheme
  use 'EdenEast/nightfox.nvim'
end)
-- }}}
