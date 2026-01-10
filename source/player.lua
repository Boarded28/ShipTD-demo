local player = {
    x = 0, y = 0,
    speed = 100,
    angle = 0,
    dx = 0, dy = 0
}

-- Calculations --
local function drawBoid(mode, x, y, length, width, angle)
    love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.polygon(mode, -width, length, width, length, 0, -length)
    love.graphics.pop()
end

local function showAim(x, y, angle)
    love.graphics.push()
    love.graphics.setColor(1, 1, 1, 0.25)
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.line(0, -95, 0, -100)
    love.graphics.pop()
end

local function lookAt(dt, x, y)
    local mx, my = love.mouse.getPosition()
    local targetAngle = math.atan2(my - y, mx -x)
    
    -- face:up, set -math.pi/2
    -- face:down, set math.pi/2
    -- face:right, set math.pi
    -- face:left, set -math.pi
    local difference = ((targetAngle - player.angle + -math.pi/2) % (2 * math.pi) - math.pi) --[-π, π), normalizes the angle

    return player.angle + difference * 10 * dt
end

local function drawDebug(x, y)
    local mx, my = love.mouse.getPosition()
    love.graphics.line(x, y, mx, my)
    love.graphics.line(x, y, mx, y, mx, my)
    
    local distance = math.sqrt((x - mx)^2 + (y - my)^2) --c = a^2 + b^2
    love.graphics.circle("line", x, y, distance)
    
    love.graphics.circle("fill", x, y, 3)
end


-- Player functions --
function player.setposition(self, x, y)
    self.x = x
    self.y = y
end

function player:update(dt)
    self.angle = lookAt(dt, self.x, self.y)
end

function player:draw()
    drawBoid("line", self.x, self.y, 10, 8, self.angle)
    showAim(self.x, self.y, self.angle)
    --drawDebug(self.x, self.y)
end

return player