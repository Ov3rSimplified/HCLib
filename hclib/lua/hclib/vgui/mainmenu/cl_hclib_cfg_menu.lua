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

local Purplemain = Color( 63, 15, 164, 255);

local sw, sh = ScrW(), ScrH()

function PANEL:Init()
    local selmen = self;

    PANEL.MM = self;

    --[[ < ---- (TOPBar) ---- > ]]--

    self.Topbar = self:Add("DPanel");

    self.Topbar:Dock(TOP);

    self.Topbar:DockMargin(0,0,0,0);

    self.Topbar:SetTall(65);

    self.Topbar.Paint = function (me, w, h )

        draw.RoundedBoxEx( 25, 0, 0, w, h, Purplemain, true, true, false, false ); // TOPMain

    end;

    self.Topbar.DoClick = function()

        paneeeel:Remove()

    end

    --[[ < ---- (CloseButton) ---- > ]]--

    self.Close = vgui.Create("DButton", self.Topbar);

    self.Close:SetFont( "HCLib.VGUI.70" )

    self.Close:SetText( "X" )

    self.Close:Dock(RIGHT);

    self.Close:DockMargin( 5, 5, 5, 6 )

    self.Close:SetWide( sw * 0.04 )

    self.Close.DoClick = function() selmen:Remove() end;

    self.Close.Paint = function( me, w, h )

        local hover_color = white;

        if ( me:IsHovered() ) then
            hover_color = red;
        end;

        me:SetTextColor( hover_color )

    end;

    --[[ < ---- (Minimize) ---- > ]]--

    self.Minimize = vgui.Create("DButton", self.Topbar);

    self.Minimize:SetFont( "HCLib.VGUI.100" )

    self.Minimize:SetText( "-" )

    self.Minimize:Dock(RIGHT);

    self.Minimize:DockMargin( 5, 5, 5, 20 )

    self.Minimize:SetWide( sw * 0.04 )    

    self.Minimize.DoClick = function() if not self.DefineMinimizeFunction() then return else self.DefineMinimizeFunction() end; end;

    self.Minimize.Paint = function( me, w, h )

        local hover_color = white;

        if ( me:IsHovered() ) then
            hover_color = red;
        end;

        me:SetTextColor( hover_color )

    end;

    --[[ < ---- (Title Icon) ---- > ]]--

        self.TitleIcon = vgui.Create( "DButton", self.Topbar );

        self.TitleIcon:Dock(LEFT);
    
        self.TitleIcon:DockMargin( 23, 0, 5, 0 )
    
        self.TitleIcon:SetWide( sw * 0.039 )
    
        self.TitleIcon:SetText( "" )
    
        self.TitleIcon.Count = 0;

        timer.Create("A_BD23342", 1, 1, function()
            self.TitleIcon.Count = 0;
            LocalPlayer():ChatPrint("VERLOREN!")
        end);
        timer.Stop("A_BD23342")

        self.TitleIcon.DoClick = function( me ) 
            /*

            print(me.Count)
            if me.Count == 0 then 
                me.Count = me.Count + 1

                timer.Start("A_BD23342")
                return
            end;
            if me.Count == 1 then
                timer.Stop("A_BD23342")

                me.Count = me.Count + 1

                timer.Start("A_BD23342")
                return
            end;
            if me.Count == 2 then
                timer.Stop("A_BD23342")

                me.Count = me.Count + 1

                timer.Start("A_BD23342")
                return
            end;
            if me.Count == 3 then
                timer.Stop("A_BD23342")

                me.Count = me.Count + 1

                timer.Start("A_BD23342")
                return
            end;
            if me.Count == 4 then
                timer.Stop("A_BD23342")

                me.Count = me.Count + 1

                timer.Start("A_BD23342")
                return
            end;
            if me.Count == 5 then
                timer.Stop("A_BD23342")

                surface.PlaySound("hclib/menu/38chdfb3f23723.wav") 
                self.TitleIcon.Count = 0;
                return
            end;
                

        */
        
        end;
    
        self.TitleIcon.Icon = Material("materials/hclib/icons/icon.png"); 
    
        self.TitleIcon.Paint = function( me, w, h )
    
            surface.SetDrawColor(white);
    
            surface.SetMaterial(me.Icon);
    
            surface.DrawTexturedRect( 0, 0, 72, 72 );
    
        end;


    --[[ < ---- (Title Text) ---- > ]]--

    self.TitleText = vgui.Create("DButton", self.Topbar);

    self.TitleText:Dock(LEFT);

    self.TitleText:DockMargin( 0, 0, 0, 0 )
    
    self.TitleText:SetWide( sw * 0.4 )

    self.TitleText:SetText( "" )

    self.TitleText.Paint = function( me, w, h )

        draw.SimpleText( "Hexagon Cryptics", "HCLib.VGUI.MENU.Title", 0, h/2 - 5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER );

    end;
 
    self:SideBar();

end;

PANEL.SBFS = {}; // Create Functions

function PANEL:SideBar()
    
    self.SelectionMenu = vgui.Create( "DScrollPanel", self );

    self.SelectionMenu:Dock( LEFT );

    self.SelectionMenu:SetWide( 125 );

    self.SelectionMenu.Paint = function( me, w, h )
        
        draw.RoundedBoxEx( 24, 0, 0, w, h, Purplemain, false, false, true, false );

    end;

    self.SBFS.NormalButtonPoints = {
        {
            Name = "Home",
            pnl = {},
            vname = "hclib_cfg_home",
            active = true,
            I = {
                Icon = Material("materials/hclib/icons/house-48.png"),
                PosX = 33,
                PosY = 15,
            },
        },
        {
            Name = "Modules",
            pnl = {}, 
            vname = "hclib_cfg_modules",
            active = true,
            I = {
                Icon = Material("materials/hclib/icons/modules.png"),
                PosX = 29,
                PosY = 13,
            },
        },
        {
            Name = "Config",
            pnl = {},
            vname = "hclib_cfg_config",
            active = true,
            I = {
                Icon = Material("materials/hclib/icons/gear-2-48.png"),
                PosX = 33,
                PosY = 15,
            },
        },
   --[[ {
            Name = "Guide",
            pnl = {},
            vname = "hclib_cfg_home",
            active = false,
            I = {
                Icon = Material("materials/hclib/icons/book-2-48.png"),
                PosX = 33,
                PosY = 15,
            },
        },]]
        {
            Name = "Danger Zone",
            pnl = {},
            vname = "hclib_cfg_dangerzone",
            active = true,
            I = {
                Icon = Material("materials/hclib/icons/danger.png"),
                PosX = 33,
                PosY = 15,
            },
        },
        --[[{
            Name = "Credits",
            pnl = {},
            vname = "hclib_cfg_credits",
            active = false,
            I = {
                Icon = Material("materials/hclib/icons/document-2-48.png"),
                PosX = 33,
                PosY = 15,
            },
        },]]
    };

    self.SBFS:Normal(self.SelectionMenu);

end;

function PANEL.SBFS:Normal(parent)
    
    local mapn = PANEL

    local currentpnl = {}; // active panel

    --[[ < ---- ( First Menu ) ---- > ]]--

    currentpnl = vgui.Create("hclib_cfg_home", PANEL.MM );

    currentpnl:Dock(FILL);

    --[[ < ---- (Create Button) ---- > ]]--

    for k, v in pairs( self.NormalButtonPoints ) do
        
        v.pnl = vgui.Create( "DButton", parent);

        v.pnl:Dock( TOP );

        v.pnl:DockMargin( 5, 5, 5, 0 );

        v.pnl:SetTall( 80 );

        v.pnl:SetText( "" );

        if v.name == "hclib_cfg_home" then 

            v.pnl.SidePanel = self.SelectionMenu;

        end;

        v.pnl.Clicked = false;

        v.pnl.ClickCache = {};


        local color = Color( Purplemain["r"], Purplemain["g"], Purplemain["b"], 20 );

        local trad, speed, speed2 = 360, 4, 12;

        v.pnl.Rad, v.pnl.Alpha, v.pnl.ClickX, v.pnl.ClickY = 0, 0, 0, 0;

        v.pnl.Paint = function( me, w, h )
            
            draw.RoundedBox( 30, 0, 0, w, h, BlueMain );

            surface.DrawCircle( w/2, h/2, 35, Purplemain["r"], Purplemain["g"], Purplemain["b"], 255  );

            // Icon


            surface.SetDrawColor( v.active and white or red );

            surface.SetMaterial( v.I.Icon );    

            surface.DrawTexturedRect( v.I.PosX, v.I.PosY, 48, 48 );

            if ( me:IsHovered() ) then 

                draw.RoundedBox( 30, 0, 0, w, h, Color( Purplemain["r"], Purplemain["g"], Purplemain["b"], 20 ) );

            end;

            if ( me.Alpha >= 1 ) then

                surface.SetDrawColor(Color( Purplemain["r"], Purplemain["g"], Purplemain["b"], 20 ));

                draw.NoTexture();

                draw.DrawCircle( me.ClickX, me.ClickY, me.Rad, color);

                me.Rad = Lerp(FrameTime() * speed, me.Rad, trad || w);

                me.Alpha = Lerp(FrameTime() * speed2, me.Alpha, 0);

            end;

     --       draw.SimpleText( string.Left(v.Name, 1), "HCLib.VGUI.MENU.Minimize", w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
        end;

        function v.pnl:DoClickInternal()

            self.ClickX, self.ClickY = self:CursorPos();

            self.Rad = 0;

            self.Alpha = color["a"];

            if IsValid(currentpnl) then

                currentpnl:AlphaTo( 0,0.25, 0, function() 

                    currentpnl:Remove();

                    currentpnl = vgui.Create(v.vname or "DPanel", PANEL.MM );

                    currentpnl:Dock(FILL);
                    
                end );

            else

                currentpnl = vgui.Create("hclib_cfg_home", PANEL.MM );

                currentpnl:Dock(FILL);

            end;


        end;

    end;

end;

function PANEL.SBFS:Update(newvar)

    PANEL.SelectionMenu:Clear();

    newvar();

end;

function PANEL:DefineMinimizeFunction()

    return false;

end;

function PANEL:Paint( w, h )

    --[[ < ---- (Main) ---- > ]]--
    
    draw.RoundedBox( 25, 0, 0, w, h, Purplemain ); // Underline

    draw.RoundedBox( 25, 0, 0, w, h - 6, BlueMain ); // MainPanel

end; 


vgui.Register( "hclib_cfg_menu", PANEL, "HCLIB.Blank" ); 