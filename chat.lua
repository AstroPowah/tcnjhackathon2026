local plr = require 'player'
local utf8 = require 'utf8'
local eval = require 'tools.evaluate'
local wordbank = require 'wordbank'

local chat = {}

local font
local text 
function chat:load()
    text = ""
    font = love.graphics.newFont(20)
end


function chat:update(dt)
    if plr.state == "sentMessage" then
        local splitMessage = {}
        local mood, moodAmount
        -- print("Sent once")
        plr.lastSentence = finalText
        if string.len(plr.lastSentence) > 0 then
            -- print(plr.lastSentence)
            splitMessage = eval:evalEmotion(plr.lastSentence)
            -- eval:compare(splitMessage)
            mood = eval:evalEmot(splitMessage)
        end
        for index, value in ipairs(splitMessage) do
            print(index, value)
        end
        local typeOfText = eval:evalTypeOfText(splitMessage)
        local response = eval:getResponse(typeOfText, mood)
        print("The response is:", response)
        AI.text = response
        print("The mood is", mood)
        AI.mood = mood
        plr.state = "idle"
    end
end
function chat:draw()
    -- love.graphics.setFont(font)  
    love.graphics.print("/ to type:", 50, 50)
    love.graphics.rectangle("line", 50, 100, 400, 50)
    -- love.graphics.print(AI.text, 225, 150)
    
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
    -- print(text, t)
    if plr.state ~= "typing" then
        text = text
    elseif plr.state == "typing" then
        text = text .. t 
    end
end

function chat:keypressed(k)
    -- print("Key pressed:", k, "Current state:", plr.state)
    if k == "/" and plr.state == "idle" then
        print(plr.state)
        plr.state = "typing"
        print(plr.state)
    -- elseif k == "/" and plr.state == "typing" then
    --     plr.state = ""
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