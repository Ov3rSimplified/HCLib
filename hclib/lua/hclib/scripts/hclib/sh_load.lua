
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

                ["allanuankba"] = "dld",
        
            },
            ["GER"] = {
            },
        },
        Cfg = {
            Language = "ENG",
            AllowOpenwithKey = KEY_F8,
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

            --langp.changpnl.Paint = nil;

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

    

    end,
    
    LoadFiles = function()
    
        if ( SERVER ) then
    
        --    include("hclib/scripts/svwlist/sv_init.lua");
    
        end;
    
    end,
    
    }