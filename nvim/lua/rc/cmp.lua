local M = {}

function M.init() end

function M.config()
  local cmp = require('cmp')

  local ok, lspkind = pcall(require, 'lspkind')
  if not ok then
    return
  end

  local ok, luasnip = pcall(require, 'luasnip')
  if not ok then
    print('luasnip is not installed')
  end

  local has_words_before = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    return (vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)[1] or '')
      :sub(cursor[2], cursor[2])
      :match('%s')
  end

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-l>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp', priority = 100 },
      { name = 'luasnip', priority = 30 },
      { name = 'buffer', priority = 50 },
      -- { name = 'skkeleton', priority = 100 },
    },
    formatting = {
      format = lspkind.cmp_format { with_text = false, maxwidth = 50 },
    },
  }

  vim.cmd([[
    set completeopt=menuone,noinsert,noselect
    highlight! default link CmpItemKind CmpItemMenuDefault
  ]])
end

return M
