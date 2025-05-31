local InventoryInspection = require("ItemInitialView.InventoryInspection")

-- Returns true if the feature is completely disabled in the config
local IsFeatureCompletelyDisabled = function(_slot, _slotIndex, _inventory)
    return not BaroUIPlusGlobal.Config.ItemInitialView.Enabled
end

-- Returns true if the inventory is too small to be included
local IsInventoryTooSmall = function(_slot, _slotIndex, inventory)
    return inventory.Capacity < BaroUIPlusGlobal.Config.ItemInitialView.SmallInventorySizeLimit
end

-- Returns true if the inventory needs to be skipped because it is player equipment and the feature is disabled on player equipment
local IsSkippedBecausePlayerEquipment = function(_slot, _slotIndex, inventory)
    return tostring(inventory.Owner) == "Human" and not BaroUIPlusGlobal.Config.ItemInitialView.EnableOnPlayerEquipment
end

-- Returns true if the inventory needs to be skipped because the feature is enabled only on sorted inventories and the inventory is not sorted
local IsSkippedBecauseNotSorted = function(_slot, _slotIndex, inventory)
    return BaroUIPlusGlobal.Config.ItemInitialView.OnlyOnSorted and not InventoryInspection.IsInventorySorted(inventory)
end

-- Returns true if the previous item before the specified slot is the same as the item in the specified slot
local IsPreviousItemSameAsCurrent = function(_slot, slotIndex, inventory)
    local prevItemForSlot = InventoryInspection.GetLastItemNameBeforeSlot(inventory, slotIndex)
    return prevItemForSlot:sub(1, 1) == inventory.GetItemAt(slotIndex).Name:sub(1, 1)
end

local IsSlotEmpty = function(_slot, slotIndex, inventory)
    return inventory.IsSlotEmpty(slotIndex)
end

local IsSlotBeingDragged = function(slot, _slotIndex, _inventory)
    return Inventory.DraggingSlot == slot
end

Filter = {}

-- Returns true if the specified slot is skipped
Filter.IsSkipped = function(slot, slotIndex, inventory)
    local Filters = {
        {
            Name = "FeatureCompletelyDisabled",
            Function = IsFeatureCompletelyDisabled,
        },
        {
            Name = "InventoryTooSmall",
            Function = IsInventoryTooSmall,
        },
        {
            Name = "SkippedBecausePlayerEquipment",
            Function = IsSkippedBecausePlayerEquipment,
        },
        {
            Name = "SkippedBecauseNotSorted",
            Function = IsSkippedBecauseNotSorted,
        },
        {
            Name = "IsSlotEmpty",
            Function = IsSlotEmpty,
        },
        {
            Name = "IsBeingDragged",
            Function = IsSlotBeingDragged,
        },
        {
            Name = "IsPreviousItemSameAsCurrent",
            Function = IsPreviousItemSameAsCurrent,
        },
    }

    for filter in Filters do
        if filter.Function(slot, slotIndex, inventory) then
            return true
        end
    end
    
    return false
end

return Filter