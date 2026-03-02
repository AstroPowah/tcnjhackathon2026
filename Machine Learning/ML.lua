local ML = {
    Neurons = {
        Happy = neuron("Happy",1),
        Angry = neuron("Angry",-1),
        Neutral = neuron("Neutral",0)
    },
    moodValue = {
        Angry = -1,
        Neutral = 0,
        Happy = 1
    },
    
    trainMassData = function(self, fileName)
        local file = io.open(fileName, "r")
        if not file then return end

        local content = file:read("*a")
        file:close()
        -- print("Training Mass")
        for line in string.gmatch(content, "[^;]+") do
            -- print(line)
            local sentence, label = string.match(line, '"(.-)"%s*,%s*(%a+)')
            -- print("The sentence:", sentence,"The label",label)
            if sentence and label then
                -- print("Sentence:", sentence)
                -- print("Label:", label)

                -- tokenize
                local words = {}
                for word in string.gmatch(sentence:lower(), "%w+") do
                    table.insert(words, word)
                end
                -- print("Training")
                -- TRAIN HERE
                for mood, Neuron in pairs(self.Neurons) do
                    local target

                    if mood == label then
                        target = 1
                    else
                        target = 0       
                    end
                    -- print(target,mood)
                    -- for index, word in ipairs(words) do
                    --     print(word)
                    -- end
                    Neuron:train(words, target, 0.1)
                end
            end
        end
    end,
    
    predict = function(self,Sentence)
        local values = {}
        local split = {}
        for word in string.gmatch((Sentence), "%a+") do
            table.insert(split, word)
        end
        for mood, neuron in pairs(self.Neurons) do
            values[mood] = neuron:predict(split)
        end

        local bestMood = nil
        local bestScore = -math.huge
        -- print("This sentence is ".. Sentence)
        -- for mood, value in pairs(values) do
        --     print(mood.." got the value ".. value)
        -- end

        for mood, neuron in pairs(self.Neurons) do
            local score = neuron:predict(split)
            if score > bestScore then
                bestScore = score
                bestMood = mood
            end
        end

    
        return bestMood,bestScore
    end,



}

return ML