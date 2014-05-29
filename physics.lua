physics_entities = {}
forces_entities = {}

local function compute_forces(dt)
    for id, e in pairs(physics_entities) do
        for _, force in ipairs(forces_entities[id] or {}) do
            force(e.f, e.v)
        end
    end
end

physics_system = {
add_entity = function(collision_shape, m, id, x, y)
    local entity = collision_shape
    --[[local entity = {} 
    id = id or tostring(entity)
    setmetatable(entity, { __tostring = function(t) 
        return "physics entity" .. id .. "\n" .. "position x: " .. entity.pos[1].. "y :" .. entity.pos[2] .. "\n speed dx: " .. entity.v[1] .. " dy: ".. entity.v[2] .. 
        "\n forces fx: " .. entity.f[1] .. " fy: ".. entity.f[2] .. "\n"
    end} ) ]]--
    if physics_entities[id] then return nil end
    entity.pos = {x or 0, y or 0}
    entity.v = {0, 0}
    entity.f = {0, 0}
    entity.m = m or 1
    physics_entities[id] = entity
    return id, entity
end;

-- forces resetted after update
-- manual forces must be added before call to update
update = function (self, dt)
    --clear_Forces(p); /* zero the force accumulators */
    compute_forces(dt); 
    for id, e in pairs(physics_entities) do
        for i = 1, 2, 1 do
            e.v[i]= e.v[i] + e.f[i] / e.m
            e.pos[i] = e.pos[i] + e.v[i]
            e.f[i] = 0
        end
        e:moveTo(e.pos[1], e.pos[2])       
    end
end;

add_force = function (id, f_x, f_y)
    local f = physics_entities[id].f
    f[1] = f[1] + f_x
    f[2] = f[2] + f_y
end
}

return physics_system

