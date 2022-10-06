local keymap = vim.keymap

keymap.set('', '[gh]', '<Nop>')
keymap.set('n', '<leader>G', '[gh]', { remap = true })
