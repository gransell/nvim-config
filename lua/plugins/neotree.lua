return 
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
    },
    window = {
        mappings = {
          ['<space>'] = 'none',
        },
    },
    default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require 'neo-tree'
        end
      end

      -- Toggle file browser
      vim.keymap.set('n', '<leader>e', function()
        require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
      end, { desc = 'Toggle file explorer' })
    end,
  }
