// bms
BM:AddScriptBind( {

    TITLE = "HCLIB Menu",

    DESCRIPTION = "...", 

    INDEX = "HCLIBMEN",

    BINDKEY = KEY_F8,

    ACCESSCHECK = function( ply  )

        return HCLIB.Config.Cfg[ "main" ].AllowOpenwithKey; 

    end,
    
    FUNC = function( ply )
 
       HCLIB:OpenMenu();

       print( ply )
        
    end

} );
