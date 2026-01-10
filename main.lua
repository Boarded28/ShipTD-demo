local Particles = require "source.particles"
local Player = require "source.player"

local listOfParticles = {}

function love.load()
    math.randomseed(os.time()) --[for pure randomness since lua uses seed for it]
    
    local centerx = love.graphics.getWidth()/2
    local centery = love.graphics.getHeight()/2
    Player:setposition(centerx, centery) 
end

function love.update(dt)
    Particles.update(listOfParticles, dt)
    Player:update(dt)
end

function love.draw()
    Particles.draw(listOfParticles)
    Player:draw()
end