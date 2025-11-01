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
        automatic_enable = false,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('lua_ls', {
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

      vim.lsp.config('ts_ls', {
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
      vim.lsp.config('sourcekit', {
        cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' },
        root_dir = function(bufnr, on_dir)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          if filename == '' then
            return
          end

          local root = util.root_pattern('Package.swift')(filename)
            or util.root_pattern('buildServer.json')(filename)
            or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
            or util.find_git_ancestor(filename)

          if root then
            on_dir(root)
          end
        end,
      })

      vim.lsp.enable({ 'lua_ls', 'ts_ls', 'sourcekit', 'biome', 'pyright', 'ruff', 'rust_analyzer' })

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
            local filter = { bufnr = bufnr }
            local enabled = vim.lsp.inlay_hint.is_enabled(filter)
            vim.lsp.inlay_hint.enable(not enabled, filter)
          end
          nmap('<leader>cth', toggle_inlay_hints, 'Toggle inlay hints')
        end,
      })
    end,
  },
}
