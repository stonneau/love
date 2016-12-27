vars = 
{
}

local fonts =
{
    [12] = love.graphics.newFont(12),
    [20] = love.graphics.newFont(20),
}
love.graphics.setFont(fonts[12])
-- group defaults
--~ gui.group.default.size[1] = 150
--~ gui.group.default.size[2] = 25
--~ gui.group.default.spacing = 5


sliders   = 
{
    player_mass = {value = 10000, min = 0.1, max = 20000},
    ground_acc = {value = 5933,min = 0.1, max = 10000};
    air_acc = {value = 380,min = 0.1, max = 1000};
    air_friction_x = {value = 0.07,min = 0.01, max = 2};
    air_friction_y = {value = 0.01,min = 0.01, max = 0.3};
    ground_friction = {value =  2.0, min = 0.1, max = 20};
    jump_acc = {value = 23333.67, max = 50000};    
    gravity = {value = 10, min = 0.1, max = 50}
}

for name, data in pairs(sliders) do
    vars[name] = data.value
end	

var_system = 
{
    update = function(self)  
    -- put the layout origin at position (100,100)
    -- cells will grown down and to the right from this point
    -- also set cell padding to 20 pixels to the right and to the bottom
    gui.layout:reset(100,300, 20,20)
	-- put a slider in the cell
	-- the inner cell will be 160 px wide and 20 px high
	local i = 0
	for name, slider in pairs(sliders) do	
		gui.Slider(slider, gui.layout:row(160,20))
		gui.Label((name .. " %.02f"):format(slider.value), gui.layout:row(80))
		i = i+1
		if i == 3 then	
			gui.layout:reset(320,300, 20,20)
		elseif i == 6 then	
			gui.layout:reset(540,300, 20,20)
		end
	end


    --~ gui.group{grow = "down", function()
         --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "player_mass", size = {70}}
			    --~ gui.Slider{info = sliders.player_mass}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.player_mass.value), size = {70}}
		    --~ end}
		    --~ 
	    --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "gravity", size = {70}}
			    --~ gui.Slider{info = sliders.gravity}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.gravity.value), size = {70}}
		    --~ end}
		    --~ 
         --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "ground_acc", size = {70}}
			    --~ gui.Slider{info = sliders.ground_acc}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.ground_acc.value), size = {70}}
		    --~ end}
		--~ 
	     --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "air_acc", size = {70}}
			    --~ gui.Slider{info = sliders.air_acc}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.air_acc.value), size = {70}}
		    --~ end}
		--~ 
	     --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "air_friction_x", size = {70}}
			    --~ gui.Slider{info = sliders.air_friction_x}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.air_friction_x.value), size = {70}}
		    --~ end}
		    --~ 
	     --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "air_friction_y", size = {70}}
			    --~ gui.Slider{info = sliders.air_friction_y}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.air_friction_y.value), size = {70}}
		    --~ end}
		--~ 
	     --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "ground_friction", size = {70}}
			    --~ gui.Slider{info = sliders.ground_friction}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.ground_friction.value), size = {70}}
		    --~ end}
		--~ 
	     --~ gui.group{grow = "right", function()
			    --~ gui.Label{text = "jump_acc", size = {70}}
			    --~ gui.Slider{info = sliders.jump_acc}
			    --~ gui.Label{text = ("Value: %.2f"):format(sliders.jump_acc.value), size = {70}}
		    --~ end}
	    --~ end}
	    
	    for name, data in pairs(sliders) do
	        vars[name] = data.value
	        --~ print( name .. " " .. vars[name])
	    end	    
    end
}

return var_system
