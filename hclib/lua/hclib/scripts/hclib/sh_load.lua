
return { 

    ScriptName = "library",
    
    ScriptDescription = [[]], 
    
    ScriptExtraInformations = {},
    
    Scriptindex = "main", // NEVER CHANGE THIS SHHIT
     
    Config = {
        Language = {  
            ["ENG"] = {
        
                ["ManageModules"] = "Manage Modules",
        
                ["Home"] = "Home",

                ["DangerZone"] = "DangerZone",
        
                ["MENU.Information.ifModulesmanage"] = "INFO: Changes will be visible, if you restart the Server or Map!",
        
                ["Configuration"] = "Configuration",
        
                ["s.back"] = "back",
        
                ["CAPS.Comingsoon"] = "COMING SOON",
        
                ["cfg.Language"] = "Language phrases",

                ["maincfg.ChangeLanguage"] = "Change Language",

                ["maincfg.ActviateKey"] = "Open With Keybind",



                ["vgui.binder.pressakey"] = "Press a Key",
        
            },
            ["GER"] = {
            },
        },
        Cfg = {
            Language = "ENG",
            AllowOpenwithKey = true,
            OpenKey = KEY_F8,
            UserGroups = { 
                ["admin"] = {
                    [ "*" ] = true,
                },
            },
            Sql = {
                UseMySQL = false,
    
                HostIP = "",
            
                Username = "",
            
                Password = "",
             
                Databasename = "",
             
                Port = 3306,
            }
        },  
        AccessGroups = {
            [ "HCLIB.FullAccess" ] = true,
            [ "Debugging" ] = true,
        }
    },
     
    ScriptDevDocsentry = {},
    
    
    
    CreateIngameConfig = function( lib, parent )


       local langp = lib.AddBlanKPanel( parent );
            
            langp.ttl = vgui.Create( "DLabel", langp );

            langp.ttl:Dock( LEFT );

            langp.ttl:DockMargin( 4, 0, 0, 3 );

            langp.ttl:SetText( HCLIB:L( "main", "maincfg.ChangeLanguage" ) );

            langp.ttl:SetFont( "HCLib.VGUI.50" );

            langp.ttl:SetTextColor( Color(255,255,255) );

            langp.ttl:SizeToContents();


            langp.changpnl = vgui.Create( "HCLIB.ComboBox", langp );

            langp.changpnl:Dock( RIGHT );

            langp.changpnl:DockMargin( 0,20,8,20 );

            langp.changpnl:SetWide( ScrW() * 0.15    );

            langp.changpnl:SetValue( HCLIB.Config.Cfg[ "main" ].Language )

            for k, v in pairs( HCLIB.SupportetLanguages ) do 

                langp.changpnl:AddChoice( k )

            end;

            langp.changpnl.OnSelect  = function( _, _, index )

                HCLIB.Config.Cfg[ "main" ].Language = tostring( index );

                net.Start( "HCLIB.SetConfig" )
                    
                    HCLIB:WriteCompressedTable( HCLIB.Config );

                    net.WriteString( "main" );

                    net.WriteString( "Config" );

                net.SendToServer();

            end;




            local aopen = lib.AddBlanKPanel( parent );
            
            aopen.ttl = vgui.Create( "DLabel", aopen );

            aopen.ttl:Dock( LEFT );

            aopen.ttl:DockMargin( 4, 0, 0, 3 );

            aopen.ttl:SetText( HCLIB:L( "main", "maincfg.ActviateKey" ) );

            aopen.ttl:SetFont( "HCLib.VGUI.50" );

            aopen.ttl:SetTextColor( Color(255,255,255) );

            aopen.ttl:SizeToContents();

            

            aopen.changpnl = vgui.Create( "HCLIB.Switch", aopen );

            aopen.changpnl:Dock( RIGHT );

            aopen.changpnl:DockMargin( 0, 30, 8, 0 );

            aopen.changpnl:SetText( "" );

            aopen.changpnl:SetChecked( HCLIB.Config.Cfg[ "main" ].AllowOpenwithKey )
    


            aopen.d2 = vgui.Create( "HCLIB.Binder", aopen );

            aopen.d2:Dock( RIGHT );

            aopen.d2:SetFont( "HCLib.VGUI.80" )

            aopen.d2:DockMargin( 0,0,0,0 );

            aopen.d2:SetWide( 60 );

    end,
    
    LoadFiles = function()
    
        if ( SERVER ) then
    
        --    include("hclib/scripts/svwlist/sv_init.lua");
    
        end;
    
    end,
    
    }