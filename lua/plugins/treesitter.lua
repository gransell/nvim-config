return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath('data') .. '/site',
      })
      require('nvim-treesitter').install({
        'lua',
        'regex',
        'bash',
        'markdown_inline',
        'xml',
        'swift',
        'tsx',
        'typescript',
        'jsx',
        'javascript',
        'rust',
        'zig',
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'lua', 'swift', 'typescript', 'tsx', 'rust' },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
