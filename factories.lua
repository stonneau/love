local ps = physics_system
local force = force_system
local draw = draw_system
local collision = collision_system

factories = 
{
    make_player = function(mass, pos, radius, id)
        local player = player_system.init_player(id, mass, radius)
        local entity = collision.add_circle(pos[1], pos[2], radius, id, "player")
        ps.add_entity(entity, mass, id, pos[1], pos[2])
        forces_entities[id] = player.states["air"].forces
        draw.add_draw_entity(id, rawget(entity, "_center"))
        return id
    end;
    make_ground = function(x, y, w, h, id)
        id = id or tostring(player)
        local entity = collision.add_rectangle(x, y, w, h, id, "ground")
        draw.add_draw_entity(id, entity._polygon.centroid)
        return id
    end;
}

return factories