_G.love = require 'love'
local chat = require 'chat'
local sti = require 'libs/STI/sti'
local bump = require 'libs/bump/bump'
local camera = require 'libs/camera'
local player = require'player'

function love.load()
    --chat:load()
    map = sti("assets/tiled/mainRoom.lua", { "bump" })
    map:bump_init(map)
    map:resize(20, 20)
end

function love.update(dt)
    --chat:update(dt)
    player:update()
    map:update(dt)
end

function love.textinput(t)
    --chat:textinput(t)
end

function love.draw()
    --chat:draw()
    map:drawLayer(map.layers["background"])
    map:drawLayer(map.layers["foreground"])
    map:drawLayer(map.layers["objects"])
    player:draw()
    --map:bump_draw(map, 0, 0, 0, 0)
end

function love.keypressed(k)
    --chat:keypressed(k)
end



