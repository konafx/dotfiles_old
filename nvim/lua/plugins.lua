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
    config = function() require('mason-lspconfig').setup() end,
  }
  -- LSP
  use 'neovim/nvim-lspconfig'
  -- pictogram
  use 'onsails/lspkind.nvim'
  -- snippet engine
  use 'L3MON4D3/LuaSnip'
  -- complete
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Autotag
  use {
    'windwp/nvim-ts-autotag',
    config = function () require('nvim-ts-autotag').setup() end
  }
  use {
    'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup({
        disable_filetype = { 'TelescopePrompt', 'vim', 'fern' }
      })
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
    'lambdalisue/gina.vim',
    opt = true,
    cmd = { 'Gina' },
  }

  -- colorscheme
  use 'EdenEast/nightfox.nvim'
end)
