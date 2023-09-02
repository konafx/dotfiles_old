---------------------------------------------------------------------------------------------------+
-- Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
-- ================================================================================================+
-- map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
-- nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
-- map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
-- imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
-- cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
-- vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
-- xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
-- smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
-- omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
-- tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
-- lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
---------------------------------------------------------------------------------------------------+

local keymap = vim.keymap

-- １文字貼り付け防止
keymap.set('', 'x', '"_x')

-- 水平移動
keymap.set('', 'H', '^')
keymap.set('', 'L', 'g_')

-- インデントしても選択領域を保持
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')
keymap.set('v', '=', '=gv')

-- `*`検索の初回移動無効{{{
keymap.set('n', '*', function()
	return vim.v.count >= 1 and '*'
		or [[<Cmd>sil exe "keepj norm! *" <Bar> call winrestview(]]
			.. vim.fn.string(vim.fn.winsaveview())
			.. ')<CR>'
end, { silent = true, expr = true })
-- }}}

-- save
keymap.set('n', '<Leader>w', '<Cmd>w<CR>', { silent = true })

-- clear hylight
keymap.set('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>', { noremap = false })

-- Make inputting a character by code easily.{{{
keymap.set(
	'i',
	'<Plug>(vimrc-input-char-by-code)',
	[[<C-r>=nr2char(eval(input('char? ', '0x')))<CR>]],
	{ noremap = true }
)
keymap.set('i', '<C-v>x', '<Plug>(vimrc-input-char-by-code)', { noremap = false })
keymap.set('i', '<C-v>u', '<Plug>(vimrc-input-char-by-code)', { noremap = false })
keymap.set('i', '<C-v>U', '<Plug>(vimrc-input-char-by-code)', { noremap = false })
-- }}}

-- Toggle quickfix window {{{
keymap.set('n', '<Leader>q', function()
	local nr = vim.fn.winnr('$')
	vim.cmd('cwindow')
	local nr2 = vim.fn.winnr('$')
	if nr == nr2 then
		vim.cmd('cclose')
	end
end, { silent = true })
-- }}}

-- reload myvimrc
keymap.set('n', '<Leader>r', [[<Cmd>source $MYVIMRC<CR>]], { noremap = false })

-- [tab] {{{
keymap.set('', '[tab]', '<Nop>')
keymap.set('n', 't', '[tab]', { remap = true })

keymap.set('n', '[tab]n', '<Cmd>tabnext<CR>', { silent = true })
keymap.set('n', '[tab]p', '<Cmd>tabprevious<CR>', { silent = true })
keymap.set('n', '[tab]e', '<Cmd>tabedit<CR>', { silent = true })
keymap.set('n', '[tab]c', '<Cmd>tabclose<CR>', { silent = true })
keymap.set('n', '[tab]o', '<Cmd>tabonly<CR>', { silent = true })
-- }}}

-- [motion] {{{
keymap.set('', '[motion]', '<Nop>')
keymap.set('n', 'm', '[motion]', { remap = true })
-- }}}

-- [lsp] {{{
keymap.set('', '[lsp]', '<Nop>')
keymap.set('n', ']', '[lsp]', { remap = true })
-- }}}

-- [term] {{{
keymap.set('', '[term]', '<Nop>')
keymap.set({'n', 't'}, '<Leader>t', '[term]', { remap = true })
-- https://zenn.dev/fuzmare/articles/vim-term-escape
keymap.set('t', '<ESC>', '<C-\\><C-n><Plug>(esc)', { noremap = true })
keymap.set('n', '<Plug>(esc)<ESC>', 'i<ESC>', { noremap = true })
-- floaterm
keymap.set('n', '[term]c', '<Cmd>FloatermNew<CR>', { silent = true })
keymap.set('t', '[term]c', '<ESC><Cmd>FloatermNew<CR>', { silent = true })
keymap.set('n', '[term]p', '<Cmd>FloatermPrev<CR>', { silent = true })
keymap.set('t', '[term]p', '<ESC><Cmd>FloatermPrev<CR>', { silent = true })
keymap.set('n', '[term]n', '<Cmd>FloatermNext<CR>', { silent = true })
keymap.set('t', '[term]n', '<ESC><Cmd>FloatermNext<CR>', { silent = true })
keymap.set('n', '[term]t', '<Cmd>FloatermToggle<CR>', { silent = true })
keymap.set('t', '[term]t', '<ESC><Cmd>FloatermToggle<CR>', { silent = true })
-- }}}

-- disabled {{{
keymap.set('n', '<C-]>', '<Nop>')
-- }}}
