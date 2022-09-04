
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

local BlueMain = Color( 22, 23, 35, 255 );

local BlueSecond = Color( 22, 23, 41, 255 );

local Purplemain = Color( 63, 15, 164, 255);

local white = Color( 255,255,255 )

function PANEL:Init() 

    self.entry = self:Add( "DTextEntry" );

    self.entry:Dock( FILL );

    self.entry:DockMargin( 5,0,5,0 )

    self.entry:SetFont( "HCLib.VGUI.35" );
    
    self.entry:SetPaintBackground( false );

    self.entry:SetTextColor( white );

    self.entry:DrawTextEntryText(Color(255,255,255), Color(255, 30, 255),Color(255,255,255) );

    self.entry.Focused = false;

    self.entry.OnGetFocus = function( me )
        
        me.Focused = true;

    end;

    self.entry.OnLoseFocus = function( me )
        
        me.Focused = false;

    end;

end;

function PANEL:Paint( w, h )

    draw.RoundedBox( 19, 0, 1, w, h - 2,  Purplemain );

    draw.RoundedBox( 15, 2, 4, w - 4, h - 8, BlueSecond );

    if ( self.entry.Focused ) then 

       -- draw.RoundedBox( 0, w / 2 - 180, 1, 100, 10, BlueSecond )
        
    else



    end;

end


vgui.Register("HCLIB.TextEntry", PANEL, "HCLIB.Blank");