return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
    'mmllr/neotest-swift-testing',
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-vitest')({
          -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
        }),
        require('neotest-swift-testing'),
      },
    })
  end,
  keys = {
    {
      '<leader>tc',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run Neotest Closest',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      desc = 'Run Neotest File',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle Neotest Summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open({ enter = true, auto_close = true })
      end,
      desc = 'Toggle Neotest Output',
    },
  },
}
