--require("love.keyboard")

local lastbutton = "none"

function love.gamepadpressed(joystick, button)
    lastbutton = button
end

function love.draw()
    love.graphics.print("Le dernier bouton de manette de jeu pressé est : "..lastbutton, 10, 10)
end
