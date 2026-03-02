_G.love = require 'love'
_G.neuron = require'neuron' 
local chat = require 'chat'
_G.love = require 'love'
_G.wb = require 'tools.wordbank'
_G.AI = require 'malachi'
-- _G.sti = require 'libs.STI.sti'
_G.player = require 'player'
-- _G.responses = require 'tools.responses'
-- _G.typeOfTexts = require 'tools.typeOfTexts'
_G.MLAI = require'ML'

for key, value in pairs(MLAI.Neurons) do
    for word, weight in pairs(value.weights) do
        print(key,":",word,":",weight)
    end
end
print("\n")
for i = 1,100 do
    MLAI:trainMassData("trainingdata.txt")
end
for key, value in pairs(MLAI.Neurons) do
    for word, weight in pairs(value.weights) do
        print(key,":",word,":",weight)
    end
end


-- local test1 = MLAI:predict("I hate you")
-- local test2 = MLAI:predict("I love you")
-- local test3 = MLAI:predict("Hello there")

print("You are annoying", MLAI:predict("You are annoying"))
print("I really love this", MLAI:predict("I really love this"))
print("Hello friend", MLAI:predict("Hello friend"))

-- print("Angry hello weight:", MLAI.neurons.Angry.weights["hello"])
-- print("Angry there weight:", MLAI.neurons.Angry.weights["there"])
function love.load()
    chat:load() 
    -- map = sti("assets/tiled/mainRoom.lua", { "bump" })
    -- map:bump_init(map)
    -- map:resize(20, 20)
end




function love.update(dt)
    -- if player.state == "idle" then
    --     player:update(dt)
    -- end
    -- AI:update(dt)
    
    chat:update(dt)
end

function love.textinput(t)
    chat:textinput(t)
end

function love.draw()
    chat:draw()
    -- player:draw()
    -- AI:draw()
end

function love.keypressed(k)
    chat:keypressed(k)
end



