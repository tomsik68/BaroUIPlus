local InventoryInspection = {}

-- Returns the name of the last item before the specified slot
InventoryInspection.GetLastItemNameBeforeSlot = function(inventory, slotIndex)
    local prevItemForSlot = " "
    if slotIndex == 0 then return prevItemForSlot end

    for s = 0, slotIndex - 1 do
        local items = inventory.GetItemsAt(s)
        if #items > 0 then
            local item = inventory.GetItemAt(s)
            prevItemForSlot = item.Name
        end
    end

    return prevItemForSlot
end

-- Returns true if the inventory is sorted alphabetically
InventoryInspection.IsInventorySorted = function(inventory)
    local prevItem = " " -- space has a really low ASCII value
    for s = 0, inventory.Capacity - 1 do
        local items = inventory.GetItemsAt(s)
        if #items > 0 then
            local item = inventory.GetItemAt(s)
            if item.Name:sub(1, 1) < prevItem:sub(1, 1) then
                -- found counter-example
                return false
            end
            prevItem = item.Name
        end
    end
    return true
end

return InventoryInspection