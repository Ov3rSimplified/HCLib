
--[[                       
    bbbbbbbb            
    HHHHHHHHH     HHHHHHHHH             CCCCCCCCCCCCC     LLLLLLLLLLL                    iiii       b::::::b            
    H:::::::H     H:::::::H          CCC::::::::::::C     L:::::::::L                   i::::i      b::::::b            
    H:::::::H     H:::::::H        CC:::::::::::::::C     L:::::::::L                    iiii       b::::::b            
    HH::::::H     H::::::HH       C:::::CCCCCCCC::::C     LL:::::::LL                                b:::::b            
        H:::::H     H:::::H        C:::::C       CCCCCC       L:::::L                    iiiiiii       b:::::bbbbbbbbb    
        H:::::H     H:::::H       C:::::C                     L:::::L                    i:::::i       b::::::::::::::bb  
        H::::::HHHHH::::::H       C:::::C                     L:::::L                     i::::i       b::::::::::::::::b 
        H:::::::::::::::::H       C:::::C                     L:::::L                     i::::i       b:::::bbbbb:::::::b
        H:::::::::::::::::H       C:::::C                     L:::::L                     i::::i       b:::::b    b::::::b
        H::::::HHHHH::::::H       C:::::C                     L:::::L                     i::::i       b:::::b     b:::::b
        H:::::H     H:::::H       C:::::C                     L:::::L                     i::::i       b:::::b     b:::::b
        H:::::H     H:::::H        C:::::C       CCCCCC       L:::::L         LLLLLL      i::::i       b:::::b     b:::::b
    HH::::::H     H::::::HH       C:::::CCCCCCCC::::C     LL:::::::LLLLLLLLL:::::L     i::::::i      b:::::bbbbbb::::::b
    H:::::::H     H:::::::H        CC:::::::::::::::C     L::::::::::::::::::::::L     i::::::i      b::::::::::::::::b 
    H:::::::H     H:::::::H          CCC::::::::::::C     L::::::::::::::::::::::L     i::::::i      b:::::::::::::::b  
    HHHHHHHHH     HHHHHHHHH             CCCCCCCCCCCCC     LLLLLLLLLLLLLLLLLLLLLLLL     iiiiiiii      bbbbbbbbbbbbbbbb   

< ---------- (INFORMATIONS) ---------- >
Author: TwinKlee / Ov3rSimplified
THIS IS THE LIBRARY FOR ALL OF HEXAGON CRYPTICS SCRIPTS!!




< ---------- (DONT EDIT ANYTHING OF THE CODE!!!) ---------- >
]]--  

function HCLIB:LerpColor(from, to, time)

	local interpolation_data = {

		current_color = table.Copy(from),

		from = table.Copy(from),

		to = table.Copy(to),

		ceil_r = to.r > from.r,

		ceil_g = to.g > from.g,

		ceil_b = to.b > from.b,

		curtime = SysTime()
	};

    function interpolation_data:DoLerp()

        if ( self.current_color.r == self.to.r and self.current_color.g == self.to.g and self.current_color.b == self.to.b ) then return end;

        local time_fraction = math.min(math.TimeFraction(self.curtime, self.curtime + time, SysTime()), 1);
        
        time_fraction = time_fraction ^ (1.0 - ((time_fraction - 0.5)));

        self.current_color.r = Lerp(time_fraction, self.from.r, self.to.r);

        self.current_color.g = Lerp(time_fraction, self.from.g, self.to.g);

        self.current_color.b = Lerp(time_fraction, self.from.b, self.to.b);

        if (self.ceil_r) then

            self.current_color.r = math.ceil(self.current_color.r);

        else

            self.current_color.r = math.floor(self.current_color.r);

        end;

        if (self.ceil_g) then

            self.current_color.g = math.ceil(self.current_color.g);

        else

            self.current_color.g = math.floor(self.current_color.g);

        end;

        if (self.ceil_b) then

            self.current_color.b = math.ceil(self.current_color.b);

        else

            self.current_color.b = math.floor(self.current_color.b);

        end;

    end;

    function interpolation_data:GetColor()

        return self.current_color;

    end;

    function interpolation_data:SetColor(col)
        
        self.current_color = table.Copy(col);

        self.from = table.Copy(col);

        self.to = table.Copy(col);

        self.curtime = SysTime();

    end;

    function interpolation_data:SetTo(to)

        self.curtime = SysTime();

        self.from = table.Copy(self.current_color);

        self.to = table.Copy(to);

        self.ceil_r = self.to.r > self.from.r;

        self.ceil_g = self.to.g > self.from.g;

        self.ceil_b = self.to.b > self.from.b;

    end;

   return interpolation_data;

end


function HCLIB:Lerp(from, to, time)
    
	local interpolation_data = {

		current_val = from,

		from = from,

		to = to,

		ceil = to > from,

		curtime = SysTime(),
	}

	function interpolation_data:DoLerp()

		if (self.current_val == self.to) then return end;

		local time_fraction = math.min(math.TimeFraction(self.curtime, self.curtime + time, SysTime()), 1);

		time_fraction = time_fraction ^ (1.0 - ((time_fraction - 0.5)));

		self.current_val = Lerp(time_fraction, self.from, self.to);

		if (self.ceil) then

			self.current_val = math.ceil(self.current_val);

		else

			self.current_val = math.floor(self.current_val);

		end;

	end;

	function interpolation_data:GetValue()

		return self.current_val;

	end;

	function interpolation_data:SetValue(val)

		self.current_val = val;

		self.to = val;
        
		self.from = val;

		self.curtime = SysTime();

	end;

	function interpolation_data:SetTo(to)

		self.curtime = SysTime();
		
		self.from = self.current_val;

		self.to = to;

		self.ceil = self.to > self.from;

	end;

	return interpolation_data;
    
end;
