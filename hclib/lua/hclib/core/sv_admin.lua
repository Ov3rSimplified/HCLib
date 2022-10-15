
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

--[[ < ---------- ( NETSTRINGS ) ---------- > ]]--

util.AddNetworkString( "HCLIB.SynchPermissions" );

util.AddNetworkString( "HCLIB.CheckGoodClient" );

util.AddNetworkString( "HCLIB.SendPermission" );

util.AddNetworkString( "HCLIB.RequestSynch" );

--[[ < ---------- ( NET FUNCTIONS ) ---------- > ]]--

local function SynchPermissions( len, ply )

    if HCLIB.Config.Cfg["main"]["UserGroups"] then 

        HCLIB.Admin.PermissionGroups = HCLIB.Config.Cfg["main"]["UserGroups"];

    end;

    for k, v in pairs( HCLIB.Config.AccessGroups ) do 

        if not HCLIB.Config.AccessGroups[k] then continue end;

        if table.IsEmpty( HCLIB.Config.AccessGroups[k] ) then continue end;

        HCLIB.Admin.Permissions[k] = v
 
    end;

    net.Start( "HCLIB.SynchPermissions" );

        HCLIB:WriteCompressedTable( HCLIB.Admin.PermissionGroups  );

        HCLIB:WriteCompressedTable( HCLIB.Admin.Permissions );

    net.Broadcast();

end;

local function CheckGoodClient( len, ply )   

    local clientTable_pg = HCLIB:ReadCompressedTable();

    local clientTable_p = HCLIB:ReadCompressedTable();

    local serverTable_pg = HCLIB.Admin.PermissionGroups;

    local serverTable_p = HCLIB.Admin.Permissions;

    local ts = table.ToString

    if ts( clientTable_pg ) != ts( serverTable_pg ) then 

        ply:Kick( "Why you try it?" )

    end;    

    if ts( clientTable_p ) != ts( serverTable_p ) then 
         
        ply:Kick( "Why you try it?" )

    end;

end;

local function SendPermission( len, ply )

  --  if table.IsEmpty( HCLIB.Admin.PermissionGroups ) then return end;

    --if table.IsEmpty( HCLIB.Admin.Permissions ) then return end;

    net.Start( "HCLIB.SendPermission" )

        HCLIB:WriteCompressedTable( HCLIB.Admin.PermissionGroups  );

        HCLIB:WriteCompressedTable( HCLIB.Admin.Permissions );

    net.Send( ply );

end;


--[[ < ---------- ( CREATE NETS ) ---------- > ]]--

net.Receive( "HCLIB.SynchPermissions", SynchPermissions);

net.Receive( "HCLIB.CheckGoodClient", CheckGoodClient);

net.Receive( "HCLIB.SendPermission", SendPermission);

net.Receive( "HCLIB.RequestSynch", function( len, ply ) SynchPermissions( len, ply ) net.Start( "HCLIB.RequestSynch" ) net.Send( ply ) end );

--[[ < ---------- ( FUNCTIONS ) ---------- > ]] --

function HCLIB:SynchPermissions()

    SynchPermissions( _, _ );

end;


--[[ < ---------- ( HOOK ) ---------- > ]] --

hook.Add( "PlayerInitialSpawn", "HCLIB.HOOK.SendPermissions", function( ply )
    
    SendPermission( _, ply );

end )


