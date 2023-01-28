local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, 'lazy')
if not ok then
  print('lazy.nvim is not installed')
  return
end
lazy.setup({
	-- utility {{{2
	-- 'nvim-lua/plenary.nvim,
  {
    'vim-denops/denops.vim',
    -- カーソルが暫く動かなかった時や、別のウィンドウ・ペインに移動した時に
    -- 裏で読み込んでおきます。
    event = {'CursorHold', 'FocusLost' },
  },
	-- 2}}}

	-- icon
	'nvim-tree/nvim-web-devicons',

	-- ui
  {
    'stevearc/dressing.nvim',
    lazy = false,
  },


	-- statusline
	{
		'nvim-lualine/lualine.nvim',
    lazy = false,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	-- fades inactive buffers
	{
    'tadaa/vimade',
    event = {
      'WinEnter',
      'WinNew',
    },
    enabled = function ()
      return vim.fn.has('python') == 1 or vim.fn.has('python3')
    end
  },

	-- filter
	{
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/nerdfont.vim',
      'lambdalisue/fern-renderer-nerdfont.vim',
    },
    cmd = 'Fern',
    -- todo: add <Plug>(fern-*) ※いまは:Fernのみ
  },

	-- lsp manager
	{
		'williamboman/mason.nvim',
    lazy = false,
    priority = 100, -- lsp, null-ls両方の依存先なので早めにload
		config = true,
  },

	-- lsp
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
		  -- 'williamboman/mason.nvim',
    }
  },

	-- rich lsp ui
  {
    'glepnir/lspsaga.nvim',
    event = 'BufRead',
    config = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },

	-- complete
	{
		'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
		dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
	    -- snippet engine
      'l3mon4d3/luasnip',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
      -- pictogram
      'onsails/lspkind.nvim',
    },
	},


	-- linter formatter
	{
		'jay-babu/mason-null-ls.nvim',
    lazy = false,
    dependencies = {
	    'jose-elias-alvarez/null-ls.nvim',
		  -- 'williamboman/mason.nvim',
    },
		config = function()
			require('mason-null-ls').setup({
				ensure_installed = { 'prettier', 'stylua' },
				automatic_installation = false,
				automatic_setup = true,
			})
      require('null-ls').setup({
	      capabilities = vim.lsp.protocol.make_client_capabilities(),
      })
      require('mason-null-ls').setup_handlers()

      vim.keymap.set('n', '<Plug>(lsp)f', function()
        vim.lsp.buf.format({ name = 'null-ls' })
      end)
		end,
	},

	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = {
      'Trouble',
      'TroubleToggle'
    },
		config = true,
	},

	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
		build = ':TSUpdate',
	},

	-- overview
	{
		'stevearc/aerial.nvim',
		config = true,
    cmd = {
      'AerialToggle',
      'AerialOpen',
      'AerialOpenAll',
      'AerialGo',
      'AerialInfo',
    }
    -- support api on lazy
	},

	-- autotag
	{
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},

	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup({
				disable_filetype = { 'telescopeprompt', 'vim', 'fern' },
			})
		end,
	},
	-- auto closer
	{
		'cohama/lexima.vim',
		enabled = false,
	},
	-- small implement lexima
	{
    'mattn/vim-lexiv',
    lazy = false,
  },

	-- operator
	'kana/vim-operator-user',
	{
    'kana/vim-operator-replace',
    keys = '<Plug>(operator-replace)',
		dependencies = 'kana/vim-operator-user',
	},
	{
    'rhysd/vim-operator-surround',
    keys = {
      '<Plug>(operator-surround-append)',
      '<Plug>(operator-surround-delete)',
      '<Plug>(operator-surround-replace)'
    },
		dependencies = 'kana/vim-operator-user',
	},
	{
    'mopp/vim-operator-convert-case',
    keys = {
      '<Plug>(operator-convert-case-lowe-camel)',
      '<Plug>(operator-convert-case-upper-camel)',
      '<Plug>(operator-convert-case-lower-snake)',
      '<Plug>(operator-convert-case-upper-snake)',
      '<Plug>(operator-convert-case-toggle-upper-lower)',
      '<Plug>(operator-convert-case-loop)',
      '<Plug>(operator-convert-case-convert)',
    },
    cmd = {
      'ToggleUpperLower',
      'ConvertCase',
    },
		dependencies = 'kana/vim-operator-user',
	},

	-- comment
	-- 'tyru/caw.vim',
	{
    'tpope/vim-commentary',
    -- after/plugin/commentary.rc.lua
    keys = {
      '<Plug>Commentary',
      '<Plug>CommentaryLine',
    },
  },

	-- dial, cycle
	{
		'monaqa/dial.nvim',
    keys = {
      { '<C-a>', nil, {'n', 'v'} },
      { '<C-x>', nil, {'n', 'v'} },
      { '<C-x>', nil, {'n', 'v'} },
      { 'g<C-a>', nil, 'v'},
      { 'g<C-x>', nil, 'v'},
    },
		config = function()
			-- override keymap
			local dialmap = require('dial.map')
			vim.keymap.set('n', '<C-a>', dialmap.inc_normal(), { noremap = true })
			vim.keymap.set('n', '<C-x>', dialmap.dec_normal(), { noremap = true })
			vim.keymap.set('v', '<C-a>', dialmap.inc_visual(), { noremap = true })
			vim.keymap.set('v', '<C-x>', dialmap.dec_visual(), { noremap = true })
			vim.keymap.set('v', 'g<C-a>', dialmap.inc_gvisual(), { noremap = true })
			vim.keymap.set('v', 'g<C-x>', dialmap.dec_gvisual(), { noremap = true })

			local augend = require('dial.augend')
			require('dial.config').augends:register_group({
				-- default augends used when no group name is specified
				default = {
					augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
					augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
					augend.date.alias['%Y/%m/%d'], -- date (2022/02/19, etc.)
				},
			})
		end,
	},

	-- search
  {
	  -- " e.g.) maekawa -> 前川
    'osyo-manga/vim-vigemo',
    keys = '<Plug>(vigemo-search)',
    cmd = 'VigemoSearch',
  },

	{
		'rhysd/clever-f.vim',
    keys = {'<Plug>(clever-f-f)', '<Plug>(clever-f-F)'},
		init = function()
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(clever-f-f)', { noremap = false })
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(clever-f-F)', { noremap = false })
			vim.g.clever_f_not_overwrites_standard_mappings = 1
		end,
	},

  {
    -- enhanced search
    'hrsh7th/vim-searchx',
    lazy = false,
  },

	-- fuzzy finder
	{
		'nvim-telescope/telescope.nvim',
    lazy = false, -- file-browser hijacks netrw
		dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'tsakirist/telescope-lazy.nvim',
    },
    init = function ()
      require('rc/telescope').init()
    end,
    config = function ()
      require('rc/telescope').config()
    end
	},


	-- easy motions
	{
		'yuki-yano/fuzzy-motion.vim',
		dependencies = { 'vim-denops/denops.vim' },
    cmd = 'FuzzyMotion',
		init = function()
			vim.g.fuzzy_motion_auto_jump = false
			vim.keymap.set('n', '[motion]<Space>', '<Cmd>FuzzyMotion<CR>')
		end,
	},

	{
		'skanehira/jumpcursor.vim',
    keys = '<Plug>(jumpcursor-jump)',
		init = function()
			vim.keymap.set('n', '[motion]j', '<Plug>(jumpcursor-jump)')
		end,
	},

	-- git plugins
	{
		'TimUntersberger/neogit',
    keys = '[git]',
		dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
	},

	{
		'lambdalisue/gina.vim',
		cmd = { 'Gina' },
	},

	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('rc/gitsigns')
		end,
	},

	-- buffers
	{
		'jeetsukumaran/vim-buffergator',
		config = function()
			vim.g.buffergator_suppress_keymaps = 1
			vim.g.buffergator_viewport_split_policy = 'N'
		end,
	},

	-- 一部切り抜いて編集
	{
    'thinca/vim-partedit',
    cmd = 'Parsedit',
  },

	{
		'bkad/CamelCaseMotion',
    lazy = false, -- TODO: true
		config = function()
			vim.g.camelcasemotion_key = '<Space>'
		end,
	},

	-- Markdown
	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
		-- { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
	},

	-- 翻訳
	{
		'skanehira/denops-translate.vim',
		dependencies = { 'vim-denops/denops.vim' },
    cmd = 'Translate'
	},

	{
    'thinca/vim-quickrun',
    cmd = 'QuickRun',
  },

	-- 辞書
	{
		'thinca/vim-ref',
		config = function()
			require('rc/vim-ref')
		end,
    cmd = 'Ref',
	},

	-- Gist
	{
		'mattn/vim-gist',
		dependencies = 'mattn/webapi-vim',
    cmd = { 'Gist' },
	},

	-- GitHub
	{
		'pwntester/octo.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-tree/nvim-web-devicons',
		},
    cmd = { 'Octo' },
		config = true,
  },

	{
		'skanehira/denops-gh.vim',
		dependencies = { 'vim-denops/denops.vim' },
    lazy = false, -- todo: true
		-- disable = true,
	},

	-- CheatSheet
	{
		'reireias/vim-cheatsheet',
		config = function()
			vim.g['cheatsheet#cheat_file'] = '~/.config/nvim/cheatsheet.md'
			vim.g['cheatsheet#float_window'] = 1
			vim.g['cheatsheet#float_window_width_ratio'] = 0.8
			vim.g['cheatsheet#float_window_height_ratio'] = 0.9
			vim.api.nvim_create_user_command('CheatEdit', 'edit ~/.config/nvim/cheatsheet.md', {})
			vim.keymap.set('n', '<leader>?', '<Cmd>Cheat<CR>', {})
		end,
    cmd = { 'Cheat', 'CheatEdit' },
	},

	{
		'folke/which-key.nvim',
    lazy = false,
    -- event = 'CursorHold',
    init = function ()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
    end,
		config = true,
	},

  -- sl
  {
    'eandrju/cellular-automaton.nvim',
    cmd = {
      'CellularAutomaton'
    }
  },

	-- colorscheme
  {
    'EdenEast/nightfox.nvim',
    'arcticicestudio/nord-vim',
    'Yazeed1s/oh-lucy.nvim',
    'sainnhe/gruvbox-material',
    'AlexvZyl/nordic.nvim',
    'RRethy/nvim-base16',
  }
}, {
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
  }
})

-- colorscheme
vim.opt.background = 'dark'
vim.cmd([[colorscheme nordic]])
