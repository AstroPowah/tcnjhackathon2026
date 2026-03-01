local chat = require 'chat'
_G.love = require 'love'
_G.wb = require 'tools.wordbank'
_G.AI = require 'malachi'
_G.typeOfText = require 'tools.typeOfTexts'
_G.responses = require 'tools.responses'
_G.player = require 'player'

function love.load()
    chat:load()
end

function love.update(dt)
    if player.state == "idle" then
        if love.keyboard.isDown("s") then
            player.y = player.y + 5
        elseif love.keyboard.isDown("w") then
            player.y = player.y - 5
        end
        if love.keyboard.isDown("a") then
            player.x = player.x - 5
        elseif love.keyboard.isDown("d") then
            player.x = player.x + 5
        end
    end
    chat:update(dt)
    AI:update(dt)
end

function love.textinput(t)
    chat:textinput(t)
end

function love.draw()
    chat:draw()
    AI:draw()
    love.graphics.circle("fill", player.x, player.y, 20)
end

function love.keypressed(k)
    chat:keypressed(k)
end



