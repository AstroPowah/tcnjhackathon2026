-- local wb = require 'wordbank'
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
    local split = {}
    for word in string.gmatch((str), "%a+") do
        table.insert(split, word)
    end
    return split
end

function evaluated:evalEmot(strSplit)
    local textType = {
        Happy = 0,
        Angry = 0,
        Neutral = 0,
        Sad = 0,
    }
    for type, words in pairs(wb) do
        for word, value in pairs(words) do
            for i, splitWord in pairs(strSplit) do
                if splitWord:lower() == word:lower() then
                    print("Found " .. word .. " in " .. splitWord)
                    textType[type] = textType[type] + (value or 0)
                end
            end
        end
    end
    textType.Happy = textType.Happy *.15       
    textType.Angry = textType.Angry *.55
    textType.Neutral = textType.Neutral * .1    
    textType.Sad = textType.Sad * .2
    local maxI = "Neutral"
    for key,value in pairs(textType) do
        print(key, value)
    end
    for key,value in pairs(textType) do
        if value > textType[maxI] then
            maxI = key
        end
    end
    return maxI
end

return evaluated