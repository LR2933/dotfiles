return{
    {
		"saghen/blink.cmp",
		build = 'cargo build --release',
		opts = {
			completion = {
				menu = {
					winblend = vim.o.pumblend,
				},
			},
			signature = {
				window = {
					winblend = vim.o.pumblend,
				},
			},
		},
	},
} 
