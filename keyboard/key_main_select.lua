---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by filipe.
--- DateTime: 05/03/2021 17:59
---

function key_main_select(key)
    if key == "up" and GameMode.select > 1 then
        sfx_blip_menu:play()
        GameMode.select = GameMode.select -1
    end
    if key == "down" and GameMode.select < #GameMode.menu then--table.maxn(modes)  then
        sfx_blip_menu:play()
        GameMode.select = GameMode.select + 1
    end
    if key == "return" then
        sfx_blip_menu:play()
        --music_intro:stop()
        --music_map:setVolume(music_general_volume)
        --music_map:play()
        if GameMode.menu[GameMode.select].name == "Versus" then
            Game.type = "versus"
            Game.state = "game"
        end
        if GameMode.menu[GameMode.select].name == "Campaign" then
            Game.type = "campaign"
            Game.state = "game"
        end
        if GameMode.menu[GameMode.select].name == "Options" then
            Game.state = "options"
        end
        --if GameMode.select == 2 then
        --    Moan.new("Title", {"Hello World!"})
        --end

    end


end
