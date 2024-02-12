--screen = {
--    ratio = 1,
--    width = 500,
--    height = 250
--}
--scale = {
--    x = 1,
--    y = 1
--}
--love.window.setMode(screen.width,screen.height,{fullscreen=false, fullscreentype="desktop",centered=true, resizable=false, borderless=true, vsync=false})


--modes = love.window.getFullscreenModes( 1 )
--table.sort(modes, function(a, b) return a.width*a.height < b.width*b.height end)
--modes.selected = 1
--modes.max_shown = 4



function file_exists(path_to_file)
    local f = io.open(path_to_file, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

if file_exists("./game.conf") == false then
    -- file does not exists recreating default
    data_to_write = [[
[display]
[display]
id=0
width=1024
height=720

[language]
lang=fr

[music]
volume=.2

[sfx]
volume=.5

[debug]
active=true
]]
    file = io.open("./game.conf", "w+")
    io.output(file)
    io.write(data_to_write)
    io.close(file)
end

-- read config file and set cong global variable
local file = assert(io.open("./game.conf", "r"))
conf = {}
local Ilength = 0
local lastkey
local newkey
local value
local line
for line in file:lines() do
    Ilength = Ilength + 1
    if line ~= '' then
        if string.match(line, "[%[]") == "[" and string.match(line, "[%]]") == "]" then
            lastkey = string.gsub(string.gsub(line, "%[", ""), "%]", "")
            conf[lastkey] = {}
        else
            newkey = string.match(line, "(%w+)")
            value = string.gsub(line, newkey .. "=", "")
            conf[lastkey][newkey] = value
        end
    end

end
io.close(file)
print('conf setted to: --> ' .. json.encode(conf))


