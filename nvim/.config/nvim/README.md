# My Nvim configuraiton

how to configure the the plugins

Option 1
Have 1 plugins file which defines all the plugins and the configurations sources

Option 2
Have 1 file per plugin with a given estructure like
```lua
return {
    {
        "plugin-name",
        ... -- options
        useLocal = true, -- custom option
    },
    "setup" = function ()
    end,
    "config" = function ()
    end,
}

-- this structure should be difene for autocompletition

-- this will be translated for packer as
use({
    "plugin-name",
    ..., -- options
    "setup" = "require('<lua-module>.filename').setup()",
    "config" = "require('<lua-module>.filename').config()"
})

requirement cant use another plugin like plenary since that requires to be install by packer.
Hard to think as a package is moro a configuration for me not general

to look for files found that can be use `vim.api.nvim_get_runtime_file` as native solution with `lua/alpha/plugins/*.lua`
as argument
move the current `plugins.lua` to `plugin_manager.lua` or `packer.lua` to be included and compiled

TODO:
- move `plugins.lua` to `packer.lua`
- create a plugins folder to hold the plugins configuration
- create a function in `packer.lua` to get the files on `plugins/*.lua`
    ```lua
    vim.api.nvim_get_runtime_file('lua/alpha/*.lua', true)
    -- map just the filename
    ```
- create a function to get the table to map from the new configuration to packer one
- Want to allow hybrid momentary so can step by step moving the plugins

```
Problem not a single point of reference for the plugins, and the same need to create a new file
I need to have
- quick way to seach plugins by name, telescope can profile file search in a directory
- improved can have a plugin that list the plugins and where is defined
- quick action to create a file for provided plugin

What to do if you want config inside config use the packer one not this style

Option 3
Have different modules which each is included in packer and each provides configuration
this have the same problem as the first one. having the configuration splitted
