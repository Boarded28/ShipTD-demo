local player = {
    x = 0, y = 0,
    angle = 0,
    
    points = 0,
    tm = 1.0,

    speed = 0.5,
    damage = 0,
    bullets = 0,

    timer = 0
}

local function drawBoid(mode, x, y, length, width, angle) --[Creates a triangle with updates to its values]
    love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.polygon(mode, 0, 5, -width, length, 0, -length, width, length)
    love.graphics.pop()
end

local function drawDebug(x, y) --[Just here to show how the angles would look like]
    local mx, my = love.mouse.getPosition()
    love.graphics.line(x, y, mx, my)
    love.graphics.line(x, y, mx, y, mx, my)
    
    local distance = math.sqrt((x - mx)^2 + (y - my)^2) --c = a^2 + b^2
    love.graphics.circle("line", x, y, distance)
    
    love.graphics.circle("fill", x, y, 3)
end

local function showAim(x, y, angle) --[creates a small aim guide offsetted infornt of the player object]
    love.graphics.push()
    love.graphics.setColor(1, 1, 1, 0.25)
    love.graphics.translate(x, y)
    love.graphics.rotate(angle)
    love.graphics.line(0, -95, 0, -100)
    love.graphics.pop()
end



function player.lookAt(self, dt) --[My own take to make an object face the mouse cursor]
    local mx, my = love.mouse.getPosition()
    local targetAngle = math.atan2(my - self.y, mx - self.x)
    
    -- face:up, set -math.pi/2
    -- face:down, set math.pi/2
    -- face:right, set math.pi
    -- face:left, set -math.pi
    local difference = ((targetAngle - player.angle + -math.pi/2) % (2 * math.pi) - math.pi) --[-π, π), normalizes the angle

    self.angle = self.angle + difference * self.speed * dt
end

function player.setposition(self, x, y) --[Sets the players position duhh]
    self.x = x
    self.y = y
end

function player.producePoints(self, dt)
    local max = 5
    self.timer = self.timer + dt * self.tm
    if self.timer > max then
        self.points = self.points + 1
        self.timer = 0
    end
end

function player.drawPoints(self)
    local max = 5
    local font = love.graphics.getFont()
    local width = font:getWidth(self.points)
    local dist = self.timer/max

    local fdist = 30
    local px, py = self.x + fdist * math.cos(self.angle), self.y + fdist * math.sin(self.angle)
    local ox, oy = 2, 14
    love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.points, px, py)
    love.graphics.setColor(1, 1, 1, dist)

    love.graphics.setColor(1 - dist, dist, 0, dist)
    love.graphics.rectangle("fill", px - ox, py + oy, dist*width+2.5, 1.5)
    love.graphics.setColor(1, 1, 1, dist)
    love.graphics.pop()
end


function player:update(dt) --[Classic update function, passed on to main.lua]
    self:lookAt(dt)
    self:producePoints(dt)
end

function player:draw() --[Classic draw function, passed on to main.lua]
    drawBoid("line", self.x, self.y, 10, 8, self.angle)
    showAim(self.x, self.y, self.angle)
    self:drawPoints()
    --drawDebug(self.x, self.y)
end

return player