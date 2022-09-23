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

--[[ < ---------- ( MANAGEDSCRIPTS ) ---------- > ]]--

net.Receive( "HCLIB.ManagedScripts" , function()

    local tbl = HCLIB:ReadCompressedTable();

    HCLIB.ScriptManaged = tbl;

end );

concommand.Add("HCLIB.GiveMeManual", function( ply, cmd, args, argstr )

    net.Start("HCLIB.GetConfig");

    net.SendToServer();

end );

--[[ < ---------- ( CONFIG ) ---------- > ]]--

net.Receive( "HCLIB.GetConfig", function()
    local tbl = HCLIB:ReadCompressedTable();


    HCLIB.Config.AccessGroups = nil;

    HCLIB.Config = tbl;

    --PrintTable( HCLIB.Config );

end );


if GAMEMODE then 

    net.Start("HCLIB.GetConfig");

    net.SendToServer();

end;

hook.Add( "Initialize", "HCLIB.Synchconfigto", function()
    
    net.Start("HCLIB.GetConfig");

    net.SendToServer();

end );

hook.Add( "InitPostEntity", "HCLIB.SynchConfig", function( ply )

    net.Start("HCLIB.GetConfig");

    net.SendToServer();

    net.Start("HCLIB.ManagedScripts");

    net.SendToServer();

end );
 


concommand.Add( "gf", function()


 --   HCLIB.Config.Cfg["main"].AdminMode = "SAddM"
    
 --   net.Start("HCLIB.SetConfig");
  --      HCLIB:WriteCompressedTable( HCLIB.Config );
   --     net.WriteString( "main" );
    --    net.WriteString( "Config" );
    --net.SendToServer();


    print( HCLIB.Admin:HasPermission( LocalPlayer(), "main", "HCLIB.Access" ) )
end ) 