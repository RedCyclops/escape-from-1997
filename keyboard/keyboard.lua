--require("love.keyboard")

function love.keypressed(key)
    print(key)
    if key == 'escape' then
        love.event.quit()
    end
end
