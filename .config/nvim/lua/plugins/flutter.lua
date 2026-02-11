return {
	'nvim-flutter/flutter-tools.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim', -- optional for enhanced UI
		'mfussenegger/nvim-dap', -- optional for debugging
		'rcarriga/nvim-dap-ui', -- optional for debugging UI
	},
	config = function()
		require('flutter-tools').setup {
			-- Optional: you can specify a function to control how the config is created
			lsp = {
				settings = {
					-- your dartls settings here
				}
			},
			debugger = {
				enabled = true, -- set to false to disable the debugger
				run_via_dap = true,
			},
			-- other options
		}
	end,
	ft = "dart", -- Automatically loads the plugin when opening a .dart file
}
