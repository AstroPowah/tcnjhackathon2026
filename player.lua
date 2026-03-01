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
end

function player:draw()
end

return player