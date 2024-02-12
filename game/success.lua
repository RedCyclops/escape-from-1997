function draw_plane_success()
    love.graphics.setFont(font_title)
    love.graphics.print("Well Done!",300, 300)
    love.graphics.setFont(systemFont)
end
function  key_plane_success(key)
    if key=='space' and Game.sequence[Game.state].next then
        Game.state = Game.sequence[Game.state].next
        print('----')
        print(Game.state)
        MAudio.sfxs.blip_menu:setVolume(MAudio.sfx_volume)
        MAudio.sfxs.blip_menu:play()
    end
end
function  update_plane_success()  end
function  pad_plane_success()  end
function  init_plane_success()  end
