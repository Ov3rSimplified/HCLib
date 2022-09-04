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

local BlueSecond = Color( 22, 23, 41, 255 );

local Purplemain = Color( 63, 15, 164, 255);

local lib = {
    AddField = function( parent, CfgName, Description, AddCfgPart, AddSaveFunction  )

        local panel = vgui.Create( "DPanel", parent ); 

        panel:Dock( TOP ); 

        panel:DockMargin( 10, 9, 10, 0 ); 

        panel:SetTall( 90 );

        local speed = 5;

        local barStatus = 0;  

        panel.Paint = function( me, w, h )

            if barStatus then

                barStatus = math.Clamp(barStatus + speed * FrameTime(), 0, 1)
                
            else

                barStatus = math.Clamp(barStatus - speed * FrameTime(), 0, 1)

            end

                draw.RoundedBox( 19, 0, 1, w * barStatus, h - 2,  Purplemain );

                draw.RoundedBox( 15, 2, 2, w - 4, h - 8, BlueSecond );


                draw.SimpleText( tostring(CfgName), "HCLib.VGUI.50", 10, h / 2 - 5, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        end;
    
        if ( AddCfgPart == "bool.switcher" ) then 

           panel.input = vgui.Create( "HCLIB.Switch", panel );

           panel.input:Dock( RIGHT );

           panel.input:DockMargin( 0, 30, 0, 10 );
           
           panel.input.OnChange = function() end;

        end;

        if ( AddCfgPart == "string.entry" ) then 


            panel.input = vgui.Create( "HCLIB.TextEntry", panel )

            panel.input:Dock( RIGHT );

            panel.input:DockMargin( 0, 10, 50, 10 );

            panel.input:SetWide(  400 );

        end;




        return panel;

    end,
    AddBlanKPanel = function( parent )

        local panel = vgui.Create( "DPanel", parent ); 

        panel:Dock( TOP ); 

        panel:DockMargin( 10, 9, 10, 0 ); 

        panel:SetTall( 90 );
            
        local speed = 5;

        local barStatus = 0;  

        panel.Paint = function( me, w, h )

        if barStatus then

            barStatus = math.Clamp(barStatus + speed * FrameTime(), 0, 1)
            
        else

            barStatus = math.Clamp(barStatus - speed * FrameTime(), 0, 1)

        end

            draw.RoundedBox( 19, 0, 1, w * barStatus, h - 2,  Purplemain );

            draw.RoundedBox( 15, 2, 2, w - 4, h - 8, BlueSecond );
        
        end;

        return panel;

    end
};

function PANEL:Init()

    self:SetAlpha( 0 ); 

    self:AlphaTo( 255, 0.25, 0 );

    self.Paint = nil; 

    
    self.Title = HCLIB:L("main", "Configuration");

    self.Topbar = vgui.Create( "DPanel", self ); 

    self.Topbar:Dock( TOP ); 

    self.Topbar:DockMargin( 120, 9, 120, 0 ); 

    self.Topbar:SetTall( 60 );

    self.Topbar.Paint = function( me, w, h )
        
        draw.RoundedBox( 19, 0, 1, w, h - 2, Purplemain );

        draw.RoundedBox( 15, 0, 0, w, h - 8, BlueSecond );

        draw.SimpleText( tostring(self.Title), "HCLib.VGUI.HOME.Title", w / 2, h / 2 - 10, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

    end;

    self.Scrollmenu = vgui.Create( "DScrollPanel", self );
    
    self.Scrollmenu:Dock( FILL );

        local function scripts()

        for k,v in pairs( HCLIB.ScriptManaged ) do 

            if not HCLIB.ScriptManaged[k] then continue end;

            self.btn = vgui.Create("DButton", self.Scrollmenu );

            self.btn:Dock( TOP );

            self.btn:SetTall( 100 );

            self.btn:Dock( TOP );

            self.btn:DockMargin( 12,5,12,0 );

            self.btn:SetTall( 69 );

            self.btn:SetText( "" );

            self.btn:SetAlpha( 0 ); 

            self.btn:AlphaTo( 255, 0.25, 0 ); 

            self.btn.Paint = function( me, w, h )
                
                me.col = BlueMain;

                if ( me:IsHovered() ) then 
                    me.col = Purplemain;

                end;

                draw.RoundedBox( 19, 0, 1, w, h - 2, Purplemain );

                draw.RoundedBox( 15, 0, 0, w, h - 8, me.col );

                draw.SimpleText(  tostring( HCLIB.ScriptBridge[k].ScriptName ), "HCLib.VGUI.HOME.Title", w / 2, h / 2 - 10, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

            end;

            self.btn.DoClick = function( me )
                
                local poX, posY = me:GetPos();

                me:MoveTo( -1200, posY, 0.4, 0.01, -1, function( me2 )


                    self.Scrollmenu:Clear();

                    self.Topbar:DockMargin( 120, 9, 120, 50 ); 

                    HCLIB.ScriptBridge[k].CreateIngameConfig( lib, self.Scrollmenu );

                    self.Title = k;

                    local bb = vgui.Create( "DButton", self );

                    bb:SetSize( 100, 30 );

                    bb:SetPos( 906, 874);

                    bb:SetText( "← " .. HCLIB:L( "main", "s.back" ) );
                    
                    bb:SetTextColor( white )
                    
                    bb.Paint = function( me, w, h )

                        draw.RoundedBoxEx( 19, 0, 0, w, h, Purplemain, true, false, false, true );

                    end;

                    bb.DoClick = function( me )

                        self.Scrollmenu:Clear();

                        self.Title = HCLIB:L("main", "Configuration");

                        scripts();

                    end;

                    me:Remove();    

                end );

            end;

        end;

    end;

        scripts();

end;

vgui.Register( "hclib_cfg_config", PANEL, "DPanel" ); 