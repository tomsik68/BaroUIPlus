local Renderer = {}

-- Draws the specified text on the specified slot
Renderer.DrawOnSlot = function(spriteBatch, slot, text)
    local point = Vector2(slot.Rect.Left, slot.Rect.Top) + slot.DrawOffset
    GUI.DrawString(spriteBatch, point, text, Color.White, Color.Black, 0, GUI.Style.Font)
end

return Renderer