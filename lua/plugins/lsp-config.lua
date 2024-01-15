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
      require('mason-lspconfig').setup {
        ensure_installed = { 'rust_analyzer', 'tsserver', 'lua_ls', 'eslint' },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local lsp = require 'lspconfig'
      lsp.lua_ls.setup {
        capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
      lsp.tsserver.setup {
        capabilities,
        settings = {
          -- Disable the <variable> is declared but its value is never read warning for TS
          diagnostics = { ignoredCodes = { 6133 } },
          completions = {
            completeFunctionCalls = true,
          },
          -- documentFormatting = false
        },
      }

      lsp.sourcekit.setup {
        capabilities,
      }

      lsp.eslint.setup {
        capabilities,
        settings = {
          workingDirectory = { mode = 'location' },
        },
        root_dir = lsp.util.find_git_ancestor,
      }

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

          nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
          nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
          nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
          nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- See `:help K` for why this keymap
          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        end,
      })
    end,
  },
}
