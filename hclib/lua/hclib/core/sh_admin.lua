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

--if ( not HCLIB.Config.InitAdminInterface ) then return end;

HCLIB.Admin = HCLIB.Admin or {};

HCLIB.Admin.PermissionGroups = HCLIB.Admin.PermissionGroups or {};

HCLIB.Admin.Permissions = HCLIB.Admin.Permissions or {};




// < ---------- ( Hole of Checks ) ---------- >

function HCLIB.Admin:HasPermission( ply, class, permission )

    local prank = ply:GetUserGroup();

    if  ( CLIENT ) then 

        net.Start( "HCLIB.CheckGoodClient" );

            HCLIB:WriteCompressedTable( HCLIB.Admin.PermissionGroups );

            HCLIB:WriteCompressedTable( HCLIB.Admin.Permissions );

        net.SendToServer();
        
    end;

    if table.IsEmpty( HCLIB.Admin.Permissions ) then return end;

    if table.IsEmpty( HCLIB.Admin.PermissionGroups ) then return end;

    if ( prank == "superadmin" ) then return true end;


    if not HCLIB.Admin.PermissionGroups[ tostring( prank ) ] then return false end;

    if not HCLIB.Admin.Permissions[ class ][ permission ] then HCLIB:ConsoleMessage("error", " The Permission don´t exist!") return false end;

    if ( HCLIB.Admin.PermissionGroups[ tostring( prank ) ][ "*" ] ) then return true end;

    if HCLIB.Admin.PermissionGroups[ tostring( prank ) ][ permission ] then return true else return false end;

end;

