local ok, wk = pcall(require, 'which-key')
if not ok then
	print('which-key is not installed')
end

-- [lsp]を押しても表示されない. :WhichKey [lsp]には登録されている
wk.register({
	['['] = { '<Cmd>Lspsaga diagnostic_jump_prev<CR>' },
	[']'] = { '<Cmd>Lspsaga diagnostic_jump_next<CR>' },
	e = { '<Cmd>Lspsaga show_cursor_diagnostics<CR>' },
	D = { 'Declaration' },
	['<C-d>'] = { 'vim.lsp.buf.definition' },
	d = { '<Cmd>Lspsaga peek_definition<CR>' },
	i = { 'Implementation' },
	f = { '<Cmd>Lspsaga lsp_finder<CR>' },
	F = { 'Format' }
}, {
	mode = 'n',
	prefix = '[lsp]',
})
