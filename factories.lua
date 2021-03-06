local ps = physics_system
local force = force_system
local draw = draw_system
local collision = collision_system
local controller = controller_system
local input = input_system

factories = 
{
    make_player = function(mass_id, pos, radius, id, inputs)
        input.add_player_input(id, inputs)
        local player = player_system.init_player(id, mass_id, radius)
        local entity = collision.add_circle(pos[1], pos[2], radius, id, "player")
        ps.add_entity(entity, mass_id, id, pos[1], pos[2])
        draw.add_draw_entity(id, "player", rawget(entity, "_center"))
        return id
    end;
    make_ground = function(x, y, w, h, id)
        id = id or tostring(player)
        local entity = collision.add_rectangle(x, y, w, h, id, "ground")
        draw.add_draw_entity(id, "ground", entity._polygon.centroid, w, h)
        return id
    end;
}

return factories
