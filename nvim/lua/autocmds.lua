local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

create_autocmd('filetype', { -- {{{
	group = create_augroup('DisableInsertNextlineComment', {}),
	pattern = '*',
	command = 'setlocal formatoptions-=ro',
}) -- }}}

-- Turn off paste mode when leaving insert{{{
create_autocmd('InsertLeave', {
	pattern = '*',
	command = 'set nopaste',
}) -- }}}

-- QuickFixGrep{{{
create_autocmd('QuickFixCmdPost', {
	group = create_augroup('QuickFixGrep', {}),
	pattern = { 'make', '*grep*' },
	command = 'cwindow',
}) -- }}}

-- Automaticaly Packer Reload{{{
-- https://github.com/wbthomason/packer.nvim/blob/6afb67460283f0e990d35d229fd38fdc04063e0a/README.md?plain=1#L202-L222
create_autocmd('BufWritePost', {
	group = create_augroup('PackerUserConfig', {}),
	pattern = 'plugins.lua',
	command = 'source <afile> | PackerCompile',
}) -- }}}

-- 背景透過{{{
if vim.env.TRANSPARENT_TERM == '1' then
	create_autocmd('Colorscheme', {
		group = vim.api.nvim_create_augroup('TransparentBackground', {}),
		pattern = '*',
		callback = function()
			vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'NONE', guibg = 'NONE' })
			vim.api.nvim_set_hl(0, 'NonText', { ctermbg = 'NONE', guibg = 'NONE' })
			vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = 'NONE', guibg = 'NONE' })
			vim.api.nvim_set_hl(0, 'Folded', { ctermbg = 'NONE', guibg = 'NONE' })
			vim.api.nvim_set_hl(0, 'EndOfBuffer', { ctermbg = 'NONE', guibg = 'NONE' })
		end,
	})
end -- }}}

-- disable autofold at writing{{{
local shut_up_auto_fold_at_writing = create_augroup('ShutUpAutoFoldAtWriting', {})
create_autocmd('BufWinLeave', {
	group = shut_up_auto_fold_at_writing,
	pattern = '*',
	command = [[if expand('%') != '' && &buftype != 'nofile' | mkview | endif]],
})
create_autocmd('BufWinEnter', {
	group = shut_up_auto_fold_at_writing,
	pattern = '*',
	command = [[if expand('%') != '' && &buftype != 'nofile' | silent! loadview | endif]],
}) -- }}}
