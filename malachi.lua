local malachi = {
    x = 60,
    y = 60,
    state = "",
    Neurons = {
        Happy = neuron(),
        Angry = neuron()
    },
    moodAmount = {
        Happy = 0,
        Angry = 0,
        Neutral = 0,
        Sad = 0,
    },
    calculateOutput = function(self,moodAmount)
        moodAmount.Happy = moodAmount.Happy *.5
        
        moodAmount.Angry = moodAmount.Angry *.75
        
        moodAmount.Neutral = moodAmount.Neutral * .25
        
        moodAmount.Sad = moodAmount.Sad * .5
        
        print(
        "Happy: " .. moodAmount.Happy ..
        " Angry: " .. moodAmount.Angry .. 
        " Neutral: " .. moodAmount.Neutral ..
        " Sad: " .. moodAmount.Sad)
    end,
    read = function (self,string)
        local sentenceIsNeutral = true
        for key, value in pairs(wb) do
            for _, phrase in pairs(value) do
                print("Checking for " .. phrase)
                if string:find(phrase) then
                    print("Found " .. phrase )
                    self.moodAmount[key] = self.moodAmount[key] + 1
                    sentenceIsNeutral = false
                end
            end
        end
        if sentenceIsNeutral then
            self.moodAmount.Neutral = self.moodAmount.Neutral + 1
        end
        -- print("Happy: " .. self.moodAmount.Happy .. " Angry: " .. self.moodAmount.Angry .. " Neutral: " .. self.moodAmount.Neutral)
        self:calculateOutput(self.moodAmount)
        -- print("Happy", self.moodAmount.Happy,"Angry", self.moodAmount.Angry,"Neutral", self.moodAmount.Neutral)
        self.LastText = string
    end,
    
}
local differentPhrases = {
    Happy = {
        "love you", "like you"
    },
    Angry = {
        "hate you",
    },
    Neutral = {},
}

local typeOfText = {
    ['greeting'] = {"hi", "hello", "hey"},
    ['question'] = {"what", "why", "how", "where", "when"},
    ['statement'] = {"i", "you", "the", "it", "this"},
    
}
local moodText = {
    greeting = {
        Happy = {"Hi there!", "Hello!", "Hey!", "Hi friend!", "Hello there!"},
        Angry = {"Hey nerd", "What's good Bub"},
        Neutral = {"Hi.", "Hello.", "Hey."},
    },
    question = {
        Happy = {"What do you need help with?", "What are you looking for friend?"},
        Angry = {"What are you doing?", "What do you want?"},
        Neutral = {"What?", "I don't understand.", "Can you say that again?"},
    },
    statement = {
        Happy = {"I love you too!", "I like you! too"},
        Angry = {"I hate you!", "I don't like you!"},
        Neutral = {"Okay.", "I see.", "Interesting."},
    },
    neutral = {
        Happy = {"How are you?", "What's Good?"},
        Angry = {"Leave me alone?", "What do you want?"},
        Neutral = {"What?", "Ahh okay", "Can you say that again?"},
    },
}
local function getTypeOfText(LastText)
    LastText = LastText:lower()
    local textType = {['neutral'] = 1,['greeting'] = 0, ['question'] = 0, ['statement'] = 0}
    for type, words in pairs(typeOfText) do
        for key, startingWord in pairs(words) do
            print(type)
            local startIndex, endIndex = LastText:find(startingWord)
            print("looking for " .. startingWord .. " in " .. LastText)
            print(endIndex,startIndex)
            if startIndex and endIndex then
                print("Found " .. startingWord .. " in " .. LastText)
                textType[type] = textType[type] + 1
            else
                break
            end
            LastText = string.sub(LastText, endIndex + 1)
            -- startingWord = startingWord:lower()
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

local AI = {
    Mood = "Neutral",
    LastText = "",
    moodAmount = {
        Happy = 0,
        Angry = 0,
        Neutral = 0,
    },
    calculateOutput = function(self,moodAmount)
        moodAmount.Happy = moodAmount.Happy *.5
        
        moodAmount.Angry = moodAmount.Angry *.75

        moodAmount.Neutral = moodAmount.Neutral * .25
        
        print("Happy: " .. moodAmount.Happy .. " Angry: " .. moodAmount.Angry .. " Neutral: " .. moodAmount.Neutral)
        if moodAmount.Happy > moodAmount.Angry and moodAmount.Happy > moodAmount.Neutral then
            self.Mood = "Happy"
        elseif moodAmount.Angry > moodAmount.Happy and moodAmount.Angry > moodAmount.Neutral then
            self.Mood = "Angry"
        elseif moodAmount.Neutral > moodAmount.Happy and moodAmount.Neutral > moodAmount.Angry then
            self.Mood = "Neutral"
        end
    end,
    read = function (self,string) 
        local sentenceIsNeutral = true
        for key, value in pairs(differentPhrases) do
            for _, phrase in pairs(value) do
                print("Checking for " .. phrase)
                if string:find(phrase) then
                    print("Found " .. phrase )
                    self.moodAmount[key] = self.moodAmount[key] + 1
                    sentenceIsNeutral = false
                end
            end
        end
        if sentenceIsNeutral then
            self.moodAmount.Neutral = self.moodAmount.Neutral + 1
        end
        print("Happy: " .. self.moodAmount.Happy .. " Angry: " .. self.moodAmount.Angry .. " Neutral: " .. self.moodAmount.Neutral)
        self:calculateOutput(self.moodAmount)
        print("Happy", self.moodAmount.Happy,"Angry", self.moodAmount.Angry,"Neutral", self.moodAmount.Neutral)
        self.LastText = string
    end,
    determineResponse = function(self)
        local typeOfPhrase = getTypeOfText(self.LastText)
        return self:getPhrase(typeOfPhrase)
    end,
    getPhrase = function(self, typeOfPhrase)
        return moodText[typeOfPhrase][self.Mood][math.random(1, #moodText[typeOfPhrase][self.Mood])]
    end,
}

return malachi