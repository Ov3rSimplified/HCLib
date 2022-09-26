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

local PANEL = {};

local white = Color( 255, 255, 255 );

local red = Color( 250, 0, 0, 255 );

local BlueMain = Color( 22, 23, 35, 255 );

local BlueSecond = Color( 22, 23, 41, 255 )

local Purplemain = Color( 63, 15, 164, 255);

function PANEL:Init()

    self:SetAlpha( 0 ); 

    self:AlphaTo( 255, 0.25, 0 ); 

    self.Paint = nil; 


    self.Topbar = vgui.Create( "DPanel", self ); 

    self.Topbar:Dock( TOP ); 

    self.Topbar:DockMargin( 120, 9, 120, 0 ); 

    self.Topbar:SetTall( 60 );

    self.Topbar.Paint = function( me, w, h )
        
        draw.RoundedBox( 19, 0, 1, w, h - 2, Purplemain );

        draw.RoundedBox( 15, 0, 0, w, h - 8, BlueSecond );

        draw.SimpleText( HCLIB:L( "main", "DangerZone" ), "HCLib.VGUI.HOME.Title", w / 2, h / 2 - 10, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    end;

end;

vgui.Register("hclib_cfg_dangerzone", PANEL, "DPanel")