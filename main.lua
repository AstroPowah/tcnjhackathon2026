-- _G.love = require"love"
-- _G.https = require"https"

-- local code, body = https.request("https://www.google.com/")
print("HI")

local function calculateOutput(moodAmount)
    moodAmount.Happy = moodAmount.Happy *.5
    
    moodAmount.Angry = moodAmount.Angry *.75

    moodAmount.Neutral = moodAmount.Neutral * 1
end

local differentPhrases = {
    Happy = {"love you", "like you"},
    Angry = {"hate you", "dislike you"},
    Neutral = {"like you"},
}

local AI = {
    Mood = "Neutral",
    moodAmount = {
        Happy = 0,
        Angry = 0,
        Neutral = 0,
    },
    read = function (self,string) 
        for key, value in pairs(differentPhrases) do
            for _, phrase in pairs(value) do
                if string:find(phrase) then
                    self.moodAmount[key] = self.moodAmount[key] + 1
                end
            end
        end
        print(self.moodAmount.Happy, self.moodAmount.Angry, self.moodAmount.Neutral)
        calculateOutput(self.moodAmount)
        print(self.moodAmount.Happy, self.moodAmount.Angry, self.moodAmount.Neutral)
    end
}
local input = io.read()
while true do
    
    if input == "exit" then
        break
    end
    
    AI:read(input)
    input = io.read()
end
-- AI.Mood

-- for _, value in pairs(dia[AI.Moods]) do
    
-- end

-- math.random(1,#dia[AI.Moods])