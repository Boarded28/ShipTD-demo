local particles = {}

function particles.spawn(t, x, y) --[spawns 100 particles in an instant, places the data in a table]
    for i=1, 100 do
        table.insert(t, {
            x = x, y = y,
            vx = math.random(-200, 200),
            vy = math.random(-200, 200),
            life = 1
        })
    end
end

function particles.update(t, dt) --[itterates in the table with the data; gives them update regarding positions and lifetime]
    for i = #t, 1, -1 do
        local p = t[i]
        p.x, p.y = p.x + p.vx * dt, p.y + p.vy * dt
        p.vy, p.life = p.vy + 200 * dt, p.life - dt

        if p.life <= 0 then
            table.remove(p)
        end
    end
end

function particles.draw(t) --[itterates in the table with the data; draws every object]
    for i = #t, 1, -1 do
        local p = t[i]
        love.graphics.rectangle("fill", p.x, p.y, 1, 1)
    end
end

return particles