local Entities = {} --// table to store all our entities

function love.load()
    --// Requirements
    local Player = require("source.player")

    --// Screen values
    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()

    --// Constructors
    P1 = Player:new(sw/2, sh/2, 10, 15)
    Entities[1] = P1
end

function love.update(dt)
    
    --// update all entities in the table 
    for i, v in ipairs(Entities) do
        Entities[i]:update(dt)
    end
end

function love.draw()
    
    --// draw all entities in the table 
    for i, v in ipairs(Entities) do
        Entities[i]:draw()
    end
end