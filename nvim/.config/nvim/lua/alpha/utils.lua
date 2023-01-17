local utils = {}

utils.save_and_exec = function()
	local source_commands = {
		lua = "luafi %",
		vim = "source %",
	}

	local ft = vim.api.nvim_buf_get_option(0, "filetype")
	local command = source_commands[ft]
	if command == nil then
		vim.notify("This type cant not be sourced", vim.log.levels.ERROR)
		return
	end

	-- Save and source
	vim.api.nvim_command("silent w")
	vim.api.nvim_command(command)

	local current_file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	vim.notify(string.format("File %s Sourced", current_file_name), vim.log.levels.INFO)
end

utils.get_plugins_names = function ()
	local files = vim.api.nvim_get_runtime_file('lua/alpha/plugins/*.lua', true)
    local plugins = {}

    for _, file in pairs(files) do
		plugins[file] = 1
    end

    return vim.tbl_keys(plugins)
end

utils.get_plugins_configuration = function (plugins_names)
    local configs = {}

    for _, name in pairs(plugins_names) do
        local plugin = require("alpha.plugins."..name)
        local config = plugin[1]
		if (plugin['setup'] ~= nil) then
			config.setup = string.format("require('alpha.plugins.%s').setup()", name)
		end
		if (plugin['config'] ~= nil) then
			config.setup = string.format("require('alpha.plugins.%s').config()", name)
		end

        table.insert(configs, config)
    end

    return configs
end

return utils
