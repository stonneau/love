local ps = require "physics"
local force = require "force"
function love.load()
    g = love.graphics
    
    playerColor = {255,0,128}
    groundColor = {25,200,25}
    p = {} 
    p.width = 25
    p.height = 40
    
    
    local sphere1 = {r = 2}
    local forces1 = {force.gravity(100), force.air_resistance(sphere1)}
    local id1, p1 = ps.add_entity(20, 20, 100, forces1)
    
    local sphere2 = {r = 2}
    local forces2 = {force.gravity(100), force.air_resistance(sphere2)}
    local id2, p2 = ps.add_entity(60, 20, 100, forces2, "p2")
    
    --p2.v[1]=1
   -- p2:set_dy(-0.1)
end
 
function love.update(dt)
    ps:update(dt)
end
 
function love.draw()
    -- round down our x, y values
    for id, e in pairs(physics_entities) do
        local x, y = e.pos[1], e.pos[2]
         -- draw the player shape
        g.setColor(playerColor)
        g.rectangle("fill", x, y, p.width, p.height)
    end
end
 
function love.keyreleased(key)
    if key == "escape" then
        love.event.push("q")   -- actually causes the app to quit
    end
    if (key == "right") or (key == "left") then
        p:stop()
    end
end
