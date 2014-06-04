local fsm = fsm_system
local ps = physics_system 


local function ground_state(id, mass_id)
    local left, right, up, nothing
    left = 
    {
        time_elapsed = 0;
        update = function(self, inputs, dt)
            local prev_time_elapsed = self.time_elapsed
            self.time_elapsed = 0
            local stay = false
            for _, input in pairs(inputs) do
                if input == "left" then
                    stay = true
                    ps.add_force(id, - vars[mass_id] * vars.ground_acc, 0)
                    time_elapsed = prev_time_elapsed + dt
                end
                if input == "right" then
                    return right
                end
                if input == "up" then
                    return up
                end
            end
            return stay and self or nothing
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
            local stay = false
            for _, input in pairs(inputs) do
                if input == "right" then
                    stay = true
                    ps.add_force(id, vars[mass_id] * vars.ground_acc, 0)
                    time_elapsed = prev_time_elapsed + dt
                end
                if input == "left" then
                    return left
                end
                if input == "up" then
                    return up
                end
            end
            return stay and self or nothing
        end;
        enter = function(self, dt)
        end;
    }
    up =
    {
        time_elapsed = 0;
        update = function(self, inputs, dt)
            for _, input in pairs(inputs) do
                if input == "left" then
                    return left
                elseif input == "right" then
                    return right
                end
            end
            return nothing
        end;
        enter = function(self, dt)
            ps.add_force(id, 0, -vars[mass_id] * vars.jump_acc)
            players[id].env_fsm.push_input("air")
        end;
    }
    nothing =
    {
        time_elapsed = 0;
        update = function(self, inputs, dt)    
            for _, input in pairs(inputs) do        
                if input == "up" then    
                    return up
                elseif input == "left" then
                    return left
                elseif input == "right" then
                    return right
                end
            end
            -- damping factor
           -- physics_entities[id].v[1] = physics_entities[id].v[1] * (1 - 2 *dt)
            return self
        end;
        enter = function(self, dt)
        end;
    }
    return nothing
end

local function air_state(id, mass_id)
    local left, right, nothing
    left = 
    {
        time_elapsed = 0;
        update = function(self, inputs, dt)
            local prev_time_elapsed = self.time_elapsed
            self.time_elapsed = 0
            for _, input in pairs(inputs) do
                if input == "left" then
                    ps.add_force(id, - vars[mass_id] * vars.air_acc, 0)
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
            local stay = false
            for _, input in pairs(inputs) do
                if input == "right" then
                    stay = true
                    ps.add_force(id, vars[mass_id] * vars.air_acc, 0)
                    time_elapsed = prev_time_elapsed + dt
                end
                if input == "left" then
                    return left
                end
            end
            return stay and self or nothing
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
            -- damping factor
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
    air_state = air_state -- TEMP
}


return controller_system
