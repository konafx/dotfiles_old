local ok, packer = pcall(require, "packer")
if not ok then
  print("Packer is not installed")
  return
end

vim.cmd('packadd packer.nvim')

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- utility
  use 'nvim-lua/plenary.nvim'
  use 'vim-denops/denops.vim'

  -- Fades inactive buffers
  use 'TaDaa/vimade'

  -- Filer
  use 'lambdalisue/fern.vim'
  use 'lambdalisue/nerdfont.vim'
  use 'lambdalisue/fern-renderer-nerdfont.vim'

  -- LSP manager
  use {
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end,
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim' },
    after = { 'mason.nvim', 'nvim-cmp', 'nvim-lspconfig' },
    config = function() require('mason-lspconfig').setup() end,
  }
  -- LSP
  use 'neovim/nvim-lspconfig'
  -- pictogram
  use 'onsails/lspkind.nvim'
  -- snippet engine
  use 'L3MON4D3/LuaSnip'
  -- complete
  use 'hrsh7th/nvim-cmp'
  use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Autotag
  use {
    'windwp/nvim-ts-autotag',
    config = function() require('nvim-ts-autotag').setup() end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { 'TelescopePrompt', 'vim', 'fern' }
      })
    end
  }
  -- auto close
  use 'mattn/vim-lexiv'

  -- Operator
  use 'kana/vim-operator-user'
  use {
    'kana/vim-operator-replace',
    requires = 'kana/vim-operator-user',
  }
  use {
    'rhysd/vim-operator-surround',
    requires = 'kana/vim-operator-user',
  }

  -- Search
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
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
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

  -- colorscheme
  use 'EdenEast/nightfox.nvim'
end)
