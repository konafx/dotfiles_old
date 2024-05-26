local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- BB abbreviate {{{
-- NOTE: NOT WORKING
create_autocmd('filetype', {
	group = create_augroup('GitBBAbbr', {}),
	pattern = 'gitcommit',
	command = 'inoreabbrev <buffer> BB BREAKING CHANGE:'
})
-- }}}

-- Complete types {{{
local function commit_type()
	-- https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional
	vim.fn.complete(1, {
		'chore: ',
		'ci: ',
		'docs: ',
		'feat: ',
		'fix: ',
		'perf: ',
		'refactor: ',
		'revert: ',
		'style: ',
		'test: '
	})
	vim.api.nvim_buf_del_keymap(0, 'n', 'i')
	return ''
end

vim.api.nvim_buf_set_keymap(0, 'n', 'i', 'i<C-r>=v:lua.commit_type()<CR>', { noremap = true })

_G.commit_type = commit_type
-- }}}
