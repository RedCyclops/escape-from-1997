---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by filipe.
--- DateTime: 05/03/2021 17:35
---
---
function update_main_select(self, dt)
    bg_select_mode.px = bg_select_mode.px - dt * 200
    if bg_select_mode.px < -love.graphics.getWidth() then
        bg_select_mode.px = 0
    end
    bg_select_mode.py = bg_select_mode.py + dt * 200
    if bg_select_mode.py > love.graphics.getHeight() then
        bg_select_mode.py = 0
    end

end
