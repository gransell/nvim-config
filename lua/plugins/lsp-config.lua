return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'pyright', 'rust_analyzer', 'ts_ls', 'lua_ls', 'biome', 'ruff' },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'folke/neodev.nvim', opts = { library = { plugins = { 'nvim-dap-ui' }, types = true } } },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local lsp = require('lspconfig')
      lsp.lua_ls.setup({
        capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim', 'Snacks' },
            },
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      })
      lsp.ts_ls.setup({
        capabilities,
        settings = {
          -- Disable the <variable> is declared but its value is never read warning for TS
          diagnostics = { ignoredCodes = { 2686, 6133, 80006 } },
          completions = {
            completeFunctionCalls = true,
          },
          -- documentFormatting = false
        },
      })

      local util = require('lspconfig.util')
      lsp.sourcekit.setup({
        capabilities,
        cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' },
        root_dir = function(filename, _)
          return util.root_pattern('Package.swift')(filename)
            or util.root_pattern('buildServer.json')(filename)
            or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
            or util.find_git_ancestor(filename)
        end,
      })

      lsp.biome.setup({ capabilities })

      lsp.pyright.setup({ capabilities })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local bufnr = ev.buf

          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<leader>cr', vim.lsp.buf.rename, '[C]ode Rename')
          nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode Action')

          local function toggle_inlay_hints()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
          end
          nmap('<leader>cth', toggle_inlay_hints, 'Toggle inlay hints')
        end,
      })
    end,
  },
}
