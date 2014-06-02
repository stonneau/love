local collision = require "collision"
local ps     = require "physics"
local force  = require "force"
local draw   = require "draw"
local factories = require "factories"
require "input"
require "fsm"

local player = require "player"

function love.load()
    g = love.graphics
    
    curve = love.math.newBezierCurve( {0,0,100, 100} )
    pointss = curve:render(10)
    playerColor = {255,0,128}
    groundColor = {25,200,25}
    
    input_system["p1"] = {left ="left", right ="right" }
    input_system["p2"] = {left ="q", right ="d" }
    factories.make_player(1000000, {20, 20}, 10, "p1")
    
    factories.make_player(10000, {200, 200}, 10, "p2")
    
    factories.make_ground(5, 210, 1000, 10, "sol")
    --physics_entities["p2"].v[1]=20
    --physics_entities["p2"].v[2]=-800
    --local sphere1 = {r = 2}
    --local forces1 = {force.gravity(100), force.air_resistance(sphere1)}
    --local id1, p1 = ps.add_entity(20, 20, 100, forces1)
        
    --p2.v[1]=1
   -- p2:set_dy(-0.1)
end
 
function love.update(dt)
    player:update(dt)
    ps:update(dt)
    collision:update(dt)
end
 
function love.draw()
    -- round down our x, y values
    for _, draw_func in pairs(draw_entities) do
        draw_func()
    end
    for t = 1, 100, 5 do
       g.point(curve:evaluate(t / 100))
    end
end
 
function love.keyreleased(key)
    if key == "escape" then
        love.event.push("q")   -- actually causes the app to quit
    end
end
