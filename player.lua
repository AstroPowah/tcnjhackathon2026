local bump = require 'libs/bump/bump'

local player = {
    x = 10,
    y = 10,
    state = "idle",
    lastSentence = ""
}

function player:load()
end

function player.update(dt)
    if love.keyboard.isDown("s") then
        player.y = player.y + 5
    elseif love.keyboard.isDown("w") then
        player.y = player.y - 5
    end
    if love.keyboard.isDown("d") then
        player.x = player.x + 5
    elseif love.keyboard.isDown("a") then
        player.x = player.x - 5
    end
end

function player:draw()
    love.graphics.circle("fill",player.x,player.y,20)
end

return player