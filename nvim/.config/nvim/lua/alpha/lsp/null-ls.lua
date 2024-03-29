local null_ls = require("null-ls")
local composer = require("composer")
local php_actions = require("php-code-actions")
local laravel_actions = require("laravel.code-actions")

local sources = {
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.formatting.jq,
	null_ls.builtins.code_actions.refactoring,

	php_actions.getter_setter,
	php_actions.file_creator,

	null_ls.builtins.diagnostics.phpstan.with({
		to_temp_file = false,
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}),
}

if composer.query({ "require", "symfony/framework-bundle" }) ~= nil then
	table.insert(sources, null_ls.builtins.diagnostics.phpcs.with({
		method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}))
elseif composer.query({ "require", "laravel/framework" }) ~= nil then
	table.insert(sources, null_ls.builtins.formatting.pint)
	table.insert(sources, laravel_actions.relationships)
end

null_ls.setup({
    sources = sources,
})

vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>vf", function()
	return vim.lsp.buf.format({ async = true })
end, {})
