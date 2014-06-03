player_inputs = {}

local kb = love.keyboard

input_system = 
{
    add_player_input = function(id, inputs)
        player_inputs[id] = inputs
    end;
    update = function(self, dt)
        for id, inputs in pairs (player_inputs) do
            for key, val in pairs (inputs) do
                if kb.isDown(val) then
                    players[id].current_state.control_fsm.push_input(key)
                end
            end
        end
    end
}


return input_system
