local ps = physics_system
local force = force_system
local draw = draw_system
local collision = collision_system
local fsm = fsm_system
local controller = controller_system

local kb = love.keyboard

players = {}

--[[local function input_ground(id, mass)
    local buttons = player_inputs[id]
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
    local buttons = player_inputs[id]
    return function(player, dt)
        if kb.isDown(buttons["right"]) then
            ps.add_force(id, mass, 0)        
        end
    end
end ]]--

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
            players[id].current_state = self
            forces_entities[id] = self.forces
        end;     
        control_fsm = fsm.new(controller.air_state(id, mass))
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
            players[id].current_state = self
            forces_entities[id] = self.forces
        end;
        control_fsm = fsm.new(controller.ground_state(id, mass))
    }
    air:enter(0)
    return air
end

player_system =
{
    init_player = function(id, mass, radius)
        players[id] = {}
        local init_state = init_states(id, mass, radius)
        players[id].env_fsm = fsm.new(init_state)
        return players[id]
    end;
    update = function(self, dt)
        for _, player in pairs(players) do
            player.current_state.control_fsm:update(dt)
            player.env_fsm:update(dt)
        end
    end;
}

return player_system
