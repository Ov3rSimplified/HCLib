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
    AddField = function( parent, CfgName, Description )

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

        return panel;

    end,

    AddTextEntry = function( panel, setvalue, placeholer, ondesc, desc, savefunc )
    
        panel.input = vgui.Create( "HCLIB.TextEntry", panel )

        panel.input:Dock( RIGHT );

        panel.input:DockMargin( 0, 10, 10, 10 );

        panel.input:SetWide(  400 );

        panel.input.entry:SetText( tostring( setvalue ) );

        panel.input:ShortInfo( ondesc or false );

        panel.input.entry:SetPlaceholderText( tostring( placeholer ) );

        panel.input.entry.OnEnter = savefunc and savefunc or nil;

        return panel.input;
    end,

    AddDropDown = function( panel, items, setvalue, savefunc )

        panel.input = vgui.Create( "HCLIB.ComboBox", panel );

        panel.input:Dock( RIGHT );

        panel.input:DockMargin( 0,20,8,20 );

        panel.input:SetWide( ScrW() * 0.15 );

        panel.input:SetValue( setvalue and setvalue or "" )

        for k, v in pairs( items ) do 

            panel.input:AddChoice( k, v )

        end;

        panel.input.OnSelect = savefunc;
        
        return panel.input;

    end,

    AddBoolSwitch = function( panel, setvalue, savefunc )
        
        panel.input = vgui.Create( "HCLIB.Switch", panel );

        panel.input:Dock( RIGHT );

        panel.input:DockMargin( 0, 33, 20, 10 );

        panel.input:SetText( "" );

        panel.input:SetChecked( setvalue and setvalue or false )
        
        panel.input.OnChange = savefunc and savefunc or nil;

        return panel.Input;

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

    self.Scrollmenu = vgui.Create( "HCLIB.Scroll", self );
    
    self.Scrollmenu:Dock( FILL );
    
    self.Scrollmenu:DockMargin( 0, 0, 0, 40 );

    local sbar = self.Scrollmenu:GetVBar();

    sbar:SetSize(5  ,0);

    sbar:SetHideButtons( false );

    function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

    function sbar:Paint( w, h ) return end;

    function sbar.btnUp:Paint( w, h ) return end;

    function sbar.btnDown:Paint( w, h ) return end;


        local function scripts()

            self.lang = vgui.Create("DButton", self.Scrollmenu );

            self.lang:Dock( TOP );

            self.lang:SetTall( 100 );

            self.lang:Dock( TOP );

            self.lang:DockMargin( 12,5,12,0 );

            self.lang:SetTall( 69 );

            self.lang:SetText( "" );

            self.lang:SetAlpha( 0 ); 

            self.lang:AlphaTo( 255, 0.25, 0 ); 

            self.lang.Paint = function( me, w, h )
                
                me.col = BlueMain;

                if ( me:IsHovered() ) then 

                    me.col = Purplemain;

                end;

                draw.RoundedBox( 19, 0, 1, w, h - 2, Purplemain );

                draw.RoundedBox( 15, 0, 0, w, h - 8, me.col );

                draw.SimpleText(  HCLIB:L("main", "cfg.Language"), "HCLib.VGUI.HOME.Title", w / 2, h / 2 - 10, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

            end;

            self.lang.DoClick = function( me )
                
                local poX, posY = me:GetPos();

                me:MoveTo( -1200, posY, 0.4, 0.01, -1, function( me2 )


                    self.Scrollmenu:Clear();

                    self.Topbar:DockMargin( 120, 9, 120, 50 ); 

                    self.Title = "Language";

                    local current = 1;

                    local lpacks = {};

                    for name, _ in pairs( HCLIB.Config.Language ) do 

                        table.insert( lpacks, name )

                    end;

                    local ser = vgui.Create( "HCLIB.TextEntry", self )
                        
                    ser:SetSize( 100, 30 );

                    ser:SetPos( 5, 870 );

                    ser.entry:SetFont( "HCLib.VGUI.20" );

                    ser.entry:SetPlaceholderText( HCLIB:L( "main", "search" ) );


                    local function drawp()

                        self.Scrollmenu:Clear();

                        self.Title = HCLIB:L( "main", "Language" ) .. " - " .. lpacks[ current ]

                        local items = {};

                        ----------------------[ main vgui ]


                        if table.IsEmpty( HCLIB.Config.Language[ lpacks[ current ] ][ HCLIB.Config.Cfg[ "main" ].Language ] ) then
                            
                            local panel = vgui.Create( "DPanel", self.Scrollmenu ); 

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

                                    

                                    draw.SimpleText( HCLIB:L( "main", "NoDataFound" ), "HCLib.VGUI.50", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                
                            end;

                            return;

                        end;

                        for k, v in pairs( HCLIB.Config.Language[ lpacks[ current ] ][ HCLIB.Config.Cfg[ "main" ].Language ] ) do 

                            local panel = vgui.Create( "DPanel", self.Scrollmenu ); 

                            panel:Dock( TOP ); 
                    
                            panel:DockMargin( 10, 9, 10, 0 ); 
                    
                            panel:SetTall( 90 );

                            panel.txt = k;
                            
                            table.insert( items, panel );
                                
                            local speed = 5;
                    
                            local barStatus = 0;  

                            local ktxt = string.len( k );

                            local font = "HCLib.VGUI.50";

                            panel.Paint = function( me, w, h )
                    
                                if barStatus then
                        
                                    barStatus = math.Clamp(barStatus + speed * FrameTime(), 0, 1)
                                    
                                else
                        
                                    barStatus = math.Clamp(barStatus - speed * FrameTime(), 0, 1)
                        
                                end
                        
                                    draw.RoundedBox( 19, 0, 1, w * barStatus, h - 2,  Purplemain );
                        
                                    draw.RoundedBox( 15, 2, 2, w - 4, h - 8, BlueSecond );

                                    if ( ktxt >= 30 ) then 

                                        font = "HCLib.VGUI.30"

                                    end;
                                    

                                    draw.SimpleText( tostring( k ), font, 10, h / 2 - 5, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                
                            end;

                            
                            local entry = vgui.Create( "HCLIB.TextEntry", panel )

                            entry:Dock( RIGHT );

                            entry:DockMargin( 0, 10, 10, 10 );

                            entry:SetWide( 400 );
                            
                            entry.entry:SetText( tostring( v ) )

                            entry:ShortInfo( false );

                            entry.entry.OnEnter = function( self )

                                HCLIB.Config.Language[ lpacks[ current ] ][ HCLIB.Config.Cfg[ "main" ].Language ][ k ] = entry.entry:GetValue();

                                net.Start( "HCLIB.SetConfig" )
                                    
                                    HCLIB:WriteCompressedTable( HCLIB.Config );
                
                                    net.WriteString( lpacks[ current ] );
                
                                    net.WriteString( "Language" );
                
                                net.SendToServer();

                                
                            end;




                            
                        end;

                        function ser.entry:OnChange()
                            
                            local search_text =  ser.entry:GetText():lower();
                            
                            if (#search_text == 0) then

                                for _,v in pairs(items) do

                                    v:SetTall(90);      

                                end;

                            else

                                for _,v in pairs(items) do

                                    if ( v.txt:lower():find( search_text, 1, true ) ) then

                                        v:SetTall(90);

                                    else

                                        v:SetTall(0);

                                    end;

                                end;

                            end;

                        end;

                    end;

                    drawp()

                    local bottom = vgui.Create( "DPanel", self );

                    bottom:SetSize( 500, 50 );

                    bottom:SetPos( 240, 855);

                    bottom.Paint = function( me, w, h)
                        
                        draw.RoundedBoxEx( 19, 0, 0, w, h, Purplemain, true, true, false, false );

                        draw.SimpleText(  current .. "/" .. table.Count( lpacks ), "HCLib.VGUI.40", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

                    end;

                    bottom.Left = vgui.Create( "DButton", bottom );
                    
                    bottom.Left:Dock( LEFT );

                    bottom.Left:DockMargin( 8, 5, 5, 5 );

                    bottom.Left:SetWide( 100 )

                    bottom.Left:SetText( "<--" )

                    bottom.Left:SetTextColor( white )

                    bottom.Left.Paint = function( me, w, h )

                        draw.RoundedBoxEx( 19, 0, 0, w, h, BlueMain, true, false, true, false );
                        
                    end;
                    
                    bottom.Left.DoClick = function()

                        if current == 1 then 

                            current = table.Count( lpacks );

                            drawp();
                        
                        else

                            current = current - 1;

                            drawp();

                        end;

                    end;

                    bottom.Right = vgui.Create( "DButton", bottom );
                    
                    bottom.Right:Dock( RIGHT );

                    bottom.Right:DockMargin( 8, 5, 5, 5 );

                    bottom.Right:SetWide( 100 )

                    bottom.Right:SetText( "-->" )

                    bottom.Right:SetTextColor( white )

                    bottom.Right.Paint = function( me, w, h )

                        draw.RoundedBoxEx( 19, 0, 0, w, h, BlueMain, false, true, false, true );
                        
                    end;

                    bottom.Right.DoClick = function()

                        if current >= table.Count( lpacks ) then 

                            current = 1; 

                            drawp();

                        else

                            current = current + 1;

                            drawp();

                        end;
                        
                    end;

                    local bb = vgui.Create( "DButton", self );

                    bb:SetSize( 100, 30 );

                    bb:SetPos( 906, 874);

                    bb:SetText( "← " .. HCLIB:L( "main", "s.back" ) );
                    
                    bb:SetTextColor( white )
                    
                    bb.Paint  = function( me, w, h )

                        draw.RoundedBoxEx( 19, 0, 0, w, h, Purplemain, true, false, false, true );

                    end;

                    bb.DoClick = function( me )

                        self.Scrollmenu:Clear();

                        bottom:Remove();

                        me:Remove();

                        ser:Remove();

                        self.Title = HCLIB:L("main", "Configuration");

                        scripts();

                    end;

                    me:Remove();    

                end );
                

            end;

            for k,v in pairs( HCLIB.ScriptManaged ) do 

                    if not HCLIB.FoundedScripts[k] then continue end;

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
                            
                            bb.Paint  = function( me, w, h )

                                draw.RoundedBoxEx( 19, 0, 0, w, h, Purplemain, true, false, false, true );

                            end;

                            bb.DoClick = function( me )

                                self.Scrollmenu:Clear();

                                me:Remove();

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