vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

local disable_plugins = {
  -- Disable TOhtml.
  'loaded_2html_plugin',

  -- Disable archive file open and browse.
  'loaded_gzip',
  'loaded_tar',
  'loaded_tarPlugin',
  'loaded_zip',
  'loaded_zipPlugin',

  -- Disable vimball.
  'loaded_vimball',
  'loaded_vimballPlugin',

  -- Disable netrw plugins.
  'loaded_netrw',
  'loaded_netrwPlugin',
  'loaded_netrwSettings',
  'loaded_netrwFileHandlers',

  -- Disable `GetLatestVimScript`.
  'loaded_getscript',
  'loaded_getscriptPlugin',

  -- Disable other plugins
  'loaded_man',
  'loaded_matchit',
  'loaded_matchparen',
  'loaded_shada_plugin',
  'loaded_spellfile_plugin',
  'loaded_tutor_mode_plugin',
  'did_install_default_menus',
  'did_install_syntax_menu',
  'skip_loading_mswin',
  'did_indent_on',
  'did_load_ftplugin',
  'loaded_rrhelper',
}

for _, name in pairs(disable_plugins) do
  vim.g[name] = 1
end

require('plugins')
require('base')
require('extensions')
require('keymaps')
require('autocmds')
