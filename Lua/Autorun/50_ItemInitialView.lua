-- The item initial view feature shows the first letter of the item name in the inventory
BaroUIPlusGlobal.Config.ItemInitialView = {
    -- Set to false to completely disable the feature
    -- Default: true
    Enabled = true,

    -- Set to false to show the initial letter of the item name even if the inventory is not sorted alphabetically
    -- Default: true
    OnlyOnSorted = true,

    -- Size limit for small inventories. If the inventory is smaller than this value, the feature is disabled in that inventory
    -- Default: 5
    SmallInventorySizeLimit = 5,

    -- Set to true to enable the feature on player equipment
    -- Default: false
    EnableOnPlayerEquipment = false,
}

if SERVER then return end -- we don't want server to run GUI code on the server

local Main = require("ItemInitialView.Main")
Main()