local plr = require 'player'
local utf8 = require 'utf8'
local eval = require 'evaluate'

local chat = {}

function chat:load()
    text = ""
    font = love.graphics.newFont(20)
end

function chat:update(dt)
    
end

function chat:draw()
    
end

function chat:textinput(t)
    if plr.state ~= "typing" then
        text = text
    elseif plr.state == "typing" then
        text = text .. t 
    end
end

function chat:keypressed(k)
    if k == "/" and plr.state == "idle" then
        plr.state = "typing"
    elseif k == "/" and plr.state == "typing" then
        plr.state = ""
    end
    if k == "escape" and plr.state == "typing" then
        plr.state = "idle"
    end
    if k == "return" and plr.state == "typing" then
        love.graphics.print(text, 100, 100, 400, 50)
        finalText = text
        text = ""
        plr.state = "sentMessage"
        return finalText
    end
    if k == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(text, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            text = string.sub(text, 1, byteoffset - 1)
        end
    end
end

return chat