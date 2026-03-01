local plr = require 'player'
local utf8 = require 'utf8'
local eval = require 'evaluate'
local wordbank = require 'wordbank'

local chat = {}

function chat:load()
    text = ""
    font = love.graphics.newFont(20)
end

function chat:update(dt)
    if plr.state == "sentMessage" then
        local splitMessage = {}
        local moodAmount 
        print("Sent once")
        plr.lastSentence = finalText
        if string.len(plr.lastSentence) > 0 then
            print(plr.lastSentence)
            splitMessage = eval:evalEmotion(plr.lastSentence)
            eval:compare(splitMessage)
        end
        for index, value in ipairs(splitMessage) do
            print(index, value)
        end
        print("The mood is", moodAmount)
        plr.state = "idle"
    end

    
end

function chat:draw()
    love.graphics.setFont(font)
    love.graphics.print("T to type:", 50, 50)
    love.graphics.rectangle("line", 50, 100, 400, 50)
    
    if plr.state == "typing" then
        love.keyboard.setKeyRepeat(true)
        love.graphics.print(text, 60, 110)
        local substring = string.sub(text, 1, 1)
        if substring == "/" then
            text = ""
        end
    end
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