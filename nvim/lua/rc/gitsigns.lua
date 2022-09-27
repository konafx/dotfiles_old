-- https://github.com/skanehira/dotfiles/blob/99ee31cbe3dea418474e2de5d1056db53b13e798/vim/init.lua#L363-L392
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gitsigns = package.loaded.gitsigns

    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gitsigns.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gitsigns.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    local opts = {
      buffer = bufnr,
      silent = true
    }
    -- Actions
    vim.keymap.set({ 'n', 'x' }, ']g', '<Cmd>Gitsigns stage_hunk<CR>', opts)
    vim.keymap.set({ 'n', 'x' }, '[g', '<Cmd>Gitsigns undo_stage_hunk<CR>', opts)
    vim.keymap.set({ 'o', 'x' }, 'ih', '<Cmd>Gitsigns select_hunk<CR>', opts)
    vim.keymap.set('n', 'mp', '<Cmd>Gitsigns preview_hunk<CR>', opts)
  end
})
