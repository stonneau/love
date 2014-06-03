local collision = require "collision"
local ps     = require "physics"
local force  = require "force"
local draw   = require "draw"
local input_system = require "input"
require "fsm"
require "controller"
local player = require "player"
local factories = require "factories"
local var_system = require "control_var"

gui = require "Quickie"


function love.load()
    g = love.graphics
    
    var_system:init()
    
    curve = love.math.newBezierCurve( {0,0,100, 100} )
    pointss = curve:render(10)
    playerColor = {255,0,128}
    groundColor = {25,200,25}
    
    local p1_inputs = {left ="left", right ="right", up = "up" }
    local p2_inputs = {left ="q", right ="d", up = "z" }
    factories.make_player(vars.player_mass, {20, 20}, 10, "p1", p1_inputs)
    
    factories.make_player(vars.player_mass, {200, 200}, 10, "p2", p2_inputs)
    
    factories.make_ground(5, 210, 1000, 10, "sol")
    physics_entities["p2"].v[1]=40
    physics_entities["p2"].v[2]=-160
    --local sphere1 = {r = 2}
    --local forces1 = {force.gravity(100), force.air_resistance(sphere1)}
    --local id1, p1 = ps.add_entity(20, 20, 100, forces1)
        
    --p2.v[1]=1
   -- p2:set_dy(-0.1)
end
  
function love.update(dt)
    input_system:update(dt)
    player:update(dt)
    ps:update(dt)
    collision:update(dt)
    var_system:update(dt)
end
 
function love.draw()
    -- round down our x, y values
    for _, draw_func in pairs(draw_entities) do
        draw_func()
    end
    for t = 1, 100, 5 do
       g.point(curve:evaluate(t / 100))
    end
    
    -- draw_gui
    gui.core.draw()
end
 

