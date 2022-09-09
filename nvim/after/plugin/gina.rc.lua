---  [git] {{{
local keymap = vim.keymap
keymap.set('n', '[git]', '<Nop>')
keymap.set('n', '<Leader>g', '[git]', { remap = true })

-- keymap.set('n', '[git]f', '<Cmd>Clap git_files<CR>', { silent = true })
keymap.set('n', '[git]s', '<Cmd>Gina status -s<CR>', { silent = true })
keymap.set('n', '[git]b', '<Cmd>Gina branch<CR>', { silent = true })
keymap.set('n', '[git]l', '<Cmd>Gina log<CR>', { silent = true })
--- }}}
