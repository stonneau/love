local fsm = fsm_system
local ps = physics_system 


local function ground_state(id, mass)
    local left, right, nothing
    left = 
    {
        time_elapsed = 0;
        update = function(self, inputs, dt)
            local prev_time_elapsed = self.time_elapsed
            self.time_elapsed = 0
            for _, input in pairs(inputs) do
                if input == "left" then
                    ps.add_force(id, - mass * 100, 0)
                    time_elapsed = prev_time_elapsed + dt
                    return self
                elseif input == "right" then
                    return right
                end
            end
            return nothing
        end;
        enter = function(self, dt)
        end
    }
    right =
    {
        time_elapsed = 0;
        update = function(self, inputs, dt)
            local prev_time_elapsed = self.time_elapsed
            self.time_elapsed = 0
            for _, input in pairs(inputs) do
                if input == "right" then
                    ps.add_force(id, mass * 100, 0)
                    time_elapsed = prev_time_elapsed + dt
                    return self
                elseif input == "left" then
                    return left
                end
            end
            return nothing
        end;
        enter = function(self, dt)
        end;
    }
    nothing =
    {
        time_elapsed = 0;
        update = function(self, inputs, dt)
            for _, input in pairs(inputs) do
                if input == "right" then    
                    return right
                elseif input == "left" then
                    return left
                end
            end
            return self
        end;
        enter = function(self, dt)
        end;
    }
    return nothing
end

controller_system = 
{
    ground_state = ground_state;
    air_state = ground_state -- TEMP
}


return controller_system
