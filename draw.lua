draw_entities = {}

local draw_factory = 
{
    player = function(id, pos)
        return function()
            local x, y = pos.x, pos.y
             -- draw the player shape
            g.setColor({255,0,128})
            g.circle("fill", x, y, 10, 10)
        end
    end;
    ground = function(id, pos, w, h)
        local off_x = w / 2
        local off_y = h / 2
        return function()
            local x, y = pos.x, pos.y
             -- draw the player shape
            g.setColor({255,0,128})
            g.rectangle("fill", x - off_x, y - off_y, w, h)
        end
    end
    }

draw_system = 
{
    add_draw_entity = function(id, e_type, pos, ...)
        draw_entities[id] = draw_factory[e_type](id, pos, ...) 
    end
}

return draw_system
