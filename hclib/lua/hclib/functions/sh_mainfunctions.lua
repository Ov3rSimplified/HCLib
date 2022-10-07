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



--[[ < ---------- ( VGUI CREATION ) ---------- > ]]

function HCLIB:RegisterVGUI( Index, panel, base  )
    
    vgui.Register( "hclib_" .. Index, panel, base);

end;

function HCLIB:DefineVguiElement( Index, description, tab, base )
    
    derma.DefineControl( "hclib_" .. Index, description, tab, base);

end;



--[[ < ---------- ( DEBUGGING ) ---------- > ]]

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


--[[ < ---------- ( SWITCH ) ---------- > ]]

function HCLIB:Switch( var, cases, default )

    if not isstring( var ) then return end;

    if not istable( cases ) then return end;

    if table.IsEmpty( cases ) then return end;

    if table.IsSequential( cases ) then return end;


    if cases[var] then 

        cases[var]();

    else

        if default then 

            default();

        else

            return;

        end;
        
    end;

end;

 