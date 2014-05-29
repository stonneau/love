draw_entities = {}

draw_system = 
{
    add_draw_entity = function(id, pos)
        draw_entities[id] = function()
            local x, y = pos.x, pos.y
             -- draw the player shape
            g.setColor({255,0,128})
            g.circle("fill", x, y, 10, 10)
        end
    end
}

return draw_system
