local ok, neogit = pcall(require, 'neogit')
if not ok then
	print('neogit is not installed')
	return
end

neogit.setup({
	disable_commit_confirmation = true,
	integrations = {
		diffview = true,
	},
})

local keymap = vim.keymap
keymap.set('n', '[git]', '<Nop>')
keymap.set('n', '<Leader>g', '[git]', { remap = true })

-- keymap.set('n', '[git]f', '<Cmd>Clap git_files<CR>', { silent = true })
keymap.set('n', '[git]s', function()
	neogit.open({ kind = 'replace' })
end, { silent = true })
keymap.set('n', '[git]b', function()
	neogit.open({ 'branch', kind = 'split' })
end, { silent = true })
keymap.set('n', '[git]l', function()
	neogit.open({ 'log' })
end, { silent = true })
