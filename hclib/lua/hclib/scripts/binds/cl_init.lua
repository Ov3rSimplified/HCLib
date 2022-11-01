// Bind Manger by TwinKlee and Hexagon Cryptics Studios
    
if ( not cookie.GetString( "HCLIB.BM.DisabledBinds" ) ) then 

    cookie.Set( "HCLIB.BM.DisabledBinds", util.TableToJSON( {} ) );

end;

if ( not cookie.GetString( "HCLIB.BM.BindSetting" ) ) then 


    cookie.Set( "HCLIB.BM.BindSetting", util.TableToJSON( {} ) );

end;

if ( not cookie.GetString( "HCLIB.BM.ClientBinds" ) ) then 

    cookie.Set( "HCLIB.BM.ClientBinds", util.TableToJSON( {} ) );

end;


function BM:Refresh()

    BM.DisabledBinds = util.JSONToTable( cookie.GetString( "HCLIB.BM.DisabledBinds" ) );

    BM.BindSetting = util.JSONToTable( cookie.GetString( "HCLIB.BM.BindSetting" ) );

    if ( HCLIB.Config.Cfg[ "bm" ][ "EnableCustomUserBinds" ] ) then 

        BM.ClientBinds = util.JSONToTable( cookie.GetString( "HCLIB.BM.ClientBinds" ) );

    end;
 
    
    for k, v in pairs( BM.BindSetting ) do

        if ( HCLIB.Scripts[ "bm" ].Scriptbinds[ k ] ) then 

            HCLIB.Scripts[ "bm" ].Scriptbinds[ k ].BINDKEY = v;

        end;

        if ( HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ][ k ] ) then 

            HCLIB.Config.Cfg[ "bm" ][ "CustomBinds" ][ k ].BINDKEY = v;

        end;

    end;
 
end;

net.Receive( "HCLIB.BM.GetDataonSpawn", function( )

    BM:Refresh();

end );

concommand.Add( "ReloadBinds", function( )
    
     BM:Refresh();

end );

function BM:SaveNewCookieData( int, table )
    
    if ( not istable( table ) ) then return end;

    if ( int == 1 ) then 

        cookie.Set( "HCLIB.BM.DisabledBinds", util.TableToJSON( table ) );

        BM.DisabledBinds = util.JSONToTable( cookie.GetString( "HCLIB.BM.DisabledBinds" ) );

        BM:Refresh();

    end;
 
    if ( int == 2 ) then 

        cookie.Set( "HCLIB.BM.BindSetting", util.TableToJSON( table ) );

        BM.BindSetting = util.JSONToTable( cookie.GetString( "HCLIB.BM.BindSetting" ) );
 
        BM:Refresh();

    end;

end;
