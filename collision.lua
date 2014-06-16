local HC = require "HardonCollider"

local collision_functions -- collisions entering
local out_collision_functions -- collisions entering

-- collisions entering

local function player_ground(dt, player, ground, mtv_x, mtv_y)
    players[player.id].env_fsm.push_input("ground")
    player.v[2] = 0
    player.pos[2] = player.pos[2] + (mtv_y or 0)
    player.pos[1] = player.pos[1] + (mtv_x or 0)
    player:moveTo(player.pos[1], player.pos[2])
end

collision_functions =
{
    player = { ground = player_ground};
    ground = { player = function(dt, ground, player) player_ground(dt, player, ground) end}
}

function on_collide(dt, shape_a, shape_b, mtv_x, mtv_y)
    local rank_one = collision_functions[shape_a.entity_type]
    if rank_one then 
        rank_two = rank_one[shape_b.entity_type]
        return rank_two and rank_two(dt, shape_a, shape_b, mtv_x, mtv_y) or nil
    end
end

-- collisions exiting

local function out_player_ground(dt, player, ground, mtv_x, mtv_y)
    players[player.id].env_fsm.push_input("air")
end

out_collision_functions =
{
    player = { ground = out_player_ground};
    ground = { player = function(dt, ground, player) out_player_ground(dt, player, ground) end}
}

function collision_stop(dt, shape_a, shape_b)
    local rank_one = out_collision_functions[shape_a.entity_type]
    if rank_one then 
        rank_two = rank_one[shape_b.entity_type]
        return rank_two and rank_two(dt, shape_a, shape_b, mtv_x, mtv_y) or nil
    end
end

local collider = HC(100, on_collide, collision_stop)

collision_system  = 
{
    add_circle = function(cx, cy, radius, id, entity_type)
        local shape = collider:addCircle(cx, cy, radius)
        shape.id = id
        shape.entity_type = entity_type
        return shape
    end,
    add_rectangle = function(x, y, w, h, id, entity_type)
        local shape = collider:addRectangle(x, y, w, h, radius)
        shape.id = id
        shape.entity_type = entity_type
        return shape
    end,
    update = function(self, dt)
        collider:update(dt)
    end
}
return collision_system

