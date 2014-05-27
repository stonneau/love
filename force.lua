
local pi = math.pi

return {
air_resistance = function (sphere, cx) -- approximate to spheres
    cx = cx or 0.5 -- frottement dans l air
    local surface = sphere.r * sphere.r * pi
    local val = (1 / 2) * 1.293 * surface * cx -- masse volumique de l air
    return function(force_accum, speed)
        force_accum[1] = force_accum[1] - val * speed[1] * speed[1]
        force_accum[2] = force_accum[2] - val * speed[2] * speed[2]
    end
end;

gravity = function(mass) -- approximate to spheres
    local res = {0, 0.00981 * mass}
    return function(force_accum, ...)
        force_accum[1] = force_accum[1] + res[1]
        force_accum[2] = force_accum[2] + res[2]
    end
end
}

