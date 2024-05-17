-- Overwrite / and ?.
vim.keymap.set({ 'n', 'x' }, '?', [[<Cmd>call searchx#start({ 'dir': 0 })<CR>]])
vim.keymap.set({ 'n', 'x' }, '/', [[<Cmd>call searchx#start({ 'dir': 1 })<CR>]])
-- vim.keymap.set('c', ';', '<Cmd>call searchx#select()<CR>')

-- Move to next/prev match.
vim.keymap.set({ 'n', 'x' }, 'N', '<Cmd>call searchx#prev_dir()<CR>')
vim.keymap.set({ 'n', 'x' }, 'n', '<Cmd>call searchx#next_dir()<CR>')
vim.keymap.set({ 'n', 'x', 'c' }, '<C-k>', '<Cmd>call searchx#prev()<CR>')
vim.keymap.set({ 'n', 'x', 'c' }, '<C-j>', '<Cmd>call searchx#next()<CR>')

-- Clear highlights
vim.keymap.set('n', '<C-l>', '<Cmd>call searchx#clear()<CR>')

vim.g.searchx = {
	-- Auto jump if the recent input matches to any marker.
	auto_accept = true,
	-- The scrolloff value for moving to next/prev.
	scrolloff = vim.o.scrolloff,
	-- To enable scrolling animation.
	scrolltime = 0,
	-- To enable auto nohlsearch after cursor is moved
	nohlsearch = { jump = true },
	-- Marker characters.
	markers = vim.fn.split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', [[.\zs]]),
	-- Convert search pattern.
	convert = function(input)
		local c = [[\k]]
		if not c:match(input) then
			return [[\V]] .. input
		end
		return string.sub(input, 0, 1) .. vim.fn.substitute(string.sub(input, 1), [[\\\@<! ]], [[.\\{-}]], 'g')
	end,
}

-- [TODO] vim.api.nvim_set_hl(0, 'SearchxMarker', { bg = 'cyan' })
