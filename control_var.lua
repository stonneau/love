vars = 
{
    player_mass = 10000
}


sliders   = 
{
    player_mass = {value = 10000, max = 20000},
    ground_acc = {value = 5933, max = 10000};
    air_acc = {value = 380, max = 1000};
    air_friction_x = {value = 0.05, max = 0.3};
    air_friction_y = {value = 0.01, max = 0.3};
    ground_friction = {value =  2.0, max = 20};
    jump_acc = {value = 7666.67, max = 50000}
}


var_system = 
{
    init = function(self)
        fonts = {
	            [12] = love.graphics.newFont(12),
	            [20] = love.graphics.newFont(20),
            }
            love.graphics.setFont(fonts[12])
            -- group defaults
            gui.group.default.size[1] = 150
            gui.group.default.size[2] = 25
            gui.group.default.spacing = 5
    end;
    
    update = function(self)    
    gui.group{grow = "down", function()
         gui.group{grow = "right", function()
			    gui.Label{text = "ground acc", size = {70}}
			    gui.Slider{info = sliders.ground_acc}
			    gui.Label{text = ("Value: %.2f"):format(sliders.ground_acc.value), size = {70}}
		    end}
		
	     gui.group{grow = "right", function()
			    gui.Label{text = "air_acc", size = {70}}
			    gui.Slider{info = sliders.air_acc}
			    gui.Label{text = ("Value: %.2f"):format(sliders.air_acc.value), size = {70}}
		    end}
		
	     gui.group{grow = "right", function()
			    gui.Label{text = "air_friction_x", size = {70}}
			    gui.Slider{info = sliders.air_friction_x}
			    gui.Label{text = ("Value: %.2f"):format(sliders.air_friction_x.value), size = {70}}
		    end}
		    
	     gui.group{grow = "right", function()
			    gui.Label{text = "air_friction_y", size = {70}}
			    gui.Slider{info = sliders.air_friction_y}
			    gui.Label{text = ("Value: %.2f"):format(sliders.air_friction_y.value), size = {70}}
		    end}
		
	     gui.group{grow = "right", function()
			    gui.Label{text = "ground_friction", size = {70}}
			    gui.Slider{info = sliders.ground_friction}
			    gui.Label{text = ("Value: %.2f"):format(sliders.ground_friction.value), size = {70}}
		    end}
		
	     gui.group{grow = "right", function()
			    gui.Label{text = "jump_acc", size = {70}}
			    gui.Slider{info = sliders.jump_acc}
			    gui.Label{text = ("Value: %.2f"):format(sliders.jump_acc.value), size = {70}}
		    end}
	    end}
	    
	    for name, data in pairs(sliders) do
	        vars[name] = data.value
	    end	    
    end
}

return var_system
