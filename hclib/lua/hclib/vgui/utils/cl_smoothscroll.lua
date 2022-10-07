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

!! THIS CODE IS NOT ORIGINAL FROM ME !!
!! CREDIITS TO Minbird( https://github.com/Minbird) <3 !!
!! ONLY INTEGRATED IN THE HCLIB API !!

< ---------- (DONT EDIT ANYTHING OF THE CODE!!!) ---------- > ]]--  

local length = 0.5; -- animation length.

local ease = 0.25; -- easing animation IN and OUT.

local amount = 30; -- scroll amount.

local function sign( num )
    
    return num > 0;

end;

local function getBiggerPos( signOld, signNew, old, new )

    if signOld != signNew then return new end;

    if signNew then

        return math.max(old, new);

    else
        
        return math.min(old, new);

    end;

end;

local dermaCtrs = vgui.GetControlTable( "HCLIB.DVScroll" );

local tScroll = 0;

local newerT = 0;

function dermaCtrs:AddScroll( dlta )

    self.Old_Pos = nil;

    self.Old_Sign = nil;

    local OldScroll = self:GetScroll();

    dlta = dlta * amount;
    
    local anim = self:NewAnimation( length, 0, ease );

    anim.StartPos = OldScroll;

    anim.TargetPos = OldScroll + dlta + tScroll;

    tScroll = tScroll + dlta;

    local ctime = RealTime(); -- does not work correctly with CurTime, when in single player game and in game menu (then CurTime get stuck). I think RealTime is better.
    
    local doing_scroll = true;

    newerT = ctime;
    
    anim.Think = function( anim, pnl, fraction )

        local nowpos = Lerp( fraction, anim.StartPos, anim.TargetPos );

        if ctime == newerT then

            self:SetScroll( getBiggerPos( self.Old_Sign, sign(dlta), self.Old_Pos, nowpos ) );

            tScroll = tScroll - (tScroll * fraction);
            
        end;

        if doing_scroll then -- it must be here. if not, sometimes scroll get bounce.

            self.Old_Sign = sign(dlta);

            self.Old_Pos = nowpos;

        end;

        if ctime != newerT then doing_scroll = false end;

    end;

    return math.Clamp( self:GetScroll() + tScroll, 0, self.CanvasSize ) != self:GetScroll();

end;

derma.DefineControl( "HCLIB.DVScroll", "Smooth Scrollbar", dermaCtrs, "Panel" )

