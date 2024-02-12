dprint("loading 3d lib - g3d")
g3d = require("3dlibs/g3d")
dprint("3d lib - g3d Loaded")
plane = {
    coords = { x = 0, y = 0, z = 0 },
    rot = { 0, -1, 0 },
    acc = { x = 0, y = 0, z = 10 },
    acc_rot = { x = 0, y = 0, z = 10 },
    angle = 0,
    speed = 1,
    dirx = 0,
    diry = 0,
    dirspeed = 200


}
kspeed = 1
kmoveX, kmoveY = 0, 0
moveX, moveY = 0, 0
alt = 0
cameraMoved = false
speed = 1
--function love.load()
screen_alpha_img = love.graphics.newImage("assets/screen_alpha.png")
objective_coords = {
    { 5.7044, -6.236, 5.3502, -5.6851, 5.7438, -5.4489, 6.0783, -6.013, 1.8955 },
    { 5.4093, -2.2941, 5.2125, -1.9334, 5.6388, -1.7169, 5.8225, -2.0908, 2.0529 },
    { 0.92956, -4.1634, 0.73936, -3.855, 1.1001, -3.5862, 1.2903, -3.9273, 2.0529 },
    { 0.6213, -3.6715, 0.46389, -3.396, 0.85742, -3.1861, 0.9424, -3.4878, 1.98733 },
    { 0.61558, 0.99243, 5.9433, 1.5276, 6.628, 1.8188, 6.8563, 1.2915, 1.8771 },
    { -2.8292, 4.7806, -3.0558, 5.2812, -2.253, 5.6307, -2.0358, 5.1301, 1.9338 },
    { -5.7854, 1.8024, -6.1474, 1.8575, -6.1238, 2.0149, -5.7696, 1.9441, 1.9999 },
    { -6.2655, 2.4714, -6.6433, 2.5186, -6.5882, 2.9043, -6.2025, 2.8334, 2.118 },
    { -7.4294, -1.3092, -7.9978, -1.2108, -7.9267, -0.82824, -7.3474, -0.92663, 2.0633 },
    { -8.1891, -1.189, -8.5061, -1.1343, -8.4624, -0.75172, -8.1344, -0.80091, 1.8174 },
    { -11.25, -0.12863, -11.709, -0.052113, -11.605, 0.56551, -11.157, 0.50539, 1.9868 },
    { -15.772, 2.3102, -16.434, 2.4235, -16.339, 3.1791, -15.678, 3.0563, 2.0529 },
    { -16.068, 6.3328, -16.88, 6.4556, -16.758, 7.1734, -15.974, 7.0411, 2.1096 },
    { -19.421, 2.8571, -19.752, 2.9138, -19.638, 3.641, -19.308, 3.6033, 1.8829 },
    { -20.469, -0.70354, -20.828, -0.64687, -30.734, -0.061295, -20.384, -0.10852, 2.1285 },
    { -26.26, 5.3447, -26.52, 5.3843, -26.483, 5.603, -26.232, 5.5688, 2.1337 }
}
--end
function init_plane_game(self)

    dprint("init 3d game")
    self.sequence[self.state].initiated = true
    --dprint(self)
    --earth = g3d.newModel("assets/sphere.obj", "assets/earth.png", {0,0,4})
    --moon = g3d.newModel("assets/sphere.obj", "assets/moon.png", {objective_coords[1][1],objective_coords[1][9]+1.2,objective_coords[1][2]}, nil, {0.1,0.1,0.1})
    city = g3d.newModel("assets/city01.obj", "assets/3d_scan_green.png", { 0, 0, 0 }, nil, { 1, 1, 1 })
    --objectives = g3d.newModel("assets/city01_objectives.obj", "assets/3d_scan_blue.png", { 0, 5, 0 }, nil, { 1, 1, 1 })
    mesh_targets = {}
    for i=1, 16 do
        a = tostring(i)
        if i < 10 then
            a = "0"..tostring(i)
        end
        print(a)
        mesh_targets[i] = g3d.newModel(
                "assets/target"..a..".obj", "assets/3d_scan_blue.png", { 0, 0, 0 }, nil, { 1, 1, 1 }
        )
        mesh_targets[i]:generateAABB()
    end
    mesh_cols = {}
    for i=1, 16 do
        a = tostring(i)
        if i < 10 then
            a = "0"..tostring(i)
        end
        print(a)
        mesh_cols[i] = g3d.newModel(
                "assets/target"..a..".obj", "assets/transparent.png", { 0, -.04, 0 }, nil, { 1, 1, 1 } --"assets/transparent.png"
        )
        mesh_cols[i]:generateAABB()
    end
    mesh_towers = {}
    for i=1, 16 do
        a = tostring(i)
        if i < 10 then
            a = "0"..tostring(i)
        end
        print(a)
        mesh_towers[i] = g3d.newModel(
                "assets/tower"..a..".obj", "assets/3d_scan_green.png", { 0, 0, 0 }, nil, { 1, 1, 1 }
        )
        mesh_towers[i]:generateAABB()
    end

    --background = g3d.newModel("assets/sphere.obj", "assets/starfield.png", {0,0,0}, nil, {500,500,50})

    ptrack = g3d.newModel({ {} }, "assets/3d_scan_green.png", { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 })
    timer = 0
    g3d.camera.position = {0,-5,0}
    g3d.camera.up = { 0, -1, 0 }
    MAudio.sfxs.wind:setVolume(MAudio.sfx_volume)
    MAudio.sfxs.wind:play()

end

function draw_plane_game(self)

    --objectives:draw()
    city:draw()
    for i=1, 16 do
        mesh_targets[i]:draw()
    end
    for i=1, 16 do
        mesh_towers[i]:draw()
    end
    for i=1, 16 do
        mesh_cols[i]:draw()
    end

    --moon:draw()
    scale = love.graphics.getWidth() / screen_alpha_img:getWidth()
    love.graphics.draw(screen_alpha_img, 0, 0, 0, scale)
    --love.graphics.print("PLANE GAME")
    --[[love.graphics.print(g3d.camera.position[1],0,0)
    love.graphics.print(g3d.camera.position[2],0,20)
    love.graphics.print(g3d.camera.position[3],0,40)
    love.graphics.print("u "..moveX,0,60)
    love.graphics.print("v "..moveY,0,80)]]
    --love.graphics.print(g3d.camera.getDirectionPitch()[1],0,90)
    --love.graphics.print(g3d.camera.getDirectionPitch()[2],0,100)
    --love.graphics.print(rotated[1][1].." "..rotated[1][2].." "..rotated[1][3].." "..rotated[1][4],0,90)
    --love.graphics.print(rotated[2][1].." "..rotated[2][2].." "..rotated[2][3].." "..rotated[2][4],0,100)
    --love.graphics.print(rotated[3][1].." "..rotated[3][2].." "..rotated[3][3].." "..rotated[3][4],0,110)
    --love.graphics.print(rotated[4][1].." "..rotated[4][2].." "..rotated[4][3].." "..rotated[4][4],0,120)
    aa = 100
    love.graphics.draw(
            logo_joystick,
            (love.graphics.getWidth() - logo_joystick:getWidth()*.1)/2,
            (aa + (love.graphics.getHeight() - logo_studio_image:getHeight())/2) + logo_studio_image:getHeight() + .1 * logo_joystick:getHeight()/2,
            0,
            .1,
            .1

    )
    love.graphics.setFont(systemFont)
    love.graphics.print('Use left Axis & B button for brake',
            (love.graphics.getWidth() - logo_joystick:getWidth()*.1)/2 - 70,
            (aa + 10 +(love.graphics.getHeight() - logo_studio_image:getHeight())/2) + logo_studio_image:getHeight() + .1 * logo_joystick:getHeight()/2 + logo_joystick:getHeight() * .1
    )
    love.graphics.print('or key Arrows and B key for brake',
            (love.graphics.getWidth() - logo_joystick:getWidth()*.1)/2 - 70,
            (aa + 20+ (love.graphics.getHeight() - logo_studio_image:getHeight())/2) + logo_studio_image:getHeight() + .1 * logo_joystick:getHeight()/2 + logo_joystick:getHeight() * .1
    )


end

function key_plane_game(key)
    if key == "b" then
        slowing = true
    end

end
function love.keyreleased(key)
    if key == "b" then
        slowing = false
    end
end
slowing = false
function pad_plane_game(joystick,button)
    if joystick:isGamepadDown('b') then
        slowing = true
    else
        slowing = false
    end


end

function update_plane_game(self, dt)
    -- check if initiated , if not do init
    if self ~= nil then
        if self.sequence[self.state].init ~= nil and self.sequence[self.state].initiated == false then
            init_plane_game(self)
        end
    end
    timer = timer + dt

    if slowing then
        print(plane.speed)
        plane.speed = plane.speed - .2 * dt
        if plane.speed < 0 then
            plane.speed = 0
        end
        MAudio.sfxs.deploy_stop:setVolume(MAudio.sfx_volume)
        MAudio.sfxs.deploy_stop:play()
    else
        plane.speed = plane.speed + .2 * dt
        if plane.speed > 1 then
            plane.speed = 1
        end
    end

    g3d.camera.firstPersonPadMovement(dt)

    if love.keyboard.isDown("escape") then
        love.event.push("quit")
    end
end

function g3d.camera.firstPersonPadMovement(dt)

    joystick = love.joystick.getJoysticks()[1]
    if love.keyboard.isDown("left") == true then
        kmoveX = kmoveX - kspeed * dt
    end
    if love.keyboard.isDown("right") == true then
        kmoveX = kmoveX + kspeed * dt

    end
    if love.keyboard.isDown("up") == true then
        kmoveY = kmoveY - kspeed * dt

    end
    if love.keyboard.isDown("down") == true then
        kmoveY = kmoveY + kspeed * dt

    end

    if kmoveX > 1 then
        kmoveX = 1
    end
    if kmoveY > 1 then
        kmoveY = 1
    end
    if kmoveX < -1 then
        kmoveX = -1
    end
    if kmoveY < -1 then
        kmoveY = -1
    end
    if not love.keyboard.isDown("left") and not love.keyboard.isDown("right") and not love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
        kmoveX, kmoveY = 0, 0
    end
    if joystick ~= nil and joystick ~= false then
        moveX = joystick:getGamepadAxis("leftx") + kmoveX
        moveY = -joystick:getGamepadAxis("lefty") - kmoveY
        alt = -joystick:getGamepadAxis("righty")

    else
        moveX = kmoveX
        moveY = - kmoveY
        alt = 0 ---joystick:getGamepadAxis("righty")
    end


    g3d.camera.up = { 0, -1, 0 }
    g3d.camera.firstPersonLook(moveX * plane.dirspeed * dt, moveY * plane.dirspeed * dt)
    g3d.camera.position[2] = g3d.camera.position[2] - g3d.camera.getDirectionPitch()[2] * plane.speed * dt / 4
    if joysctick ~= nil then
        print(joystick:isGamepadDown('b'))


    end

    if plane.speed < .5 then
        g3d.camera.position[2] = g3d.camera.position[2] + .2 * dt
    end

    plane.angle = math.atan2(-1, 0)
    g3d.camera.position[1] = g3d.camera.position[1] + math.cos(fpsController.direction + plane.angle) * plane.speed * dt / 2
    g3d.camera.position[3] = g3d.camera.position[3] + math.sin(fpsController.direction + plane.angle + math.pi) * plane.speed * dt / 2
    g3d.camera.lookInDirection()
    inboundscity = city:isPointInsideAABB(g3d.camera.position[1], g3d.camera.position[2], g3d.camera.position[3])
    if inboundscity then
        Game.sequence[Game.state].initiated = false
        Game.state = 'crashed'
        MAudio.sfxs.crash:setVolume(MAudio.sfx_volume)
        MAudio.sfxs.crash:play()
    end
    for i=1,16 do
        inboundst = mesh_targets[i]:isPointInsideAABB(g3d.camera.position[1], g3d.camera.position[2], g3d.camera.position[3])
        if inboundst then
            print('collide with target '..i)


            break
        end
    end
    for i=1,16 do
        inboundsc = mesh_cols[i]:isPointInsideAABB(g3d.camera.position[1], g3d.camera.position[2], g3d.camera.position[3])
        if inboundsc then
            print('collide with cols '..i)
            g3d.camera.position[2] = g3d.camera.position[2] - 3 * dt
            MAudio.sfxs.landing:setVolume(MAudio.sfx_volume)
            MAudio.sfxs.landing:play()
            if slowing then
                MAudio.sfxs.drift:setVolume(MAudio.sfx_volume)
                MAudio.sfxs.drift:play()
            end
            if g3d.camera.getDirectionPitch()[2] < -0.6 then
                Game.sequence[Game.state].initiated = false
                Game.state = 'crashed'
                MAudio.sfxs.crash:setVolume(MAudio.sfx_volume)
                MAudio.sfxs.crash:play()
            end
            if plane.speed == 0 then
                Game.sequence[Game.state].initiated = false
                Game.state = 'plane_success'
                MAudio.sfxs.landing:setVolume(MAudio.sfx_volume)
                MAudio.sfxs.landing:play()
            end

            break
        end
    end
    for i=1,16 do
        inbounds = mesh_towers[i]:isPointInsideAABB(g3d.camera.position[1], g3d.camera.position[2], g3d.camera.position[3])
        if inbounds then
            print('collide with tower '..i)
            Game.sequence[Game.state].initiated = false
            Game.state = 'crashed'
            MAudio.sfxs.crash:setVolume(MAudio.sfx_volume)
            MAudio.sfxs.crash:play()
            break
        end
    end


end

function isPlayerinBounds(point, polygon)
    local oddNodes = false
    local j = #polygon
    for i = 1, #polygon do
        if (polygon[i][2] < point[2] and polygon[j][2] >= point[2] or polygon[j][2] < point[2] and polygon[i][2] >= point[2]) then
            if (polygon[i][1] + (point[2] - polygon[i][2]) / (polygon[j][2] - polygon[i][2]) * (polygon[j][1] - polygon[i][1]) < point[1]) then
                oddNodes = not oddNodes;
            end
        end
        j = i;
    end
    return oddNodes
end



