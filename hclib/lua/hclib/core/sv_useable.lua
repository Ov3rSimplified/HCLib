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



local function UCT( ply, cmd, args, argStr )

    if not HCLIB.Debugmode then HCLIB:ChatMessage( ply, "error", " You need to activate the Debugmode!") return end;
    
    if not HCLIB.Admin:HasPermission( ply, "main", "Debugging" ) then return end;

    if not args[1] or not args[2] then HCLIB:ChatMessage( ply, "error", " you need to enter two arguments! ( read the wiki if you dont know it )") return end;

    if not HCLIB.FoundedScripts[ args[1] ] then HCLIB:ChatMessage( ply, "error", " the Script('" .. args[1] .. "') doesn´t exist!" ) return end;

    if not ( args[2] == "Config" or args[2] == "AccessGroups" or args[2] == "*" ) then HCLIB:ChatMessage( ply, "error", " The Section('" .. args[2] .."') doesn`t exist! Available Sections(Config, Language, AccessGroups, *) " ) return end;
    
    HCLIB:UpdateConfigTable( tostring( args[1] ), tostring( args[2] )  );

    if HCLIB.Debugmode then 
 
        HCLIB:ConsoleMessage( "info", " You have send a Updaterequest!" );

    end;
    
    
end;
concommand.Add( "HCLIB.UpdateConfigTable", UCT );

concommand.Add( "HCLIB.UCT", UCT )
