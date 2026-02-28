local wb = require 'wordbank'
local plr = require 'player'

--[[
This sentence will be read by the AI(aka system by jhoxiry)
It will look through its database of words(in a txt file)
Different sets of words will be assigned a value such as 0.5 or -0.5 that add up throughout the sentence to give a final value
The final value of 1 or more=mood happy and value of -1 or less=angry
After calculating if it is happy or angry it will then calculate the level of that mood
The value of -1 to -1.5 is lvl1, -1.5 to -2 is lvl2, and -2 to -10 is lvl3, with the same thing being vice versa
(Any word that isn’t included in the txt file list is neutral meaning a value of 0)
]]

local evaluated = {}

function evaluated:evalEmotion(str)
    local len = string.len(str)
    if len > 0 then
        local split = {}
        for word in string.gmatch(str, "%a+") do
            split[word] = word
        end

        for i,v in ipairs(split) do print(v) end
    elseif len < 0 or len == nil then
        print("Error: You didnt enter a string, or the string is empty")
    end
end

return evaluated