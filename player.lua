local ps = physics_system
local force = force_system
local draw = draw_system
local collision = collision_system

local kb = love.keyboard

players = {}

local function input_ground(id, mass)
    local buttons = input_system[id]
    return function()
        if kb.isDown(buttons["left"]) then
            ps.add_force(id, -mass, 0)        
        end
    end
end

local function input_air(id, mass)
    local buttons = input_system[id]
    return function()
        if kb.isDown(buttons["right"]) then
            ps.add_force(id, mass, 0)        
        end
    end
end

local function init_controls (id, mass, radius)
    players[id].states["ground"].input = input_ground(id, mass)
    players[id].states["air"].input = input_air(id, mass)
end

local function init_states(id, mass, radius)
    players[id].states["air"] = { forces = 
                        {force.gravity(mass), force.air_resistance(radius)}}
    players[id].states["ground"] = { forces = {force.air_resistance(radius * 50)}}
end

local set_state_methods = 
{
    air = function(id)
        forces_entities[id] = players[id].states["air"].forces
    end;
    ground = function(id)
        forces_entities[id] = players[id].states["ground"].forces
    end
}

player_system =
{
    init_player = function(id, mass, radius)
        players[id] = { states = {}}
        init_states(id, mass, radius)
        init_controls(id, mass, radius)
        players[id].current_state = players[id].states["air"]
        return players[id]
    end;
    set_state = function(id, state)
        set_state_methods[state](id)
        players[id].current_state = players[id].states[state]
    end;
    update = function(self)
        for _, player in pairs(players) do
            player.current_state.input()
        end
    end;
}

return player_system
