local wo = vim.wo
-- 行番号表示
wo.number = true

local opt = vim.opt
--
opt.title = true

-- Indent {{{
-- tab to space
opt.expandtab = true
-- 4 spaces are tab
opt.tabstop = 4
-- Tab押下→space何個, 0→tabstopの値を参照
opt.softtabstop = 0
-- インデントに使う空白の数
opt.shiftwidth = 2
opt.smartindent = true
-- indentを守る
opt.autoindent = true
--- }}}

opt.hlsearch = true

-- dont be afraid
opt.backup = false
opt.swapfile = false

opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.scrolloff = 10
opt.backupskip = { '/tmp/*', '/private/tmp/*' }
opt.inccommand = 'split'
opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.smarttab = true
opt.breakindent = true
opt.tabstop = 2
opt.wrap = false -- No Wrap lines
opt.backspace = { 'start', 'eol', 'indent' }
opt.path:append { '**' } -- Finding files - Search down into subfolders
opt.wildignore:append { '*/node_modules/*' }
opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.wildoptions = 'pum'
opt.pumblend = 5

opt.belloff = 'all'

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Highlight {{{
-- 特殊文字をわかりやすくする
opt.list = true
opt.listchars = [[tab:▸-,trail:-,extends:»,precedes:«]]
-- ↑の付随: Grey rbg(95, 95, 135)にする
vim.api.nvim_set_hl(0, 'NonText', { ctermfg = 59 })
vim.api.nvim_set_hl(0, 'SpecialKey', { ctermfg = 59 })
-- hi.create: https://www.reddit.com/r/neovim/comments/me35u9/comment/gsgfcya/?utm_source=reddit&utm_medium=web2x&context=3
-- }}}

-- Search {{{
-- 大文字小文字の区別をしない
opt.ignorecase = true
-- 検索が末尾に届いたら、先頭に戻る
opt.smartcase = true
-- 大文字で検索したときは大文字のみ検索
opt.wrapscan = true
-- 複数一致時、全一致を羅列し、共通最長文字列を補完
opt.wildmode = 'list:longest'
--- }}}

-- Undercurl
local cmd = vim.cmd
cmd [[let &t_Cs = "\e[4:3m"]]
cmd [[let &t_Ce = "\e[4:0m"]]

-- Suppress autoindent pasting clipboard
vim.keymap.set('n', '<F10>', [[<C-u>exe "normal" (getline(".")==""?"I":"o")<CR>i<C-o>:set paste<CR>]], {})
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    vim.opt.paste = false
  end
})

-- Add asterisks in block comments
opt.formatoptions:append { 'r' }

-- mapleader
local g = vim.g
g.mapleader = ','

-- colorscheme
opt.background = 'dark'
cmd [[colorscheme nightfox]]
