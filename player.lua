local Entity = require("entity")

local Player = setmetatable({}, {__index = Entity})
Player.__index = Player

---@diagnostic disable-next-line: duplicate-set-field
function Player:new(x, y, width, height)
    local instance = setmetatable(Entity:new(x, y, width, height), Player)
    instance.rspeed = 3
    return instance
end

---@diagnostic disable-next-line: duplicate-set-field
function Player:update(dt)
    self:lookAt(dt)
end

---@diagnostic disable-next-line: duplicate-set-field
function Player:draw()
    self:drawObj(self.h/2, 0, -self.h/2, -self.w/2, self.w/2 - self.w, 0, -self.h/2, self.w/2)
    
    --print("Player:-{x:"..self.pos.x..",y:"..self.pos.y.."}")
end

function Player:lookAt(dt)
    local mx, my = love.mouse.getPosition()
    local target = math.atan2(my - self.pos.y, mx - self.pos.x)
    local difference = target - self.angle
    difference = (difference - math.pi) % (2 * math.pi) - math.pi
    local rspeed = self.rspeed
    self.angle = self.angle + difference * math.min(rspeed * dt, 1)
end

return Player