
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

local sre = {};

function HCLIB:SimpleScrollingText( scrollid, text, font, x, y, color, ax, ay )

    ax = ax or 0;

    ay = ay or 0;

    if ( !scrollid ) then

        scrollid = table.insert( sre, {
            [ "text" ] = "",
            
            [ "count" ] = 0,

            [ "next" ] = SysTime()

        } );

        return scrollid;

    end;

    if ( !sre[ scrollid ] ) then return end;

    local nowText = sre[ scrollid ][ "text" ];

    surface.SetFont( font );

    local width, height = surface.GetTextSize( nowText );

    draw.SimpleText( nowText, font, x, y, color, ax, ay );

    if ( sre[ scrollid ].next <= SysTime() and sre[ scrollid ][ "count" ] < string.len( text ) + 1 ) then

        sre[ scrollid ].next = SysTime() + 0.05;

        sre[ scrollid ]["text"] = sre[ scrollid ][ "text" ] .. string.sub( text, sre[ scrollid ][ "count" ], sre[ scrollid ][ "count" ] );
        
        sre[ scrollid ][ "count" ] = sre[ scrollid ][ "count" ] + 1;

        surface.PlaySound( "items/nvg_off.wav" );

    end;

    if ( sre[ scrollid ][ "count" ] >= string.len( text ) ) then

        sre[ scrollid ] = nil;

        return -1;

    end;

    return scrollid;

end;