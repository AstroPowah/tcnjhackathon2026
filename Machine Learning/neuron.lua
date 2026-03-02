
local function neuron(name,target)
    local self = {}
    self.target = target
    self.name = name
    self.weights = {
        ["love"] = 0,
        ["hate"] = 0,
        ["you"] = 0,
    }
    -- print("Hi i'm a neurons")
    function self:predict(words)
        local amountWords = {}
        for i, word in ipairs(words) do
            if self.weights[word] then
                if not amountWords[word] then
                    amountWords[word] = 0
                end
                amountWords[word] = amountWords[word]+1
            else 
                if not amountWords[word] then
                    amountWords[word] = 0
                end
                self.weights[word] = 0
                amountWords[word] = amountWords[word]+1
            end
        end
        -- print("Values in Amount Words")
        -- for key, value in pairs(amountWords) do
        --     print(key,value)
        -- end
        local dotProduct = 0
        for word, amount in pairs(amountWords) do
            dotProduct = dotProduct + (self.weights[word]*amount)
        end
        -- print("DotProduct: ",dotProduct)
        return dotProduct
    end
    function self:train(words, target, lr)
        local output = self:predict(words)
        local error = target - output
        -- print(   "The target",target, "this is ", self.name)
        for _, word in ipairs(words) do
            if self.weights[word] == nil then
                self.weights[word] = 0
            end
            self.weights[word] = self.weights[word] + error * lr
        end
    end

    return self
end

return neuron