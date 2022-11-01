// Bind Manger by TwinKlee and Hexagon Cryptics Studios
local delay = 0
hook.Add( "PlayerButtonDown", "BM.ScriptbindsDD", function( ply, button )

    ply = LocalPlayer();

    if ( ply != LocalPlayer() ) then return end;
    
    if delay < CurTime() then 

        for k, v in pairs( HCLIB.Scripts[ "bm" ].Scriptbinds ) do 

            if ( v.BINDKEY == button ) then  
 
                if v.ACCESSCHECK( ply ) == false then return end;
 
                v.FUNC( ply );

            end;

        end;

        delay = CurTime() + 0.2

    end;

end );

local delay = 0
hook.Add( "PlayerButtonDown", "BM.CustomBinds", function( ply, button )

    ply = LocalPlayer();

    if ( ply != LocalPlayer() ) then return end;
    
    if delay < CurTime() then 

        for k, v in pairs( HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ] ) do 

            if ( v.BINDKEY == button ) then 

                if HCLIB.Config.Cfg[ "bm" ][ "DisabledBinds" ][ k ] or BM.DisabledBinds[ k ] then return end;

                if ( v.ACCESS == {} and v.ACCESS[ ply:GetUserGroup() ] ) then return end;

                if ( v.MODE ~= "CMD" and v.MODE ~= "URL" and v.MODE ~= "LUA" ) then return end;

                if ( v.MODE == "CMD" ) then

                    LocalPlayer():ConCommand( v.CODE );

                elseif ( v.MODE == "LUA" ) then 

                    local function_ = CompileString( v.CODE, "HCLIB.bind:#LUA*IDX." .. k, true );
                    
                    if ( function_ ) then 
                    
                        function_();

                    else

                        HCLIB:ChatMessage( "error", " ~[IDX:" .. k .. "]".. "  " .. HCLIB:L( "bm", "ErrorCodeBINDIDX" ) )

                    end;

                elseif ( v.MODE == "URL" ) then 
                    
                    gui.OpenURL( v.CODE )

                end;

            end;

        end;

        delay = CurTime() + 0.2

    end;

end );


local white = Color( 255, 255, 255 );

local red = Color( 250, 0, 0, 255 );

local BlueMain = Color( 22, 23, 35, 255 );

local Purplemain = Color( 63, 15, 164, 255);


function BM:Menu()

 
    // Create Base Menu

    local Frame = vgui.Create( "DPanel" );

    Frame:SetSize( 950, 600 );

    Frame:Center();

    Frame:MakePopup();

    Frame.Paint = function( self, w, h )
        
        draw.RoundedBox( 15, 0, 0, w, h, Purplemain );

        draw.RoundedBox( 15, 2, 2, w - 4, h - 4, BlueMain )

    end;

    Frame.TOP = vgui.Create( "DPanel", Frame );

    Frame.TOP:Dock( TOP );

    Frame.TOP:DockMargin( 0, 0, 0, 0 );

    Frame.TOP:SetTall( 60 );

    Frame.TOP.Paint = function( self, w, h )
        
        draw.RoundedBoxEx( 15, 0, 0, w, h, Purplemain, true, true, false, false );

        draw.SimpleText( "Bind Manager", "HCLib.VGUI.40", 10, h / 2, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER );

    end;

    Frame.Close = vgui.Create( "DButton", Frame.TOP );

    Frame.Close:Dock( RIGHT );

    Frame.Close:DockMargin( 0, 0, 5, 0 );

    Frame.Close:SetFont( "HCLib.VGUI.50" );

    Frame.Close:SetText( "X" );

    Frame.Close:SetTextColor( white );

    Frame.Close:SetWide( 40 );

    Frame.Close.Paint = function( self, w, h )
        
        if ( self:IsHovered() ) then 

            self:SetTextColor( Color( 250, 0 ,0 ) );

        else

            self:SetTextColor( white );

        end;

    end;

    Frame.Close.DoClick = function()
        
        Frame:Remove();

    end;



    // SERVER BINDS

    local hbinds = vgui.Create( "DPanel", Frame );

    hbinds:Dock( LEFT );

    hbinds:DockMargin( 10, 10, 0, 10 );

    hbinds:SetWide( 455 );

    hbinds.Paint = function( self, w, h )
        
        draw.RoundedBox( 15, 0, 0, w, h, Purplemain );

        draw.RoundedBox( 15, 2, 2, w - 4, h - 4, BlueMain );

    end;

    hbinds.Top = vgui.Create( "DPanel", hbinds );

    hbinds.Top:Dock( TOP );

    hbinds.Top:DockMargin( 0, 0, 0, 0 );

    hbinds.Top:SetTall( 45 );

    hbinds.Top.Paint = function( self, w, h )
        
        draw.RoundedBoxEx( 15, 0, 0, w, h, Purplemain, true, true, false, false );     
        
        draw.SimpleText( HCLIB:L( "bm", "FixedBinds" ), "HCLib.VGUI.30", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

    end;

    hbinds.Scroll = vgui.Create( "HCLIB.Scroll", hbinds );

    hbinds.Scroll:Dock( FILL ); 

    local sbar = hbinds.Scroll:GetVBar();

    sbar:SetSize(5,0);

    sbar:SetHideButtons( false );

    function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

    function sbar:Paint( w, h ) return end;

    function sbar.btnUp:Paint( w, h ) return end;

    function sbar.btnDown:Paint( w, h ) return end;


    function hbinds.Buttons( k, v )

        local button = vgui.Create( "DPanel", hbinds.Scroll );

        button:Dock( TOP );

        button:DockMargin( 5, 5, 5, 0 );

        button:SetTall( 60 );

        button.Paint = function( self, w, h)
            
            draw.RoundedBox( 7.5, 0, 0, w, h, Purplemain );

            draw.RoundedBox( 7.5, 1, 1, w - 3, h - 3, BlueMain );

            draw.SimpleText( v.TITLE or v.NAME, "HCLib.VGUI.35", 5, h / 2, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

        end;


        local switch = vgui.Create( "HCLIB.Switch", button );

        switch:Dock( RIGHT );

        switch:DockMargin( 0, 20, 0, 0 );

        switch:SetChecked( not BM.DisabledBinds[ v.INDEX ] and true or false  );

        switch:SetText( "" );     


        local binder = vgui.Create( "HCLIB.Binder", button );
        
        binder:Dock( RIGHT );

        binder:DockMargin( 0, 5, 10, 5 );
        
        binder:SetDisabled( BM.DisabledBinds[ v.INDEX ] == true and true or BM.DisabledBinds[ v.INDEX ] == nil and false ); 
        
        binder:SetValue( v.BINDKEY or KEY_NONE );

        binder.OnChange = function( self )
            
            BM.BindSetting[ v.INDEX ] = binder:GetValue();
            
            BM:SaveNewCookieData( 2, BM.BindSetting )

        end;

        switch.OnChange = function( self, w, h )
            
           binder:SetDisabled( self:GetChecked() == true and false or self:GetChecked() == false and true );

           if ( self:GetChecked() == false ) then 

                BM.DisabledBinds[ v.INDEX ] = true;

                BM:SaveNewCookieData( 1, BM.DisabledBinds );

           else

                BM.DisabledBinds[ v.INDEX ] = nil;

                BM:SaveNewCookieData( 1, BM.DisabledBinds );   

           end;

        end;

    end;

    for k, v in pairs( HCLIB.Scripts[ "bm" ].Scriptbinds ) do 

        if ( HCLIB.Config.Cfg[ "bm" ][ "DisabledBinds" ][ v.INDEX ] ) then continue end;

        hbinds.Buttons( k, v );

    end;

    for k, v in pairs( HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ] ) do 

        if (  HCLIB.Config.Cfg[ "bm" ][ "DisabledBinds" ][ k ] ) then return end;

        hbinds.Buttons( k, v );

    end;


    // Client BINDS

    local cbinds = vgui.Create( "DPanel", Frame );

    cbinds:Dock( RIGHT );

    cbinds:DockMargin( 0, 10, 10, 10 );

    cbinds:SetWide( 455 );

    cbinds.Paint = function( self, w, h )
        
        draw.RoundedBox( 15, 0, 0, w, h, Purplemain );

        draw.RoundedBox( 15, 2, 2, w - 4, h - 4, BlueMain );

    end;


    cbinds.Top = vgui.Create( "DPanel", cbinds );

    cbinds.Top:Dock( TOP );

    cbinds.Top:DockMargin( 0, 0, 0, 0 );

    cbinds.Top:SetTall( 45 );

    cbinds.Top.Paint = function( self, w, h )
        
        draw.RoundedBoxEx( 15, 0, 0, w, h, Purplemain, true, true, false, false );     
        
        draw.SimpleText( HCLIB:L( "bm", "YourBinds" ), "HCLib.VGUI.30", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );

    end;

    cbinds.Add = vgui.Create( "DButton", cbinds.Top )
    
    cbinds.Add:Dock( RIGHT );

    cbinds.Add:DockMargin( 0, 0, 5, 0 );

    cbinds.Add:SetFont( "HCLib.VGUI.50" );

    cbinds.Add:SetText( "+" );

    cbinds.Add:SetTextColor( white );

    cbinds.Add:SetWide( 40 );

    cbinds.Add.Paint = function( self, w, h )
        
        if ( self:IsHovered() ) then 

            self:SetTextColor( Color( 0, 250 ,8) );

        else

            self:SetTextColor( white );

        end;

    end;


    cbinds.Scroll = vgui.Create( "HCLIB.Scroll", cbinds );

    cbinds.Scroll:Dock( FILL ); 

    local sbar = cbinds.Scroll:GetVBar();

    sbar:SetSize(5,0);

    sbar:SetHideButtons( false );

    function sbar.btnGrip:Paint( w, h ) draw.RoundedBox( 14, 0, 0, w, h, Purplemain ) end;

    function sbar:Paint( w, h ) return end;

    function sbar.btnUp:Paint( w, h ) return end;

    function sbar.btnDown:Paint( w, h ) return end;

    
    function cbinds.Buttons( k, v )

        local button = vgui.Create( "DPanel", hbinds.Scroll );

        button:Dock( TOP );

        button:DockMargin( 5, 5, 5, 0 );

        button:SetTall( 60 );

        button.Paint = function( self, w, h)
            
            draw.RoundedBox( 7.5, 0, 0, w, h, Purplemain );

            draw.RoundedBox( 7.5, 1, 1, w - 3, h - 3, BlueMain );

            draw.SimpleText( v.TITLE or v.NAME, "HCLib.VGUI.35", 5, h / 2, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

        end;


        local delete = vgui.Create( "DButton", button );

        delete:Dock( RIGHT );

        delete:DockMargin( 0, 20, 0, 0 );

        delete:SetChecked( not BM.DisabledBinds[ v.INDEX ] and true or false  );

        delete:SetText( "" );     


        local binder = vgui.Create( "HCLIB.Binder", button );
        
        binder:Dock( RIGHT );

        binder:DockMargin( 0, 5, 10, 5 );
        
        binder:SetDisabled( BM.DisabledBinds[ v.INDEX ] == true and true or BM.DisabledBinds[ v.INDEX ] == nil and false ); 
        
        binder:SetValue( v.BINDKEY or KEY_NONE );

        binder.OnChange = function( self )
            
           -- BM.BindSetting[ v.INDEX ] = binder:GetValue();
            
           --BM:SaveNewCookieData( 2, BM.BindSetting )

        end;

    end;


end;

concommand.Add( "Binds", function( )
    
    BM:Menu();

end );

for k, v in pairs( HCLIB.Scripts[ "bm" ].Scriptbinds ) do 

    print( k )

    PrintTable( v )

end