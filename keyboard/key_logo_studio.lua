---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by filipe.
--- DateTime: 05/03/2021 17:59
---
function key_logo_studio(key)

    if key=='space' and Game.sequence[Game.state].next then
        Game.state = Game.sequence[Game.state].next
        print('----')
        print(Game.state)
        MAudio.sfxs.blip_menu:setVolume(MAudio.sfx_volume)
        MAudio.sfxs.blip_menu:play()
    end

end
