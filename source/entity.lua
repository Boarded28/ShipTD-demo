local Vector2 = require("source.vector2")

local Entity = {}
Entity.__index = Entity

function Entity:new(x, y, width, height)
    local instance = setmetatable({}, Entity)
    instance.pos = Vector2:new(x, y)
    instance.vel = Vector2:new(0, 0)
    instance.angle = 0
    instance.w = width or 0
    instance.h = height or 0

    return instance
end

function Entity:update(dt)
    self.pos = self.pos:add(self.vel:mul(dt))
end

function Entity:draw()
    
end

function Entity:drawObj(...)
    local p = self.pos
    love.graphics.push()
    love.graphics.translate(p.x, p.y)
    love.graphics.rotate(self.angle)
    love.graphics.polygon("line", ...)
    love.graphics.pop()
end

return Entity