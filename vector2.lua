local Vector2 = {}
Vector2.__index = Vector2

function Vector2:new(x, y)
    local instance = setmetatable({}, Vector2)
    instance.x = x or 0
    instance.y = y or 0

    return instance
end

function Vector2:add(other)
    return Vector2:new(self.x + other.x, self.y + other.y)
end

function Vector2:subtact(other)
    return Vector2:new(self.x - other.x, self.y - other.y)
end

function Vector2:mul(scalar)
    return Vector2:new(self.x * scalar, self.y * scalar)
end

function Vector2:div(scalar)
    return Vector2:new(self.x / scalar, self.y / scalar)
end

function Vector2:length()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector2:distanceTo(other)
    local dx = self.x - other.x
    local dy = self.y - other.y
    return math.sqrt(dx^2 + dy^2)
end

function Vector2:normalized()
    --// normalize vector to prevent faster movement 
    --// when both vx and vy are active
    local mag = self:length()

    if mag > 0 then
        return Vector2:new(self.x/mag, self.y/mag)
    end
    return Vector2:new(0, 0)
end

return Vector2