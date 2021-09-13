local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

local get_master_node = function()

    local node = ts_utils.get_node_at_cursor()
    if node == nil then
        error("No treesitter parser found.")
    end

    local start_row = node:start()

    local parent = node:parent()
    while (parent ~= nil and parent:start() == start_row) do
        node = parent
        parent = node:parent()
    end


    return node
end


M.setter_getter = function()
    local node = get_master_node()

    if node.type(node) ~= 'property_declaration' then
        error('can not work on a node that is not a property_declaration')
    end

    local bufnr = vim.api.nvim_get_current_buf()
    -- ts_utils.update_selection(bufnr, node)

    local p = {}
    for _, child in ipairs(ts_utils.get_named_children(node)) do
        -- print(vim.inspect(ts_utils.get_node_text(child, bufnr)))
        -- print(vim.inspect(child.type(child)))
        p[node.type(child)] = ts_utils.get_node_text(child, bufnr)[1]
    end

    -- for this expected to have 2 or more named childs
    -- visibility modifier
    -- type_list (optional) could have a  ?  to be nullable or could have a list
    -- property_element
    -- print(vim.inspect(p))

    local comment = ''

    if (p.type_list == 'array' or p.type_list == nil) then
        local prev = ts_utils.get_previous_node(node, false, false)
        if (node.type(prev) == 'comment') then
            comment = ts_utils.get_node_text(prev)[1]
            comment = string.match(comment, '@var (.*) ')
        end
        -- print(vim.inspect(node.type(prev)))
        -- print(vim.inspect(ts_utils.get_node_text(prev)))
    end

    -- print(vim.inspect(comment))
    -- if  type_list is not present could go up and read the comment
    -- and base on a regular expression, and  get  the type
    -- if the type is array want to also read to see if is a typed array
    --
    local classNode = node:parent()
    local classEnd = classNode:end_()

    local variable = string.sub(p.property_element, 2)

    local function firstToUpper(str)
        return (str:gsub("^%l", string.upper))
    end

    local varType = p.type_list

    local insert = {}
    table.insert(insert, "")
    if (comment ~= nil) then
        table.insert(insert, "    /**")
        table.insert(insert, string.format("\t * @return %s", comment))
        table.insert(insert, "     */")
    end
    table.insert(insert, string.format("\tpublic function get%s(): %s", firstToUpper(variable), varType))
    table.insert(insert, "    {")
    table.insert(insert, string.format("\t\treturn $this->%s;", variable))
    table.insert(insert, "    }")
    table.insert(insert, "")

    if (comment ~= nil) then
        table.insert(insert, "    /**")
        table.insert(insert, string.format("\t * @param %s %s", comment, p.property_element))
        table.insert(insert, "     *")
        table.insert(insert, "     * @return self")
        table.insert(insert, "     */")
    end
    table.insert(insert, string.format("\tpublic function set%s(%s %s): self", firstToUpper(variable), varType, p.property_element))
    table.insert(insert, "    {")
    table.insert(insert, string.format("\t\t$this->%s = %s;", variable, p.property_element))
    table.insert(insert, "")
    table.insert(insert, string.format("\t\treturn $this;"))
    table.insert(insert, "    }")

    vim.api.nvim_buf_set_lines(bufnr, classEnd, classEnd, false, insert)

end

return M