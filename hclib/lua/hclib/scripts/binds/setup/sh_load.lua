// Bind Manger by TwinKlee and Hexagon Cryptics Studios

return { 

    ScriptName = "Bind Manager",
    
    ScriptDescription = [[]], 
    
    ScriptExtraInformations = {},
    
    Scriptindex = "bm", // NEVER CHANGE THIS SHHIT

    Version = "4.2.0",

    Downloadshort = "GIT~HCLIB",
     
    Config = {
        Cfg = {
            
            ["DisabledBinds"] = {},

            ["CustomBinds"] = {}, 

            ["BlockedUserCommands"] = {},

            ["EnableCustomUserBinds"] = true,

        },  
        AccessGroups = {}
    },
     
    ScriptDevDocsentry = {},
    

    CreateIngameConfig = function( lib, parent ) 

        local white = Color( 255, 255, 255 );

        local red = Color( 250, 0, 0, 255 );

        local BlueMain = Color( 22, 23, 35, 255 );

        local BlueSecond = Color( 22, 23, 41, 255 );

        local Purplemain = Color( 63, 15, 164, 255);


        local ECUB = lib.AddField( parent, HCLIB:L( "bm", "EnableCustomUserBinds" ), "")

        local changepanel = lib.AddBoolSwitch( ECUB, HCLIB.Config.Cfg[ "bm" ][ "EnableCustomUserBinds" ], function( self )
            
            HCLIB.Config.Cfg[ "bm" ][ "EnableCustomUserBinds" ] = self:GetChecked();

                net.Start( "HCLIB.SetConfig" );
                    
                    HCLIB:WriteCompressedTable( HCLIB.Config );

                    net.WriteString( "bm" );

                    net.WriteString( "Config" );

                net.SendToServer();

        end );



        local CBinds = lib.AddBlanKPanel( parent );

        CBinds:SetTall( 500 );

        CBinds.Top = vgui.Create( "DPanel", CBinds );

        CBinds.Top:Dock( TOP );

        CBinds.Top:SetTall( 70 );

        CBinds.Top.Paint = function( self, w, h )
            
            draw.RoundedBoxEx( 15, 0, 0, w, h, Purplemain, true, true, false, false );

            draw.SimpleText( "Binds", "HCLib.VGUI.40", 10, h / 2, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER );
        
        end;

        CBinds.Add = vgui.Create( "DButton", CBinds.Top );

        CBinds.Add:Dock( RIGHT );

        CBinds.Add:DockMargin( 0, 0, 5, 0 );

        CBinds.Add:SetFont( "HCLib.VGUI.50" );

        CBinds.Add:SetText( "+" );

        CBinds.Add:SetTextColor( white );

        CBinds.Add:SetWide( 40 );

        CBinds.Add.Paint = function( self, w, h )
            
            if ( self:IsHovered() ) then 

                self:SetTextColor( Color( 0, 250 ,8) );

            else

                self:SetTextColor( white );

            end;

        end;


        CBinds.Scroll = vgui.Create( "HCLIB.Scroll", CBinds );

        CBinds.Scroll:Dock( FILL ); 

        local sbar = CBinds.Scroll:GetVBar();

        sbar:SetSize(5,0);

        sbar:SetHideButtons( false );

        function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

        function sbar:Paint( w, h ) return end;

        function sbar.btnUp:Paint( w, h ) return end;

        function sbar.btnDown:Paint( w, h ) return end;



        CBinds.Add.DoClick = function( )
            
            local pop = lib.AddPopUp( HCLIB:L( "bm", "CreateBind" ), function( )
                
            end, 400, 600 )

            pop.Scroll = vgui.Create( "HCLIB.Scroll", pop );

            pop.Scroll:Dock( FILL )

            local sbar = pop.Scroll:GetVBar();

            sbar:SetSize(5,0);

            sbar:SetHideButtons( false );

            function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

            function sbar:Paint( w, h ) return end;

            function sbar.btnUp:Paint( w, h ) return end;

            function sbar.btnDown:Paint( w, h ) return end;


            pop.save = vgui.Create( "DButton", pop );

            pop.save:Dock( BOTTOM );

            pop.save:DockMargin( 2, 5, 2, 2 );

            pop.save:SetText( HCLIB:L( "bm", "Save" ) );

            pop.save:SetFont( "HCLib.VGUI.30" );

            pop.save:SetTextColor( white );

            pop.save:SetTall( 50 );

            pop.save.Paint = function( self, w, h )

                draw.RoundedBoxEx( 19, 0, 0, w, h, self:IsHovered() and Purplemain or BlueSecond, false, false, true, true );

            end;


            pop.BindName = vgui.Create( "HCLIB.TextEntry", pop.Scroll );

            pop.BindName:Dock( TOP );

            pop.BindName:DockMargin( 10, 10, 10, 0 );

            pop.BindName:SetTall( 60 );

            pop.BindName.entry:SetPlaceholderText( HCLIB:L( "bm", "EnterBindTitle" ) );


            pop.IndexName = vgui.Create( "HCLIB.TextEntry", pop.Scroll );

            pop.IndexName:Dock( TOP );

            pop.IndexName:DockMargin( 10, 10, 10, 0 );

            pop.IndexName:SetTall( 60 );

            pop.IndexName:ShortInfo( true );

            pop.IndexName:SetInfoTitle( HCLIB:L( "bm", "QuestionTitleIndex" ) );

            pop.IndexName:SetDescription( HCLIB:L( "bm", "QuestionDescIndex" ) )

            pop.IndexName.entry:SetPlaceholderText( HCLIB:L( "bm", "EnterIndexName" ) );


            pop.Bindmenu = lib.AddBlanKPanel( pop.Scroll );

            pop.Bindmenu:SetTall( 80 );

            pop.Bindmenu.PaintOver = function( self, w, h )
                
                draw.SimpleText( HCLIB:L( "bm", "SetKey" ), "HCLib.VGUI.40", 10, h / 2 - 5, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            end;


            pop.Binder = vgui.Create( "HCLIB.Binder", pop.Bindmenu );

            pop.Binder:Dock( RIGHT );

            pop.Binder:DockMargin( 0, 10, 10, 10 );


            pop.Accessmenu = lib.AddBlanKPanel( pop.Scroll );

            pop.Accessmenu:SetTall( 400 );

            pop.Accessmenu.PaintOver = function( self, w, h )
                
                draw.SimpleText( HCLIB:L( "bm", "Restrict" ), "HCLib.VGUI.27", 10, 20, white, TEXT_ALIGN_LEFT)

            end;

            pop.Accessmenu.Fill = lib.AddBlanKPanel( pop.Accessmenu );

            pop.Accessmenu.Fill:Dock( FILL );

            pop.Accessmenu.Fill:DockMargin( 5, 69, 5, 10 );

            local userg = {};

            pop.Accessmenu.Scroll = vgui.Create( "HCLIB.Scroll", pop.Accessmenu.Fill );

            pop.Accessmenu.Scroll:Dock( FILL )

            pop.Accessmenu.Scroll:DockMargin( 0, 10, 0, 10 )

            local sbar = pop.Accessmenu.Scroll:GetVBar();

            sbar:SetSize(5,0);

            sbar:SetHideButtons( false );

            function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

            function sbar:Paint( w, h ) return end;

            function sbar.btnUp:Paint( w, h ) return end;

            function sbar.btnDown:Paint( w, h ) return end;


            local function items()

                pop.Accessmenu.Scroll:Clear();

                for k,v in pairs( userg ) do 

                    local btn = lib.AddBlanKPanel( pop.Accessmenu.Scroll );

                    btn:SetTall( 50 );

                    btn.PaintOver = function( self, w, h )
                    
                        draw.SimpleText( tostring( k ), "HCLib.VGUI.35", 10, h / 2 - 5, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                    end;

                    local del = vgui.Create( "DButton", btn );

                    del:Dock( RIGHT );

                    del:DockMargin( 0, 0, 5, 4 );

                    del:SetFont( "HCLib.VGUI.30" );

                    del:SetText( "X" );

                    del:SetTextColor( white );

                    del:SetWide( 40 );

                    del.Paint = function( self, w, h )
                        
                        if ( self:IsHovered() ) then 

                            self:SetTextColor( Color( 250, 0 ,0) );

                        else

                            self:SetTextColor( white );

                        end;

                    end;

                    del.DoClick = function( self )
                        
                        userg[ tostring( k ) ] = nil;
                        
                        items()

                    end;

                end;
                
            end;

            items();



            pop.EntryPnl = vgui.Create( "DPanel", pop.Accessmenu );

            pop.EntryPnl:SetPos( 190, 10 );

            pop.EntryPnl:SetSize( 175, 55);

            pop.EntryPnl.Paint = nil;


            pop.AccessEntry = vgui.Create( "HCLIB.TextEntry", pop.EntryPnl );

            pop.AccessEntry:Dock( FILL );

            pop.AccessEntry:ShortInfo( true );

            pop.AccessEntry:SetInfoTitle( HCLIB:L( "bm", "RankHow" ) );

            pop.AccessEntry:SetDescription( HCLIB:L( "bm", "RankHowAnswer" ) )

            pop.AccessEntry.entry:SetPlaceholderText( HCLIB:L( "bm", "RankName" ) );

            pop.AccessEntry.entry:SetFont( "HCLib.VGUI.20" );

            pop.AccessEntry.entry.OnEnter = function( self )
                
                userg[ self:GetText() ] = true;

                items();

                self:SetText( "" );

            end;


            pop.SeletModePanel = lib.AddBlanKPanel( pop.Scroll );

            pop.SeletModePanel:SetTall( 160 );



            pop.SelectMode = vgui.Create( "HCLIB.TextEntry", pop.SeletModePanel );

            pop.SelectMode:Dock( TOP );

            pop.SelectMode:DockMargin( 10, 5, 10, 0 );

            pop.SelectMode:SetTall( 60 );

            pop.SelectMode.entry:SetPlaceholderText( HCLIB:L( "bm", "SelectEsecMode" ) );

            pop.SelectMode.entry:SetFont( "HCLib.VGUI.20" );


            pop.ModeCode = vgui.Create( "HCLIB.TextEntry", pop.SeletModePanel );

            pop.ModeCode:Dock( TOP );

            pop.ModeCode:DockMargin( 10, 10, 10, 0 );

            pop.ModeCode:SetTall( 60 );

            pop.ModeCode.entry:SetPlaceholderText( HCLIB:L( "bm", "Executive" ) );

            pop.ModeCode.entry:SetFont( "HCLib.VGUI.25" );


            pop.save.DoClick = function( self )
                
                // pop.SelectMode.entry
                // pop.ModeCode.entry
                // userg
                // pop.Binder
                // pop.IndexName.entry
                // pop.BindName
 
                //print( pop.IndexName.entry:GetText() )
                //print( pop.BindName.entry:GetText() )
                //PrintTable( userg )
                //print( pop.Binder:GetValue() )
                //print( pop.SelectMode.entry:GetText() ) 
                // print( pop.ModeCode.entry:GetText() )

                HCLIB.Config.Cfg[ "bm" ][ "CustomBinds"][ pop.IndexName.entry:GetText() ] = {
                    NAME = pop.BindName.entry:GetText(),
                    INDEX =  pop.IndexName.entry:GetText(),
                    ACCESS = userg,
                    BINDKEY = pop.Binder:GetValue(),
                    MODE = pop.SelectMode.entry:GetText(),
                    CODE = pop.ModeCode.entry:GetText(),
                };

                net.Start( "HCLIB.SetConfig" );
                    
                    HCLIB:WriteCompressedTable( HCLIB.Config );

                    net.WriteString( "bm" );

                    net.WriteString( "Config" );

                net.SendToServer();

                pop:Remove();

                CBinds.ScrollScrollItems();

            end;

        end;



        function CBinds.ScrollScrollItems()
        
            CBinds.Scroll:Clear();

            for k, v in pairs( HCLIB.Config.Cfg[ "bm" ][ "CustomBinds"] ) do 

                local btn = lib.AddBlanKPanel( CBinds.Scroll );

                btn:SetTall( 80 );

                btn.PaintOver = function( self, w, h )
                
                    draw.SimpleText( tostring( v.NAME ), "HCLib.VGUI.35", 10, h / 2 - 5, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                end;

                local del = vgui.Create( "DButton", btn );

                del:Dock( RIGHT );

                del:DockMargin( 0, 0, 5, 4 );

                del:SetFont( "HCLib.VGUI.30" );

                del:SetText( "X" );

                del:SetTextColor( white );

                del:SetWide( 40 );

                del.Paint = function( self, w, h )
                    
                    if ( self:IsHovered() ) then 

                        self:SetTextColor( Color( 250, 0 ,0) );

                    else

                        self:SetTextColor( white );

                    end;

                end;

                del.DoClick = function( self )
                    
                    HCLIB.Config.Cfg[ "bm" ]["CustomBinds" ][ k ] = nil;

                    net.Start( "HCLIB.SetConfig" );
                        
                        HCLIB:WriteCompressedTable( HCLIB.Config );

                        net.WriteString( "bm" );

                        net.WriteString( "Config" );

                    net.SendToServer();

                    CBinds.ScrollScrollItems();

                end;

                local boolswitch = vgui.Create( "HCLIB.Switch", btn );

                boolswitch:Dock( RIGHT );

                boolswitch:DockMargin( 0, 29, 1, 10 );

                boolswitch:SetText( "" );

                boolswitch:SetChecked( not HCLIB.Config.Cfg[ "bm" ]["DisabledBinds"][ k ] and true or HCLIB.Config.Cfg[ "bm" ]["DisabledBinds"][ k ] and false )
                
                boolswitch.OnChange = function( self )

                    if ( self:GetChecked() ) then 

                        HCLIB.Config.Cfg[ "bm" ]["DisabledBinds"][ k ] = nil;

                    else

                        HCLIB.Config.Cfg[ "bm" ]["DisabledBinds"][ k ] = true;

                    end;
                
                    net.Start( "HCLIB.SetConfig" );
                        
                        HCLIB:WriteCompressedTable( HCLIB.Config );

                        net.WriteString( "bm" );

                        net.WriteString( "Config" );

                    net.SendToServer();

                end;

                local edit = vgui.Create( "DButton", btn );

                edit:Dock( RIGHT );

                edit:DockMargin( 0, 17, 17, 17 );

                edit:SetText( "E" );

                edit:SetFont( "HCLib.VGUI.30" );
                
                edit:SetTextColor( Color( 255, 255, 255) );

                edit:SetWide( 45 );

                edit.Paint = function( self, w, h )


                    draw.RoundedBox( 19, 0, 1, w, h, Purplemain );

                    draw.RoundedBox( 15, 2, 2, w - 4, h - 4, self:IsHovered() and Purplemain or BlueMain );

                end;

                edit.DoClick = function( self )
                    
                    local pop = lib.AddPopUp( HCLIB:L( "bm", "CreateBind" ), function( )
                        
                    end, 400, 600 )

                    pop.Scroll = vgui.Create( "HCLIB.Scroll", pop );

                    pop.Scroll:Dock( FILL )

                    local sbar = pop.Scroll:GetVBar();

                    sbar:SetSize(5,0);

                    sbar:SetHideButtons( false );

                    function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

                    function sbar:Paint( w, h ) return end;

                    function sbar.btnUp:Paint( w, h ) return end;

                    function sbar.btnDown:Paint( w, h ) return end;


                    pop.save = vgui.Create( "DButton", pop );

                    pop.save:Dock( BOTTOM );

                    pop.save:DockMargin( 2, 5, 2, 2 );

                    pop.save:SetText( HCLIB:L( "bm", "Save" ) );

                    pop.save:SetFont( "HCLib.VGUI.30" );

                    pop.save:SetTextColor( white );

                    pop.save:SetTall( 50 );

                    pop.save.Paint = function( self, w, h )

                        draw.RoundedBoxEx( 19, 0, 0, w, h, self:IsHovered() and Purplemain or BlueSecond, false, false, true, true );

                    end;


                    pop.BindName = vgui.Create( "HCLIB.TextEntry", pop.Scroll );

                    pop.BindName:Dock( TOP );

                    pop.BindName:DockMargin( 10, 10, 10, 0 );

                    pop.BindName:SetTall( 60 );

                    pop.BindName.entry:SetPlaceholderText( HCLIB:L( "bm", "EnterBindTitle" ) );

                    pop.BindName.entry:SetText( v.NAME );


                    pop.Bindmenu = lib.AddBlanKPanel( pop.Scroll );

                    pop.Bindmenu:SetTall( 80 );

                    pop.Bindmenu.PaintOver = function( self, w, h )
                        
                        draw.SimpleText( HCLIB:L( "bm", "SetKey" ), "HCLib.VGUI.40", 10, h / 2 - 5, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                    end;


                    pop.Binder = vgui.Create( "HCLIB.Binder", pop.Bindmenu );

                    pop.Binder:Dock( RIGHT );

                    pop.Binder:DockMargin( 0, 10, 10, 10 );

                    pop.Binder:SetValue( v.BINDKEY );


                    pop.Accessmenu = lib.AddBlanKPanel( pop.Scroll );

                    pop.Accessmenu:SetTall( 400 );

                    pop.Accessmenu.PaintOver = function( self, w, h )
                        
                        draw.SimpleText( HCLIB:L( "bm", "Restrict" ), "HCLib.VGUI.27", 10, 20, white, TEXT_ALIGN_LEFT)

                    end;

                    pop.Accessmenu.Fill = lib.AddBlanKPanel( pop.Accessmenu );

                    pop.Accessmenu.Fill:Dock( FILL );

                    pop.Accessmenu.Fill:DockMargin( 5, 69, 5, 10 );

                    local userg = v.ACCESS or {};

                    pop.Accessmenu.Scroll = vgui.Create( "HCLIB.Scroll", pop.Accessmenu.Fill );

                    pop.Accessmenu.Scroll:Dock( FILL )

                    pop.Accessmenu.Scroll:DockMargin( 0, 10, 0, 10 )

                    local sbar = pop.Accessmenu.Scroll:GetVBar();

                    sbar:SetSize(5,0);

                    sbar:SetHideButtons( false );

                    function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

                    function sbar:Paint( w, h ) return end;

                    function sbar.btnUp:Paint( w, h ) return end;

                    function sbar.btnDown:Paint( w, h ) return end;


                    local function items()

                        pop.Accessmenu.Scroll:Clear();

                        for k,v in pairs( userg ) do 

                            local btn = lib.AddBlanKPanel( pop.Accessmenu.Scroll );

                            btn:SetTall( 50 );

                            btn.PaintOver = function( self, w, h )
                            
                                draw.SimpleText( tostring( k ), "HCLib.VGUI.35", 10, h / 2 - 5, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                            end;

                            local del = vgui.Create( "DButton", btn );

                            del:Dock( RIGHT );

                            del:DockMargin( 0, 0, 5, 4 );

                            del:SetFont( "HCLib.VGUI.30" );

                            del:SetText( "X" );

                            del:SetTextColor( white );

                            del:SetWide( 40 );

                            del.Paint = function( self, w, h )
                                
                                if ( self:IsHovered() ) then 

                                    self:SetTextColor( Color( 250, 0 ,0) );

                                else

                                    self:SetTextColor( white );

                                end;

                            end;

                            del.DoClick = function( self )
                                
                                userg[ tostring( k ) ] = nil;
                                
                                items()

                            end;

                        end;
                        
                    end;

                    items();



                    pop.EntryPnl = vgui.Create( "DPanel", pop.Accessmenu );

                    pop.EntryPnl:SetPos( 190, 10 );

                    pop.EntryPnl:SetSize( 175, 55);

                    pop.EntryPnl.Paint = nil;


                    pop.AccessEntry = vgui.Create( "HCLIB.TextEntry", pop.EntryPnl );

                    pop.AccessEntry:Dock( FILL );

                    pop.AccessEntry:ShortInfo( true );

                    pop.AccessEntry:SetInfoTitle( HCLIB:L( "bm", "RankHow" ) );

                    pop.AccessEntry:SetDescription( HCLIB:L( "bm", "RankHowAnswer" ) )

                    pop.AccessEntry.entry:SetPlaceholderText( HCLIB:L( "bm", "RankName" ) );

                    pop.AccessEntry.entry:SetFont( "HCLib.VGUI.20" );

                    pop.AccessEntry.entry.OnEnter = function( self )
                        
                        userg[ self:GetText() ] = true;

                        items();

                        self:SetText( "" );

                    end;


                    pop.SeletModePanel = lib.AddBlanKPanel( pop.Scroll );

                    pop.SeletModePanel:SetTall( 160 );



                    pop.SelectMode = vgui.Create( "HCLIB.TextEntry", pop.SeletModePanel );

                    pop.SelectMode:Dock( TOP );

                    pop.SelectMode:DockMargin( 10, 5, 10, 0 );

                    pop.SelectMode:SetTall( 60 );

                    pop.SelectMode.entry:SetPlaceholderText( HCLIB:L( "bm", "SelectEsecMode" ) );

                    pop.SelectMode.entry:SetFont( "HCLib.VGUI.20" );

                    pop.SelectMode.entry:SetText( v.MODE );


                    pop.ModeCode = vgui.Create( "HCLIB.TextEntry", pop.SeletModePanel );

                    pop.ModeCode:Dock( TOP );

                    pop.ModeCode:DockMargin( 10, 10, 10, 0 );

                    pop.ModeCode:SetTall( 60 );

                    pop.ModeCode.entry:SetPlaceholderText( HCLIB:L( "bm", "Executive" ) );

                    pop.ModeCode.entry:SetFont( "HCLib.VGUI.25" );

                    pop.ModeCode.entry:SetText( v.CODE );



                    pop.save.DoClick = function( self )
                        
                        HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ][ v.INDEX ].NAME = pop.BindName.entry:GetText();

                        HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ][ v.INDEX ].ACCESS = userg or {};
                        
                        HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ][ v.INDEX ].BINDKEY = pop.Binder:GetValue();
                       
                        HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ][ v.INDEX ].MODE = pop.SelectMode.entry:GetText();
                       
                        HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ][ v.INDEX ].CODE = pop.ModeCode.entry:GetText();

                        net.Start( "HCLIB.SetConfig" );
                            
                            HCLIB:WriteCompressedTable( HCLIB.Config );

                            net.WriteString( "bm" );

                            net.WriteString( "Config" );

                        net.SendToServer();

                        pop:Remove();

                        CBinds.ScrollScrollItems();

                    end;

                end;

            end;

        end;

        CBinds.ScrollScrollItems()

    end,
    
    LoadFiles = function()

        HCLIB.Scripts[ "bm" ].Scriptbinds = {};
    
            AddCSLuaFile( "hclib/scripts/binds/sh_api.lua");
            
            include( "hclib/scripts/binds/sh_api.lua");

        if ( SERVER ) then 

            AddCSLuaFile( "hclib/scripts/binds/cl_init.lua");

            AddCSLuaFile( "hclib/scripts/binds/cl_menu.lua");


            include( "hclib/scripts/binds/sv_init.lua");

        end;

        if ( CLIENT ) then 

            HCLIB.Scripts[ "bm" ].DisabledBinds = HCLIB.Scripts[ "bm" ].DisabledBinds or {};

            HCLIB.Scripts[ "bm" ].BindSetting = HCLIB.Scripts[ "bm" ].BindSetting or {};

            HCLIB.Scripts[ "bm" ].ClientBinds = HCLIB.Scripts[ "bm" ].ClientBinds or {};

            include( "hclib/scripts/binds/cl_init.lua");

            include( "hclib/scripts/binds/cl_menu.lua");
            
        end;
    
    end,
    
    }