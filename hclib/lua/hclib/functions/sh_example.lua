
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


function HCLIB:ConsoleMessage(mode, text)

    if mode == "error" then 

        MsgC( Color( 222, 23, 208), "[HCLIB]", Color(250,0,0), " - [ERROR] ", Color(255,255,255), text, "\n" );

    end;

    if mode == "info" then 

        MsgC( Color( 222, 23, 208), "[HCLIB]", Color(216,197,21), " - [INFO] ", Color(255,255,255), text, "\n" );

    end;
    
    if mode == "success" then 

        MsgC( Color( 222, 23, 208), "[HCLIB]", Color(250,92,0), " - [SUCCESS] ", Color(255,255,255), text, "\n" );

    end;

end;

if ( CLIENT ) then 

    function HCLIB:ChatMessage(mode, text)

        if mode == "error" then 

            chat.AddText( Color( 222, 23, 208), "[HCLIB]", Color(250,0,0), " - [ERROR] ", Color(255,255,255), text, "\n" );

        end;

        if mode == "info" then 

            chat.AddText( Color( 222, 23, 208), "[HCLIB]", Color(250,92,0), " - [INFO] ", Color(255,255,255), text, "\n" );

        end;
        
        if mode == "success" then 

            chat.AddText( Color( 222, 23, 208), "[HCLIB]", Color(250,92,0), " - [SUCCESS] ", Color(255,255,255), text, "\n" );

        end;

    end;


    net.Receive( "HCLIB.Chatmessageee", function( )
        
        HCLIB:ChatMessage(net.ReadString(), net.ReadString());

    end )

end;

if ( SERVER ) then 

    util.AddNetworkString( "HCLIB.Chatmessageee" )

    function HCLIB:ChatMessage( ply, mode, text)

        net.Start( "HCLIB.Chatmessageee" );

            net.WriteString( mode );
            
            net.WriteString( text );

        net.Send( ply );

    end;

end;