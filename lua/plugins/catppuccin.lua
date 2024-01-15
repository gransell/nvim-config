return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = 'dark',
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { 'italic' }, -- Change the style of comments
      conditionals = { 'italic' },
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = false,
      treesitter = true,
      neotree = true,
      notify = true,
      noice = true,
      mini = {
        enabled = true,
        indentscope_color = 'lavender',
      },
      indent_blankline = {
        enabled = true,
        scope_color = 'lavender', -- catppuccin color (eg. `lavender`) Default: text
        colored_indent_levels = false,
      },
      which_key = true,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  },
  config = function()
    -- load the colorscheme here
    vim.cmd [[colorscheme catppuccin]]
  end,
}
