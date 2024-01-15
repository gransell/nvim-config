return {
	"stevearc/conform.nvim",
	events = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = false })
			end,
			mode = { "" },
			desc = "Format buffer",
		},
	},
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			css = { "prettierd" },
			lua = { "stylua" },
			swift = { "swift_format" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	},
}
