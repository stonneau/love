fsm_system = {}

fsm_system.new = function(state)
    local inputs = {}
    local current_state = state
    local res = {}
    res.push_input = function(input)
        inputs[#inputs +1] = input
    end    
    res.update = function(self, dt)
        local new_state = current_state:update(inputs, dt)
        if new_state and current_state ~= new_state then
            current_state = new_state
            current_state:enter(dt)
        end
        inputs = {}
        return current_state
    end
    return res
end
return fsm_system
