local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

create_autocmd('filetype', {
  group = create_augroup('DisableInsertNextlineComment', {}),
  pattern = '*',
  command = 'setlocal formatoptions-=ro'
})

-- Turn off paste mode when leaving insert
create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste'
})

-- QuickFixGrep
create_autocmd('QuickFixCmdPost', {
  group = create_augroup('QuickFixGrep', {}),
  pattern = {'make', '*grep*'},
  command = 'cwindow',
})
