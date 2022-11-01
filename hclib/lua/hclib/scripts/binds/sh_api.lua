// Bind Manger by TwinKlee and Hexagon Cryptics Studios

BM = HCLIB.Scripts[ "bm" ]

function BM:AddScriptBind( data )

    data.TITLE = data.TITLE or "";

    data.INDEX = data.INDEX or "";

    data.BINDKEY = data.BINDKEY or KEY_NONE;

    data.ACCESSCHECK = data.ACCESSCHECK or nil;

    data.FUNC = data.FUNC or nil; 

    if ( data.TITLE == "" ) then return end;
    
    if ( data.INDEX == "" ) then return end;

    if ( not data.FUNC ) then return end;

    //if ( HCLIB.Scripts[ "bm" ].Scriptbinds[ data.index ] ) then return end;

    HCLIB.Scripts[ "bm" ].Scriptbinds[ data.INDEX ] = data;

end;


local files, folder = file.Find( "hclib/modules/binds/*", "LUA" );

for k, v in pairs( files ) do  

    AddCSLuaFile( "hclib/modules/binds/" .. v );

    include( "hclib/modules/binds/" .. v );

end;