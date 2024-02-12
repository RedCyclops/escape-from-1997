---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by filipe.
--- DateTime: 05/03/2021 17:35
---
---
background_select_mode = love.graphics.newImage("assets/decors/grass01.png")
background_select_mode:setWrap("repeat", "repeat")

bg_quad = love.graphics.newQuad(0, 0, love.graphics.getWidth(), love.graphics.getHeight(), background_select_mode:getWidth(), background_select_mode:getHeight())

bg_select_mode = {
    px=0,
    py=0
}
GameMode = {
    select = 1,
    menu = {
        image = love.graphics.newImage("assets/ui/big/en/ui_modeselect.png"),
        {name = 'Versus',image=love.graphics.newImage("assets/ui/big/"..lang.."/ui_versus.png")},
        {name = 'Campaign',image=love.graphics.newImage("assets/ui/big/"..lang.."/ui_campaign.png")},
        {name = 'Options',image=love.graphics.newImage("assets/ui/big/"..lang.."/ui_options.png")}
    }
}


function draw_screen_main_select()
    -- draw background
    love.graphics.draw(background_select_mode, bg_quad, bg_select_mode.px, bg_select_mode.py)
    love.graphics.draw(background_select_mode, bg_quad, bg_select_mode.px + love.graphics.getWidth(), bg_select_mode.py)
    love.graphics.draw(background_select_mode, bg_quad, bg_select_mode.px, bg_select_mode.py - love.graphics.getHeight())
    love.graphics.draw(background_select_mode, bg_quad, bg_select_mode.px+ love.graphics.getWidth(), bg_select_mode.py - love.graphics.getHeight())
    love.graphics.print("\nselect game mode screen - press space ... ",0,0)

    -- draw menu name
    --love.graphics.draw(GameMode.menu.image,0,0)
    love.graphics.print(lg[lang]["Mode Select"])
    -- draw menu
    for aa=1, #GameMode.menu do
        if GameMode.select == aa then
            love.graphics.setColor(1,1,1,1)
        else
            love.graphics.setColor(1,1,1,.5)
        end
        --love.graphics.draw(
        --        GameMode.menu[aa].image,
        --        (love.graphics.getWidth()/2) - (GameMode.menu[aa].image:getWidth()/2),
        --        (love.graphics.getHeight()/2) - (GameMode.menu[aa].image:getHeight()/2) + aa*40
        --)
        love.graphics.print("\n"..lg[lang][GameMode.menu[aa].name],love.graphics.getWidth()/2,aa*40+love.graphics.getHeight()/2)
    end
    love.graphics.setColor(1,1,1,1)
end
