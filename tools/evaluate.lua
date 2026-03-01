-- local wb = require 'tools.wordbank'
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

local function getTypeOfText(LastText)
    local textType = {['neutral'] = .5,['greeting'] = 0, ['question'] = 0, ['statement'] = 0}
    for type, words in pairs(typeOfTexts) do
        for i, word in ipairs(words) do
            for _, splitWord in pairs(LastText) do
                -- print(word)
                if splitWord:lower() == word:lower() then
                    print("Found " .. word .. " in " .. splitWord, type)
                    textType[type] = textType[type] + 1
                end
            end
        end
    end
    local max = 0
    local maxKey = "neutral"
    for key, value in pairs(textType) do

        if value > max then
            max = value
            maxKey = key
        end
        print(key, value, maxKey, max)
    end
    return maxKey
end

local evaluated = {}

function evaluated:evalEmotion(str)
    local split = {}
    for word in string.gmatch((str), "%a+") do
        table.insert(split, word)
    end
    return split
end

function evaluated:evalEmot(strSplit)
    for type, words in pairs(wb) do
        for word, value in pairs(words) do
            for i, splitWord in pairs(strSplit) do
                if splitWord:lower() == word:lower() then
                    print("Found " .. word .. " in " .. splitWord)
                    AI.moodAmount[type] = AI.moodAmount[type] + (value or 0)
                end
            end
        end
    end
    AI.moodAmount.Happy = AI.moodAmount.Happy *.15       
    AI.moodAmount.Angry = AI.moodAmount.Angry *.55
    AI.moodAmount.Neutral = AI.moodAmount.Neutral * .1    
    AI.moodAmount.Sad = AI.moodAmount.Sad * .2
    local maxI = "Neutral"
    for key,value in pairs(AI.moodAmount) do
        print(key, value)
    end
    for key,value in pairs(AI.moodAmount) do
        if value > AI.moodAmount[maxI] then
            maxI = key
        end
    end
    return maxI
end

function evaluated:evalTypeOfText(str)
    print(str)
    return getTypeOfText(str)
end

function evaluated:getResponse(type, mood)
    print("Getting response for type:", type, "and mood:", mood)
    local response = responses[type][mood]
    return response[math.random(1, #response)]
    
end

return evaluated