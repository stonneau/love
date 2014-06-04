local pi = math.pi

local function minus_sign(val)
    if val > 0 then return -1 else return 1 end
end

force_system = {
air_resistance = function (radius, coeffx, coeffy) -- approximate to spheres
   local surface = radius * radius * pi
    coeffy = coeffy or coeffx
    local val_x = (1 / 2) * 1.293 * surface -- masse volumique de l air
    local val_y = (1 / 2) * 1.293 * surface -- masse volumique de l air
    return function(force_accum, speed)
        force_accum[1] = force_accum[1] + val_x * coeffx.value * minus_sign(speed[1]) *
        speed[1] * speed[1]
        force_accum[2] = force_accum[2] + val_y * coeffy.value * minus_sign(speed[2]) *
        speed[2] * speed[2]
    end
end;

gravity = function(mass_id) -- approximate to spheres
    local res = {0, 98.1 * 2}
    return function(force_accum, ...)
        force_accum[1] = force_accum[1] + res[1]
        force_accum[2] = force_accum[2] + res[2]  * vars[mass_id]  
    end
end;
}

return force_system

