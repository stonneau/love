local kb = love.keyboard
local watched = {}
--[[
function love.keypressed(key, isrepeat)
   if watched[key] then
      watched[key].status = true
   end
end

function love.keyreleased(key)
   if watched[key] then
      watched[key].status = false
   end
end]]--

local time_to_die = 0.3

input_system = 
{
    add_player_input = function(id, inputs)
        for input, key in pairs(inputs) do
            watched[key] = {status = 0, id = id, input = input}
        end
    end;
    update = function(self, dt)
        for key, data in pairs(watched) do
            local pressed = kb.isDown(key)
            if pressed then data.status = time_to_die elseif data.status > 0 then data.status = data.status - dt end
            if data.status > 0 then
                players[data.id].current_state.control_fsm.push_input(data.input)
            end
        end
    end
}


return input_system
