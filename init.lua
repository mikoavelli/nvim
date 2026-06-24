local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins.ui" },
	{ import = "plugins.lang" },
})

local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }

local diagnostics = {
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.Error,
			[vim.diagnostic.severity.WARN] = icons.Warn,
			[vim.diagnostic.severity.HINT] = icons.Hint,
			[vim.diagnostic.severity.INFO] = icons.Info,
		},
	},
}

if type(diagnostics.virtual_text) == "table" and diagnostics.virtual_text.prefix == "icons" then
	diagnostics.virtual_text.prefix = function(diagnostic)
		for d, icon in pairs(icons) do
			if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
				return icon
			end
		end
		return "●"
	end
end

vim.diagnostic.config(diagnostics)

vim.api.nvim_create_augroup("Indents", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "Indents",
	pattern = "lua",
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = "Indents",
	pattern = { "sh", "bash", "zsh" },
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end,
})
