
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


function PANEL:SetDescription( txt )
    
    self.Description = txt;

end;

function PANEL:SetInfoTitle( txt )
    
    self.Title = txt;

end;


function PANEL:ShortInfo( bool )
    
    if not bool then return end;
    
    self.Info = vgui.Create( "DButton", self )

    self.Info:Dock( RIGHT );

    self.Info:DockMargin( 0, 10, 9, 10 );

    self.Info:SetWide( 40 ); 

    self.Info:SetText( "I" )

    self.Info:SetFont( "HCLib.VGUI.35" );

    self.Info:SetTextColor( white );

    self.Info.trad, self.Info.speed, self.Info.speed2, self.Info.Color  = 100, 4, 20, Color(255, 30, 255, 20);

    self.Info.Rad, self.Info.Alpha, self.Info.ClickX, self.Info.ClickY = 0, 0, 0, 0;

    self.Info.Paint = function( me, w, h )

        draw.RoundedBox( 0, 0, 0, w, h, Purplemain )

        if ( me.Alpha >= 1 ) then

            surface.SetDrawColor( me.Color );

            draw.NoTexture();

            draw.DrawCircle( me.ClickX, me.ClickY, me.Rad, me.Color);

            me.Rad = Lerp(FrameTime() * me.speed, me.Rad, me.trad || w);

            me.Alpha = Lerp(FrameTime() * me.speed2, me.Alpha, 0);

        end;

    end;

    self.Info.DoClick = function( me )

        me.ClickX, me.ClickY = me:CursorPos();

        me.Rad = 0;

        me.Alpha = me.Color["a"];


        self.f = vgui.Create( "DFrame" );

        self.f.btnMaxim:SetVisible( false );

        self.f.btnMinim:SetVisible( false );

        self.f:SetSize( ScrW() * 0.2, ScrH() * 0.2 );

        self.f:Center();
        
        self.f:SetTitle( self.Title or "NOT GIVEN!" );

        self.f:AlphaTo( 255, 0.25, 0 ); 

        self.f:MakePopup();

        self.f:DoModal();

        self.f.btnClose.Paint = function( me, w, h )

            draw.RoundedBox( 10, 0, 0, w, h,  Purplemain );

            draw.SimpleText( "X", "DermaDefault", w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
            
        end;

        self.f.Paint = function( me, w, h )

            draw.RoundedBox( 19, 0, 1, w, h - 2,  Purplemain );

            draw.RoundedBox( 15, 2, 4, w - 4, h - 8, BlueSecond );

        end;


        self.d = vgui.Create( "RichText", self.f );

        self.d:Dock( FILL );

        self.d:AppendText( self.Description or "NOT GIVEN!" )

    end;

end;

local speed = 4.5;

local barStatus = 0; 

function PANEL:Paint( w, h )

    if self.entry.Focused then

        barStatus = math.Clamp(barStatus + speed * FrameTime(), 0, 1);

    else

        barStatus = math.Clamp(barStatus - speed * FrameTime(), 0, 1);

    end

    draw.RoundedBox( 19, 0, 1, w, h - 2,  Purplemain );


    draw.RoundedBox( 19, 0, 1, w * barStatus, h - 2,  Color(233,8,236) );


    draw.RoundedBox( 15, 2, 4, w - 4, h - 8, BlueSecond );


end


vgui.Register("HCLIB.TextEntry", PANEL, "HCLIB.Blank");