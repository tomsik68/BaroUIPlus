local Filter = require("ItemInitialView.Filter")
local Renderer = require("ItemInitialView.Renderer")

-- Renders the first letter of the item name in the specified slot unless the feature is disabled
local ItemInitialView = function(spriteBatch, slot, slotIndex, inventory)
    if Filter.IsSkipped(slot, slotIndex, inventory) then return end

    Renderer.DrawOnSlot(spriteBatch, slot, inventory.GetItemAt(slotIndex).Name:sub(1,1))
end

-- This hook is compatible with the following game version: https://github.com/FakeFishGames/Barotrauma/blob/22227f13e5cd0c704ebb0f362752d4200f4b5c0f/Barotrauma/BarotraumaClient/ClientSource/Items/Inventory.cs#L1683
local InstallHook_22227f1 = function()
    Hook.Patch("JasekMod.DrawSingleSlot", "Barotrauma.Inventory", "DrawSlot", {
        "Microsoft.Xna.Framework.Graphics.SpriteBatch",
        "Barotrauma.Inventory",
        "Barotrauma.VisualSlot",
        "Barotrauma.Item",
        "System.Int32",
        "System.Boolean",
        "Barotrauma.InvSlotType",
    }, function(_this_is_a_static_method_dont_use_instance, parameters)
        ItemInitialView(parameters["spriteBatch"], parameters["slot"], parameters["slotIndex"], parameters["inventory"])
    end, Hook.HookMethodType.After)
end

local RenderHook = {}
RenderHook.Install = function()
    InstallHook_22227f1()
end

return RenderHook