vars = 
{
    player_mass = 10000,
    ground_acc = 2000;
    air_acc = 100;
    air_friction = 20;
    ground_friction = 0.5;
    jump_acc = 10000
}


local sliders   = 
{
    player_mass = {value = 20000},
    ground_acc = {value = 10000};
    air_acc = {value = 500};
    air_friction = {value = 200};
    ground_friction = {value = 5};
    jump_acc = {value = 20000}
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
	    end}
	    
	    for name, data in pairs(sliders) do
	        vars[name] = data.value
	    end	    
    end
}

return var_system
