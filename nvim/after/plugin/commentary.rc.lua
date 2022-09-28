vim.keymap.set({ 'n', 'x', 'o' }, '<Leader>c', '<Plug>Commentary', { noremap = false });
vim.keymap.set('n', '<Leader>cc', '<Plug>CommentaryLine', { noremap = false });
vim.keymap.set('n', '<Leader>cu', '<Plug>Commentary<Plug>Commentary', { noremap = false });
