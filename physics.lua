physics_entities = {}

local function compute_forces(dt, gravity)
    for id, e in pairs(physics_entities) do
        for _, force in ipairs(e.forces) do
            force(e.f, e.v)
        end
    end
end

return {
add_entity = function(x, y, m, forces, id)
    local entity = {} 
    id = id or tostring(entity)
    setmetatable(entity, { __tostring = function(t) 
        return "physics entity" .. id .. "\n" .. "position x: " .. entity.pos[1].. "y :" .. entity.pos[2] .. "\n speed dx: " .. entity.v[1] .. " dy: ".. entity.v[2] .. 
        "\n forces fx: " .. entity.f[1] .. " fy: ".. entity.f[2] .. "\n"
    end} )
    if physics_entities[id] then return nil end
    entity.pos = {x or 0, y or 0}
    entity.v = {0, 0}
    entity.f = {0, 0}
    entity.m = m or 1
    entity.forces = forces or {}
    physics_entities[id] = entity
    return id, entity
end;

-- forces resetted after update
-- manual forces must be added before call to update
update = function (self, dt)
    --clear_Forces(p); /* zero the force accumulators */
    compute_forces(dt, self.gravity); 
    for id, e in pairs(physics_entities) do
        print(e)
        for i = 1, 2, 1 do
            e.pos[i]= e.pos[i] + e.v[i]
            e.v[i]= e.v[i] + e.f[i] / e.m
            e.f[i] = 0
        end       
    end
end
}

