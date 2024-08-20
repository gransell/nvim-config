local diagnosticsIcons = {
  error = ' ',
  warn = ' ',
  info = ' ',
  hint = ' ',
}
local function xcodebuild_device()
  if vim.g.xcodebuild_platform == 'macOS' then
    return ' macOS'
  end

  if vim.g.xcodebuild_os then
    return ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'
  end

  return ' ' .. vim.g.xcodebuild_device_name
end

return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'diagnostics',
            symbols = diagnosticsIcons,
          },
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = {
              left = 1,
              right = 0,
            },
          },
          { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            -- color = Util.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            -- color = Util.fg("Constant"),
          },
          -- { "' ' .. vim.g.xcodebuild_last_status", color = { fg = 'Gray' } },
          -- { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = '#a6e3a1', bg = '#161622' } },
          { xcodebuild_device, color = { fg = '#f9e2af', bg = '#161622' } },
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
          },
        },
        lualine_y = {
          {
            'progress',
            separator = ' ',
            padding = { left = 1, right = 0 },
          },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return ' ' .. os.date('%R')
          end,
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    },
  },
  {
    'christoomey/vim-tmux-navigator',
  },
  {
    'folke/which-key.nvim',
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { 'n', 'v' },
        ['<leader>b'] = { name = '+buffer' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>f'] = { name = '+file/find' },
        -- ['<leader>g'] = { name = '+git' },
        ['<leader>h'] = { name = '+hunks' },
        ['<leader>q'] = { name = '+quit/session' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>w'] = { name = '+workspace' },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local ret = (diag.error and diagnosticsIcons.error .. diag.error .. ' ' or '') .. (diag.warning and diagnosticsIcons.warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },
  { 'echasnovski/mini.icons', version = false },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bd',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>bD',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Delete Buffer (Force)',
      },
    },
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup({})

      vim.keymap.set('n', '<leader>go', neogit.open, { desc = 'Open NeoGit' })
      vim.keymap.set('n', '<leader>gc', function()
        neogit.open({ 'commit' })
      end, { desc = 'Open NeoGit Commit' })
    end,
  },
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   version = '*',
  --   lazy = false,
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('nvim-tree').setup({})
  --   end,
  -- },
}
