return {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000, -- make sure to load this before all the other start plugins
	-- Optional; default configuration will be used if setup isn't called.
	config = function()
		require("everforest").setup({
			-- Your config here
		})
		vim.cmd("colorscheme everforest")
	end,
	-- "EdenEast/nightfox.nvim",
	-- lazy = false,
	-- config = function()
	-- 	require("nightfox").setup {
	-- 		options = {
	-- 			-- transparent = true,
	-- 		}
	-- 	}
	-- 	vim.cmd("colorscheme carbonfox")
	-- end
	-- https://github.com/rebelot/kanagawa.nvim
	-- "rebelot/kanagawa.nvim",
	-- config = function()
	-- 	require("kanagawa").setup {
	-- 		transparent = false,
	-- 		-- theme = "lotus"
	-- 	}
	--
	-- 	require("kanagawa").load "wave"
	-- end,
}
