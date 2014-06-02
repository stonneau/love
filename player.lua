local ps = physics_system
local force = force_system
local draw = draw_system
local collision = collision_system
local fsm = fsm_system

local kb = love.keyboard

players = {}

local function input_ground(id, mass)
    local buttons = input_system[id]
    return function(player, dt)
        if kb.isDown(buttons["left"]) then
            ps.add_force(id, - mass * 100, 0)
        end
        if kb.isDown(buttons["right"]) then
            ps.add_force(id,  mass * 100, 0)     
        end
    end
end

local function input_air(id, mass)
    local buttons = input_system[id]
    return function(player, dt)
        if kb.isDown(buttons["right"]) then
            ps.add_force(id, mass, 0)        
        end
    end
end

local function init_states(id, mass, radius)
    local air, ground
    air = 
    {
        forces = {force.gravity(mass), force.air_resistance(radius)};
        update = function(slef, inputs, dt)
            for _, input in pairs(inputs) do
                if input == "ground" then
                    return ground
                end
            end
        end;
        enter = function(self, dt)
            forces_entities[id] = self.forces
        end;
        input = input_air(id, mass)
    }
    ground = 
    {
        forces = {force.air_resistance(radius)};
        update = function(slef, inputs, dt)
            for _, input in pairs(inputs) do
                if input == "air" then 
                    return air
                end
            end
        end;
        enter = function(self, dt)
            forces_entities[id] = self.forces
        end;
        input = input_ground(id, mass)
    }
    air:enter(0)
    return air
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
        players[id] = { states = {}, dir = {}, env_fsm = fsm.new(init_states(id, mass, radius)) }
        return players[id]
    end;
    set_state = function(id, state)
        set_state_methods[state](id)
        players[id].current_state = players[id].states[state]
    end;
    update = function(self, dt)
        for _, player in pairs(players) do
            local state = player.env_fsm:update(dt)
            state.input(player, dt)
        end
    end;
}

return player_system
