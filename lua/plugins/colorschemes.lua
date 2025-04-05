return {
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'frappe', -- latte, frappe, macchiato, mocha
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
          neogit = true,
          notify = true,
          noice = true,
          mini = {
            enabled = true,
            indentscope_color = 'lavender',
          },
          which_key = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
        custom_highlights = function(colors)
          local highlights = {}

          local spell_options = { style = { 'undercurl' }, fg = colors.red }
          local spell_groups = { 'SpellBad', 'SpellCap', 'SpellLocal', 'SpellRare' }
          for _, v in ipairs(spell_groups) do
            highlights[v] = spell_options
          end

          return highlights
        end,
      })
      -- load the colorscheme here
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  -- {
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('tokyonight').setup()
  --     vim.cmd.colorscheme('tokyonight')
  --   end,
  -- },
}
