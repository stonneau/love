local pi = math.pi

local function minus_sign(val)
    if val > 0 then return -1 else return 1 end
end

force_system = {
air_resistance = function (radius, cx) -- approximate to spheres
    cx = cx or 0.5 -- frottement dans l air
    local surface = radius * radius * pi
    local val = (1 / 2) * 1.293 * surface * cx * 0 -- masse volumique de l air
    return function(force_accum, speed)
        force_accum[1] = force_accum[1] + val * minus_sign(speed[1]) *
        speed[1] * speed[1]
        force_accum[2] = force_accum[2] + val * minus_sign(speed[2]) *
        speed[2] * speed[2]
    end
end;

gravity = function(mass) -- approximate to spheres
    local res = {0, 98.1 * 2 * mass}
    return function(force_accum, ...)
        force_accum[1] = force_accum[1] + res[1]
        force_accum[2] = force_accum[2] + res[2]    
    end
end;
}

return force_system

