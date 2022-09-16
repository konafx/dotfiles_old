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

-- Automaticaly Packer Reload
-- https://github.com/wbthomason/packer.nvim/blob/6afb67460283f0e990d35d229fd38fdc04063e0a/README.md?plain=1#L202-L222
create_autocmd('BufWritePost', {
  group = create_augroup('PackerUserConfig', {}),
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
})
