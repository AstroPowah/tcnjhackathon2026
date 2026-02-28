local

local differentPhrases = {
    Happy = {"love you", "like you"},
    Angry = {"hate you", ""},
    Neutral = {""},
}

local AI = {
    Mood = "Neutral",
    moodAmount = {
        Happy = 0,
        Angry = 0,
        Neutral = 0,
    },
    calculateOutput = function(self,moodAmount)
        moodAmount.Happy = moodAmount.Happy *.5
        
        moodAmount.Angry = moodAmount.Angry *.75

        moodAmount.Neutral = moodAmount.Neutral * 1

        if moodAmount.Happy > moodAmount.Angry and moodAmount.Happy > moodAmount.Neutral then
            self.Mood = "Happy"
        elseif moodAmount.Angry > moodAmount.Happy and moodAmount.Angry > moodAmount.Neutral then
            self.Mood = "Angry"
        elseif moodAmount.Neutral > moodAmount.Happy and moodAmount.Neutral > moodAmount.Angry then
            self.Mood = "Neutral"
        end
    end,
    read = function (self,string) 
        for key, value in pairs(differentPhrases) do
            for _, phrase in pairs(value) do
                if string:find(phrase) then
                    self.moodAmount[key] = self.moodAmount[key] + 1
                end
            end
        end
        print(self.moodAmount.Happy, self.moodAmount.Angry, self.moodAmount.Neutral)
        self:calculateOutput(self.moodAmount)
        print(self.moodAmount.Happy, self.moodAmount.Angry, self.moodAmount.Neutral)
    end,
    response = function ()
        
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