local M = {}

function M.init()
  local function builtin(name)
    return function(opt)
      return function()
        return require("telescope.builtin")[name](opt or {})
      end
    end
  end

  local function extensions(name, prop)
    return function(opt)
      return function()
        local telescope = require "telescope"
        telescope.load_extension(name)
        return telescope.extensions[name][prop](opt or {})
      end
    end
  end

  local function telescope_buffer_dir()
    return vim.fn.expand('%:p:h')
  end

  vim.keymap.set('', '[telescope]', '<Nop>')
  vim.keymap.set('n', '<Leader>f', '[telescope]', { remap = true })

  vim.keymap.set('n', '[telescope]f', builtin('find_files') {
      no_ignore = false,
      hidden = true,
    }
  )
  vim.keymap.set('n', '[telescope]F', builtin('builtin') {})
  vim.keymap.set('n', '[telescope]g', builtin('live_grep') {})
  vim.keymap.set('n', '[telescope]b', builtin('buffers') {})
  vim.keymap.set('n', '[telescope]t', builtin('help_tags') {})
  vim.keymap.set('n', '[telescope]r', builtin('resume') {})
  vim.keymap.set('n', '[telescope]e', builtin('diagnostics') {})
  vim.keymap.set('n', 'sf', extensions('file_browser', 'file_browser') {
      path = '%:p:h',
      cwd = telescope_buffer_dir(),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      layout_strategy = 'horizontal',
      collapse_dirs = true,
      layout_config = {
        prompt_position = 'top',
        height = 0.85,
        width = 0.85,
      },
    }
  )
end

function M.config()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    print('telescope is not loaded')
    return
  end

  local actions = require('telescope.actions')

  local fb_actions = telescope.extensions.file_browser.actions
  telescope.setup({
    defaults = {
      mappings = {
        n = {
          ['q'] = actions.close,
          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,
        },
      },
      file_ignore_patterns = {
        '.git/',
        '.cache',
        '%.o',
        '%.a',
        '%.out',
        '%.class',
        '%.pdf',
        '%.mkv',
        '%.mp4',
        '%.zip',
        '.gitkeep',
      },
    },
    extensions = {
      file_browser = {
        theme = 'dropdown',
        --disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          -- your custom insert mode mappings
          i = {
            ['<C-w>'] = function()
              vim.cmd('normal vbd')
            end,
          },
          n = {
            -- your custom normal mode mappings
            ['N'] = fb_actions.create,
            ['h'] = fb_actions.goto_parent_dir,
            ['<C-h>'] = fb_actions.toggle_hidden,
            ['/'] = function()
              vim.cmd('startinsert')
            end,
          },
        },
      },
      lazy = {
        theme = "ivy",
        show_icon = true,
        mappings = {
          open_in_browser = "<C-o>",
          open_in_find_files = "<C-f>",
          open_in_live_grep = "<C-g>",
          open_plugins_picker = "<C-b>", -- Works only after having called first another action
          open_lazy_root_find_files = "<C-r>f",
          open_lazy_root_live_grep = "<C-r>g",
        },
      }
    },
  })

  telescope.load_extension('file_browser')
  telescope.load_extension('lazy')
end

return M
