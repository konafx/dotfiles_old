vim.keymap.set('', '<S-t>', '<Cmd>Fern . -drawer -reveal=% -toggle<CR>')

vim.api.nvim_create_augroup('FernNoNumber', {})
vim.api.nvim_create_autocmd('filetype', {
	group = 'FernNoNumber',
	pattern = 'fern',
	callback = function()
		vim.opt_local.number = false
	end,
})

vim.g['fern#renderer'] = 'nerdfont'
