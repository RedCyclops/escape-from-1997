function draw_plane_crashed()
    love.graphics.setFont(font_title)
    love.graphics.print("You crashed!",300, 300)
    love.graphics.setFont(systemFont)
end
function  key_plane_crashed(key)
    if key=='space' and Game.sequence[Game.state].next then
        Game.state = Game.sequence[Game.state].next
        print('----')
        print(Game.state)
        MAudio.sfxs.blip_menu:setVolume(MAudio.sfx_volume)
        MAudio.sfxs.blip_menu:play()
    end
end
function  update_plane_crashed()  end
function  pad_plane_crashed()  end
function  init_plane_crashed()  end
