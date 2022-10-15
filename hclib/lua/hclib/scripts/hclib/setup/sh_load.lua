
return { 

    ScriptName = "Main",
    
    ScriptDescription = [[]], 
    
    ScriptExtraInformations = {},
    
    Scriptindex = "main", // NEVER CHANGE THIS SHHIT

    Version = "4.2.0",

    Downloadshort = "GIT",
     
    Config = {
        Language = {},
        Cfg = {
            Language = "ENG",
            AllowOpenwithKey = true,
            OpenKey = KEY_F8,
            UserGroups = { 
                ["admin"] = {
                    [ "*" ] = true,
                },
            },
        },  
        AccessGroups = {
            [ "HCLIB.FullAccess" ] = true,
            [ "HCLIB.ScriptEdit" ] = true,
            [ "HCLIB.SQLEdit" ] = true,
            [ "HCLIB.Mainedit" ] = true,
            [ "Debugging" ] = true,
        }
    },
     
    ScriptDevDocsentry = {},
    
    
    
    CreateIngameConfig = function( lib, parent )

        local white = Color( 255, 255, 255 );

        local black = Color( 0, 0, 0, 255 );

        local BlueSecond = Color( 22, 23, 41, 255 );

        local Purplemain = Color( 63, 15, 164, 255);

        ///////////////////////////////////
        ///////      LANGUAGE       ///////
        ///////////////////////////////////

        local langp = lib.AddBlanKPanel( parent ); // CREATE PANEL
            
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

        ///////////////////////////////////
        ///////       KEYBIND       ///////
        ///////////////////////////////////

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

            aopen.changpnl:DockMargin( 0, 33, 8, 0 );

            aopen.changpnl:SetText( "" );

            aopen.changpnl:SetChecked( HCLIB.Config.Cfg[ "main" ].AllowOpenwithKey )

            aopen.changpnl.OnChange = function( self )

                HCLIB.Config.Cfg[ "main" ].AllowOpenwithKey = tobool( self:GetChecked() );

                net.Start( "HCLIB.SetConfig" );
                    
                    HCLIB:WriteCompressedTable( HCLIB.Config );

                    net.WriteString( "main" );

                    net.WriteString( "Config" );

                net.SendToServer();

            end;

            function aopen.changpnl:Think()
                
                aopen.d2:SetDisabled( self:GetChecked() == true and false or self:GetChecked() == false and true  );

            end;
    
            aopen.d2 = vgui.Create( "HCLIB.Binder", aopen );

            aopen.d2:Dock( RIGHT );

            aopen.d2:SetFont( "HCLib.VGUI.80" )

            aopen.d2:DockMargin( 0, 6, 40, 9 );

            aopen.d2:SetWide( 100 );

            aopen.d2:SetValue( HCLIB.Config.Cfg[ "main" ].OpenKey );

            aopen.d2:SetDisabled( aopen.changpnl:GetChecked() == true and false or aopen.changpnl:GetChecked() == false and true );

            aopen.d2.OnChange = function( self )
                
                HCLIB.Config.Cfg[ "main" ].OpenKey = self:GetValue();

            end;

            
        ///////////////////////////////////
        ///////     SQL CONNECT     ///////
        ///////////////////////////////////

        net.Start( "HCLIB.RequestSQLSettings" );

        net.SendToServer();

        net.Receive( "HCLIB.RequestSQLSettings", function( )

            local sqlt = HCLIB:ReadCompressedTable();

            local sqlp = lib.AddBlanKPanel( parent );

                sqlp:SetTall( 655 );

            sqlp.ttl = vgui.Create( "DLabel", sqlp );
            
            sqlp.ttl:SetPos( 5, 5 );

            sqlp.ttl:SetText( HCLIB:L( "main", "maincfg.MySQL") );

            sqlp.ttl:SetFont( "HCLib.VGUI.50" );

            sqlp.ttl:SizeToContents();


            sqlp.spcer = vgui.Create( "DPanel", sqlp );

            sqlp.spcer:Dock( TOP );

            sqlp.spcer:SetTall( 50 );

            sqlp.spcer.Paint = nil;


            sqlp.use = lib.AddBlanKPanel( sqlp );
    
            sqlp.use.ttl = vgui.Create( "DLabel", sqlp.use );

            sqlp.use.ttl:Dock( LEFT );

            sqlp.use.ttl:DockMargin( 6, 0, 0, 3 );

            sqlp.use.ttl:SetText( HCLIB:L( "main", "maincfg.MySQL.Use" ) );

            sqlp.use.ttl:SetFont( "HCLib.VGUI.50" );

            sqlp.use.ttl:SetTextColor( Color(255,255,255) );

            sqlp.use.ttl:SizeToContents();

            
            sqlp.use.switch = vgui.Create( "HCLIB.Switch", sqlp.use );

            sqlp.use.switch:Dock( RIGHT );

            sqlp.use.switch:DockMargin( 0, 33, 8, 0 );

            sqlp.use.switch:SetText( "" );

            sqlp.use.switch:SetChecked( sqlt.use )

            sqlp.use.switch.OnChange = function( self )
                
               sqlt.use = tobool( self:GetChecked() );

               net.Start( "HCLIB.SaveSQLSettings" );

                    HCLIB:WriteCompressedTable( sqlt );

                net.SendToServer();

            end;

            
            sqlp.Ip = lib.AddField( sqlp, HCLIB:L( "main", "maincfg.MySQL.IP" ), "" )
            
            sqlp.Ip.input = lib.AddTextEntry( sqlp.Ip, sqlt.IP, HCLIB:L( "main", "maincfg.MySQL.IP" ), false, nil, function( self )

                sqlt.IP = self:GetText();

               net.Start( "HCLIB.SaveSQLSettings" );

                    HCLIB:WriteCompressedTable( sqlt );

                net.SendToServer();

            end );

            sqlp.Ip.input.entry:SetNumeric( true );

            sqlp.Ip.input.entry.PaintOver = function( self, w, h )

                if ( not self:IsHovered() ) then 

                    draw.RoundedBox ( 15, 0, 2, w , h - 2, black );

                    draw.SimpleText( "Spoiler", "DermaDefault", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                end;
                
            end;

            sqlp.dbname = lib.AddField( sqlp, HCLIB:L( "main", "maincfg.MySQL.DBName" ), "" )
            
            sqlp.dbname.input = lib.AddTextEntry( sqlp.dbname, sqlt.Databasename, HCLIB:L( "main", "maincfg.MySQL.DBName" ), false, nil, function( self )

              sqlt.Databasename = self:GetText();

               net.Start( "HCLIB.SaveSQLSettings" );

                    HCLIB:WriteCompressedTable( sqlt );

                net.SendToServer();

            end );

            sqlp.dbname.input.entry.PaintOver = function( self, w, h )

                if ( not self:IsHovered() ) then 

                    draw.RoundedBox ( 15, 0, 2, w , h - 2, black );

                    draw.SimpleText( "Spoiler", "DermaDefault", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                end;
                
            end;


            sqlp.username = lib.AddField( sqlp, HCLIB:L( "main", "maincfg.MySQL.Username" ), "" )
            
            sqlp.username.input = lib.AddTextEntry( sqlp.username, sqlt.UserName, HCLIB:L( "main", "maincfg.MySQL.Username" ), false, nil, function( self )

              sqlt.UserName = self:GetText();

               net.Start( "HCLIB.SaveSQLSettings" );

                    HCLIB:WriteCompressedTable( sqlt );

                net.SendToServer();

            end );

            sqlp.username.input.entry.PaintOver = function( self, w, h )

                if ( not self:IsHovered() ) then 

                    draw.RoundedBox ( 15, 0, 2, w , h - 2, black );

                    draw.SimpleText( "Spoiler", "DermaDefault", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                end;
                
            end;

            sqlp.password = lib.AddField( sqlp, HCLIB:L( "main", "maincfg.MySQL.Password" ), "" )
            
            sqlp.password.input = lib.AddTextEntry( sqlp.password, sqlt.Password, HCLIB:L( "main", "maincfg.MySQL.Password" ), false, nil, function( self )

              sqlt.Password = self:GetText();

               net.Start( "HCLIB.SaveSQLSettings" );

                    HCLIB:WriteCompressedTable( sqlt );

                net.SendToServer();

            end );

            sqlp.password.input.entry.PaintOver = function( self, w, h )

                if ( not self:IsHovered() ) then 

                    draw.RoundedBox ( 15, 0, 2, w , h - 2, black );

                    draw.SimpleText( "Spoiler", "DermaDefault", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                end;
                
            end;

            sqlp.port = lib.AddField( sqlp, HCLIB:L( "main", "maincfg.MySQL.Port" ), "" )
            
            sqlp.port.input = lib.AddTextEntry( sqlp.port, sqlt.Port, HCLIB:L( "main", "maincfg.MySQL.Port" ), false, nil, function( self )

              sqlt.Port = self:GetValue();

               net.Start( "HCLIB.SaveSQLSettings" );

                    HCLIB:WriteCompressedTable( sqlt );

                net.SendToServer();

            end );

            sqlp.port.input.entry:SetNumeric( true );

            sqlp.port.input.entry.PaintOver = function( self, w, h )

                if ( not self:IsHovered() ) then 

                    draw.RoundedBox ( 15, 0, 2, w , h - 2, black );

                    draw.SimpleText( "Spoiler", "DermaDefault", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                end;
                
            end;

        end );

        ///////////////////////////////////
        ///////    Rank Settings    ///////
        ///////////////////////////////////


        local ranksort;
        local rankname;
        local ranks = lib.AddBlanKPanel( parent );

            ranks:SetTall( 600 );

        ranks.ttl = vgui.Create( "DLabel", ranks );
        
        ranks.ttl:SetPos( 5, 5 );

        ranks.ttl:SetText( HCLIB:L( "main", "maincfg.Ranks") );

        ranks.ttl:SetFont( "HCLib.VGUI.50" );

        ranks.ttl:SizeToContents();


        ranks.selectside = vgui.Create( "DPanel", ranks );

        ranks.selectside:SetWide( 450 );

        ranks.selectside:Dock( LEFT );

        ranks.selectside:DockMargin( 10, 60, 0, 10 );

        ranks.selectside.Paint = function( self, w, h )
            
            draw.RoundedBox( 19, 0, 1, w, h - 2,  Purplemain );

            draw.RoundedBox( 15, 2, 2, w - 4, h - 8, BlueSecond );

        end;

        ranks.selectside.Top = vgui.Create( "DPanel", ranks.selectside );

        ranks.selectside.Top:Dock( TOP );

        ranks.selectside.Top:DockMargin( 0, 0, 0, 0 );

        ranks.selectside.Top:SetTall( 50 );

        ranks.selectside.Top:SetText( "" );


        ranks.selectside.Top.Paint = function( self, w, h )
            
            draw.RoundedBoxEx( 19, 0, 1, w, h,  Purplemain, true, true, false, false );

            draw.SimpleText( HCLIB:L( "main", "maincfg.Ranks.Usergroups" ), "HCLib.VGUI.30", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

        end;

        ranks.selectside.Add = vgui.Create( "DButton", ranks.selectside.Top );

        ranks.selectside.Add:Dock( RIGHT );

        ranks.selectside.Add:DockMargin( 0, 0, 0, 0 );

        ranks.selectside.Add:SetWide( 40 );

        ranks.selectside.Add:SetText( "+" );

        ranks.selectside.Add:SetFont( "HCLib.VGUI.35" );

        ranks.selectside.Add:SetTextColor( white );

        ranks.selectside.Add.Paint = function( self, w, h )

            draw.RoundedBoxEx( 19, 0, 1, w, h,  Color( 18, 227, 77), false, true, false, false );
            
        end;

        ranks.selectside.Scroll = vgui.Create( "HCLIB.Scroll", ranks.selectside );

        ranks.selectside.Scroll:Dock( FILL );

        ranks.selectside.Scroll:DockMargin( 0, 5, 0, 0 );

        function ranks:Groups()
            
            ranks.selectside.Scroll:Clear();

            local Clicked;

            for k, v in pairs( HCLIB.Admin.PermissionGroups ) do 

                ranks.selectside.Button = vgui.Create( "DButton", ranks.selectside.Scroll );

                ranks.selectside.Button:Dock( TOP );

                ranks.selectside.Button:DockMargin( 5, 0, 5, 0 );

                ranks.selectside.Button:SetTall( 70 );

                ranks.selectside.Button:SetText( k );
                
                ranks.selectside.Button:SetToolTip( HCLIB:L( "main", "maincfg.Ranks.selectside.Info" ) );

                ranks.selectside.Button:SetFont( "HCLib.VGUI.35" );

                ranks.selectside.Button:SetTextColor( white );

                ranks.selectside.Button.Paint = function( self, w, h )
                    
                    draw.RoundedBox( 0, 0, 0, w, h, BlueSecond );

                    if ( Clicked == self ) then 

                        draw.RoundedBox( 0, 0, 0, w, h, Purplemain );

                    end;

                end;

                ranks.selectside.Button.DoClick = function( self )
                    
                    Clicked = self;

                    rankname = k;

                    ranks:GetPermissionss( k )
                    
                end;

                ranks.selectside.Button.DoRightClick = function( self )
                
                    local dmen = DermaMenu()

                    dmen:AddOption( HCLIB:L( "main", "maincfg.Delete" ), function()
                        
                        HCLIB.Config.Cfg[ "main" ][ "UserGroups" ][ tostring( k ) ] = nil;
                

                        net.Start( "HCLIB.SetConfig" ); 
                        
                            HCLIB:WriteCompressedTable( HCLIB.Config );

                            net.WriteString( "main" );

                            net.WriteString( "Config" );

                        net.SendToServer();
                                
                        net.Start( "HCLIB.RequestSynch" )
                        
                        net.SendToServer();
                            
                        net.Receive( "HCLIB.RequestSynch", function( )
                            
                            ranks:Groups();

                        end );

                    end )

                    dmen:Open()

                end;

            end;

        end;

        ranks.selectside.Add.DoClick = function( self )

            local setedrank = "";

            local Setedrankpermission = {};
            

            if IsValid( pop ) then 

                pop:Remove();
           
            else

                local pop = lib.AddPopUp( HCLIB:L( "main", "maincfg.Ranks.AddUsergroups" ), nil, 400, 600  )

                pop.input = vgui.Create( "HCLIB.TextEntry", pop )

                pop.input:Dock( TOP );

                pop.input:DockMargin( 10, 10, 10, 0 );

                pop.input:SetTall( 60 );

                pop.input:ShortInfo( true );

                pop.input:SetInfoTitle( HCLIB:L( "main", "maincfg.Ranks.Usergroupname.InfoTitle" ) );

                pop.input:SetDescription( HCLIB:L( "main", "maincfg.Ranks.Usergroupname.Info" ) )

                pop.input.entry:SetPlaceholderText( HCLIB:L( "main", "maincfg.Ranks.EnterUsergroupname" ) );

                pop.input.entry.OnValueChange = function( self )
                    
                    setedrank = tostring( self:GetText() );
                    
                end;


                pop.Permissions = vgui.Create( "DScrollPanel", pop );

                pop.Permissions:Dock( FILL );

                pop.Permissions:DockMargin( 0, 0, 0, 0 );

                for k, v in pairs( HCLIB.FoundedScripts ) do 

                    if not HCLIB.Admin.Permissions[ k ] then continue end;

                    if table.IsEmpty( HCLIB.Admin.Permissions[ k ] ) then continue end;

                    pop.cat = vgui.Create( "DCollapsibleCategory", pop.Permissions )
                    
                    pop.cat:Dock( TOP );

                    pop.cat:DockMargin( 5, 5, 5, 0 );

                    pop.cat:SetHeaderHeight( 45 );

                    pop.cat:SetLabel( "" );
                    
                    pop.cat.Paint = function( self, w, h) 
    
                        draw.RoundedBox( 19, 0, 0, w, h,  Purplemain );

                        draw.SimpleText( tostring( k ), "HCLib.VGUI.30", w / 2, 5.4, white, TEXT_ALIGN_CENTER );

                    end;

                    for key, value in pairs( HCLIB.Admin.Permissions[ k ] ) do 

                        pop.btn = vgui.Create( "DButton", pop.cat );

                        pop.btn:Dock( TOP );

                        pop.btn:DockMargin( 4, 3, 4, 0 );

                        pop.btn:SetTall( 39 );

                        pop.btn:SetText( key )

                        pop.btn:SetTextColor( white );

                        pop.btn.Clicked = false;

                        pop.btn.Paint = function( self, w, h )

                            draw.RoundedBox( 19, 0, 0, w, h, self.Clicked and Color( 20, 75, 14) or BlueSecond );

                        end;
                        
                        pop.btn.DoClick = function( self )

                            self.Clicked =  self.Clicked and false or not self.Clicked and true;
                            
                            if ( self.Clicked ) then 

                                Setedrankpermission[ key ] = true;

                            else

                                Setedrankpermission[ key ] = nil;

                            end;

                        end;


                    end;

                    pop.spacer = vgui.Create( "DPanel", pop.cat );

                    pop.spacer:Dock( TOP );

                    pop.spacer:SetTall( 10 );

                    pop.spacer.Paint = nil;



                end;

                
                pop.save = vgui.Create( "DButton", pop );

                pop.save:Dock( BOTTOM );

                pop.save:DockMargin( 2, 5, 2, 2 );

                pop.save:SetText( "S A V E" );

                pop.save:SetFont( "HCLib.VGUI.30" );

                pop.save:SetTextColor( white );

                pop.save:SetTall( 50 );

                pop.save.Paint = function( self, w, h )

                    draw.RoundedBoxEx( 19, 0, 0, w, h, self:IsHovered() and Purplemain or BlueSecond, false, false, true, true );

                end;

                pop.save.DoClick = function( self )

                    if ( not Setedrankpermission ) then return end;

                    if table.IsEmpty( Setedrankpermission ) then return end;

                    if ( setedrank == "" ) then return end;

                    if not isstring( setedrank ) then return end;
                    
                    HCLIB.Config.Cfg[ "main" ][ "UserGroups" ][ tostring( setedrank ) ] = Setedrankpermission;
                
                    net.Start( "HCLIB.SetConfig" );
                    
                        HCLIB:WriteCompressedTable( HCLIB.Config );

                        net.WriteString( "main" );

                        net.WriteString( "Config" );

                    net.SendToServer();
                            
                    net.Start( "HCLIB.RequestSynch" )
                    
                    net.SendToServer();
                        
                    net.Receive( "HCLIB.RequestSynch", function( )
                        
                        ranks:Groups();

                        pop:Remove();

                    end );

                end;

            end;

        end;

        ranks:Groups();








        ranks.configside = vgui.Create( "DPanel", ranks );

        ranks.configside:SetWide( 450 );

        ranks.configside:Dock( RIGHT );

        ranks.configside:DockMargin( 0, 60, 10, 10 );

        ranks.configside.Paint = function( self, w, h )
            
            draw.RoundedBox( 19, 0, 1, w, h - 2,  Purplemain );

            draw.RoundedBox( 15, 2, 2, w - 4, h - 8, BlueSecond );

        end;

        ranks.configside.Top = vgui.Create( "DLabel", ranks.configside );

        ranks.configside.Top:Dock( TOP );

        ranks.configside.Top:DockMargin( 0, 0, 0, 0 );

        ranks.configside.Top:SetTall( 50 );

        ranks.configside.Top:SetText( "" );

        ranks.configside.Top.Paint = function( self, w, h )
            
            draw.RoundedBoxEx( 19, 0, 1, w, h,  Purplemain, true, true, false, false );

            draw.SimpleText( HCLIB:L( "main", "maincfg.Ranks.Permissions" ), "HCLib.VGUI.30", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

        end;

        --[[
        ranks.configside.Add = vgui.Create( "DButton", ranks.configside.Top );

        ranks.configside.Add:Dock( RIGHT );

        ranks.configside.Add:DockMargin( 0, 0, 0, 0 );

        ranks.configside.Add:SetWide( 40 );

        ranks.configside.Add:SetText( "+" );

        ranks.configside.Add:SetFont( "HCLib.VGUI.35" );

        ranks.configside.Add:SetTextColor( white );

        ranks.configside.Add.Paint = function( self, w, h )

            draw.RoundedBoxEx( 19, 0, 1, w, h,  Color( 18, 227, 77), false, true, false, false );
            
        end;
 ]]
        ranks.configside.Scroll = vgui.Create( "HCLIB.Scroll", ranks.configside );

        ranks.configside.Scroll:Dock( FILL );

        ranks.configside.Scroll:DockMargin( 0, 5, 0, 0 );
       
        
        function ranks:GetPermissionss( rank )
            
            local function displayranks()

                ranks.configside.Scroll:Clear();

                for k, v in pairs( HCLIB.Admin.PermissionGroups[ rank ] ) do 


                    local button = vgui.Create( "DButton", ranks.configside.Scroll );

                    button:Dock( TOP );

                    button:DockMargin( 5, 4, 5, 0 );

                    button:SetTall( 70 );

                    button:SetText( k );

                    button:SetFont( "HCLib.VGUI.35" );

                    button:SetTooltip( HCLIB:L( "main", "maincfg.Ranks.permissionside.Info" ) );

                    button:SetTextColor( white );

                    button.Paint = function( self, w, h )
                        
                        draw.RoundedBox( 0, 0, 0, w, h, Purplemain );

                    end;

                    button.DoClick = function( )

                        local dmen = DermaMenu()

                        dmen:AddOption( HCLIB:L( "main", "maincfg.Delete" ), function()
                        
                            HCLIB.Config.Cfg[ "main" ][ "UserGroups" ][ tostring( rank ) ][ k ] = nil;
                        
                            net.Start( "HCLIB.SetConfig" );
                            
                                HCLIB:WriteCompressedTable( HCLIB.Config );

                                net.WriteString( "main" );

                                net.WriteString( "Config" );

                                net.SendToServer();
                                        
                                net.Start( "HCLIB.RequestSynch" )
                                
                                net.SendToServer();
                                    
                            net.Receive( "HCLIB.RequestSynch", function( )
                                
                                displayranks();

                            end );

                        end );

                        dmen:Open();

                    end;

                end;
                

            end;
            
            displayranks();

        end;
        

        

    end,
    
    LoadFiles = function()
    
        if ( SERVER ) then
    
        --    include("hclib/scripts/svwlist/sv_init.lua");
    
        end;
    
    end,
    
    }