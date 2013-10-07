function get_item_meta (string)
	if string.find(string, "return {") then
		return minetest.deserialize(string)
	else return nil
	end
end

function set_item_meta (table)
	return minetest.serialize(table)
end

function nothing(...) end

-- it's safe for machines to use minetest.node_dig here w/out drops happening
function technic.override_node_drops(handler)
    if minetest.handle_node_drops == nothing then
        handler()
    else
        local disabled_node_drops = minetest.handle_node_drops
        minetest.handle_node_drops = nothing
        -- pcall here? nah, let errors just kill everything. #theluaway
        handler()
        minetest.handle_node_drops = disabled_node_drops
    end
end
