require("display/screen_logo_studio")
require("display/screen_intro")
require("display/screen_intro2")
require("display/screen_main_select")
require("display/screen_options")
require("display/screen_game")

require("keyboard/key_logo_studio")
require("keyboard/key_intro")
require("keyboard/key_intro2")
require("keyboard/key_main_select")
require("keyboard/key_options")
require("keyboard/key_game")

require("gamepad/pad_logo_studio")
require("gamepad/pad_intro")
require("gamepad/pad_intro2")
require("gamepad/pad_main_select")
require("gamepad/pad_options")
require("gamepad/pad_game")

require("game/update_logo_studio")
require("game/update_intro")
require("game/update_intro2")
require("game/update_main_select")
require("game/update_options")
require("game/update_game")

require("game/3d_game")
require("game/crashed")
require("game/success")

sfx_blip_menu = love.audio.newSource("music/select_menu.ogg", "static")

Game = {
    state = "logo_studio",
    type = "campaign",
    sub_state = nil,
    sequence = {
        logo_studio = {
            next = "intro",
            draw = draw_screen_logo_studio,
            key = key_logo_studio,
            update = update_logo_studio,
            pad = pad_logo_studio
        },
        intro = {
            next = "plane_game" ,
            draw = draw_screen_intro,
            key = key_intro,
            update = update_intro,
            pad = pad_intro
        },
        intro2 = {
            next = "main_select",
            draw = draw_screen_intro2,
            key=key_intro2,
            update = update_intro2,
            pad = pad_intro2
        },
        main_select = {
            next = "logo_studio",
            draw = draw_screen_main_select,
            key=key_main_select,
            update = update_main_select,
            pad = pad_main_select
        },
        options = {
            next = nil,
            draw = draw_screen_options,
            key=key_options,
            update = update_options,
            pad = pad_options
        },
        game = {
            next = nil,
            draw = draw_screen_game,
            key=key_game,
            update = update_game,
            pad = pad_game
        },
        plane_game = {
            next = "intro",
            draw = draw_plane_game,
            key = key_plane_game,
            update = update_plane_game,
            pad = pad_plane_game,
            init = init_plane_game,
            initiated = false
        },
        crashed = {
            next = "logo_studio",
            draw = draw_plane_crashed,
            key = key_plane_crashed,
            update = update_plane_crashed,
            pad = pad_plane_crashed,
            init = init_plane_crashed,
            initiated = false
        },
        plane_success = {
            next = "logo_studio",
            draw = draw_plane_success,
            key = key_plane_success,
            update = update_plane_success,
            pad = pad_plane_success,
            init = init_plane_success,
            initiated = false
        }

    },
    common_keys = function(key)

        if key=='escape' then
            MAudio.sfxs.blip_menu:setVolume(MAudio.sfx_volume)
            MAudio.sfxs.blip_menu:play()
            love.event.quit()
        end
    end,
    common_pad = function(joystick, button)
        if button=='a' and Game.sequence[Game.state].next then
            Game.state = Game.sequence[Game.state].next
            print('----')
            print(Game.state)
        end
    end,
    common_update = function(self, dt)
        --dprint(self) -- self works

    end
}

function love.draw()
    Game.sequence[Game.state].draw()
end
function love.keypressed(key)
    Game.common_keys(key)
    Game.sequence[Game.state].key(key)
end
function love.gamepadreleased(joystick, button)
    if Game.state == 'plane_game' then
        Game.sequence[Game.state].pad(joystick, button)
    end
end

function love.gamepadpressed(joystick, button)
    if button ~= 'b' then

        Game.common_pad(joystick,button)
        dprint(button)
        Game.sequence[Game.state].pad(joystick, button)
        MAudio.sfxs.blip_menu:setVolume(MAudio.sfx_volume)
        MAudio.sfxs.blip_menu:play()
    end
    if Game.state == 'plane_game' then
        Game.sequence[Game.state].pad(joystick, button)
    end

end


function love.update( dt)
    Game.common_update(Game, dt)
    Game.sequence[Game.state].update(Game, dt)
end
