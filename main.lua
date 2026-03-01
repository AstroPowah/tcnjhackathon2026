_G.love = require 'love'
local chat = require 'chat'
_G.love = require 'love'
_G.wb = require 'tools.wordbank'
_G.AI = require 'malachi'

function love.load()
    --chat:load()
    map = sti("assets/tiled/mainRoom.lua", { "bump" })
    map:bump_init(map)
    map:resize(20, 20)
end

function love.update(dt)
    chat:update(dt)
end

function love.textinput(t)
    --chat:textinput(t)
end

function love.draw()
    chat:draw()
end

function love.keypressed(k)
    --chat:keypressed(k)
end



