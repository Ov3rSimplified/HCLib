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

        draw.SimpleText( HCLIB:L("main", "ManageModules"), "HCLib.VGUI.HOME.Title", w / 2, h / 2 - 10, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    end;

    self.Scrollmenu = vgui.Create( "DScrollPanel", self );

    self.Scrollmenu:Dock( FILL );

    self.Scrollmenu:DockMargin( 10,10,10,10 );


    local function items()

        for k, v in pairs( HCLIB.FoundedScripts ) do 
            
            if( k == "main" ) then continue end;

            local script = vgui.Create( "DButton", self.Scrollmenu );

            script:Dock( TOP );

            script:DockMargin( 12,5,12,0 )

            script:SetTall( 69 );

            script:SetText( "" )

            script:SetAlpha( 0 ); 

            script:AlphaTo( 255, 0.25, 0 ); 

            script.Paint = function( me, w, h )
                
                draw.RoundedBox( 18, 2, 1, w-2, h - 2, HCLIB.ScriptManaged[k] and Color(0,250,42) or Color(250,0,0) );

                draw.RoundedBox( 15, 0, 0, w, h - 8, BlueSecond );
        
                draw.SimpleText( k, "HCLib.VGUI.HOME.Title", w / 2, h / 2 - 10, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

            end;


            local BoolButton = vgui.Create( "DButton", script );

            BoolButton:Dock( RIGHT ); 

            BoolButton:DockMargin( 5,10,10,20 );

            BoolButton:SetWide( 200 );

            BoolButton:SetText( "" );

            BoolButton.Paint = function( self, w, h) 
                
                draw.RoundedBox( 10, 0, 0, w, h, HCLIB.ScriptManaged[k] and Color(198,29,29) or Color(0,250,42) );

                draw.SimpleText( HCLIB.ScriptManaged[k] and HCLIB:L( "main", "Modules.Disable" ) or HCLIB:L( "main", "Modules.Activate" ) , "HCLib.VGUI.MODULES.edButton", w / 2, h / 2 - 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

            end; 

            BoolButton.DoClick = function(  me ) 

                if HCLIB.ScriptManaged[k] then 

                    HCLIB.ScriptManaged[k] = false;

                    net.Start( "HCLIB.Manageto" );

                        net.WriteString( k )

                        net.WriteBool( false );

                    net.SendToServer();

                else

                    HCLIB.ScriptManaged[k] = true;

                    net.Start( "HCLIB.Manageto" );

                        net.WriteString( k )

                        net.WriteBool( true );

                    net.SendToServer();

                end;


                self.Scrollmenu:Clear();

                items();

            end;

        end;

    end;

    items();

    self.BottomInfo = vgui.Create( "DPanel", self );

    self.BottomInfo:Dock( BOTTOM );

    self.BottomInfo:DockMargin( 10,5,10,20 );
    
    self.BottomInfo:SetTall( 40 );

    self.BottomInfo.Paint = function( me, w, h )
                
        draw.RoundedBox( 18, 1, 1, w-2, h - 2, Color(250,96,0) );

        draw.RoundedBox( 15, 0, 0, w, h - 4, BlueSecond );

        draw.RoundedBox( 125, 0, 0, 40, h-1, Color(250,96,0))

        draw.SimpleText( "!", "HCLib.VGUI.40", 15, h / 2 - 2, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER);

        draw.SimpleText( HCLIB:L("main", "MENU.Information.ifModulesmanage"), "HCLib.VGUI.35", w / 2 - 30, h / 2 - 3, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    end;

end;

vgui.Register("hclib_cfg_modules", PANEL, "DPanel")