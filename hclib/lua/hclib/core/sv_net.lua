
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

util.AddNetworkString( "HCLIB.ManagedScripts" );

util.AddNetworkString( "HCLIB.GetConfig" ); 

util.AddNetworkString( "HCLIB.Manageto" );


--[[ < ---------- ( MANAGEDSCRIPTS ) ---------- > ]]--

net.Receive("HCLIB.ManagedScripts", function( len, ply )

    local filer = {};

    if not file.Exists( "hclib/scripts.json", "DATA" ) then 

        file.CreateDir("hclib");

        file.Write( "hclib/scripts.json", util.TableToJSON( {} ) );

        filer = {};
    else 
        
        filer = util.JSONToTable( file.Read("hclib/scripts.json", "DATA" ) )
        HCLIB.ScriptManaged = filer

    end;

    net.Start("HCLIB.ManagedScripts");
        HCLIB:WriteCompressedTable(filer)
    net.Send(ply)

end)

net.Receive( "HCLIB.Manageto", function( len, ply )
    
    local str = net.ReadString();

    local bool = net.ReadBool();

    local filer = {};

    if not file.Exists( "hclib/scripts.json", "DATA" ) then 

        file.CreateDir("hclib");

        file.Write( "hclib/scripts.json", util.TableToJSON( { [str] = bool } ) );

    else
        
        filer = util.JSONToTable( file.Read("hclib/scripts.json", "DATA" ) )

        filer[str] = bool;

        file.Write( "hclib/scripts.json", util.TableToJSON(filer) )

    end;

    HCLIB.ScriptManaged[str] = bool;

    net.Start("HCLIB.ManagedScripts");

        HCLIB:WriteCompressedTable(HCLIB.ScriptManaged);

    net.Broadcast();

end )

hook.Add( "InitPostEntity", "HCLIB.SynchEneabledScripts", function( ply )

    net.Start("HCLIB.ManagedScripts");

    net.Broadcast();


    net.Start( "HCLIB.GetConfig" );

    net.SendToServer();

end );


--[[ < ---------- ( CONFIG ) ---------- > ]]--

net.Receive( "HCLIB.SetConfig", function()

end );

net.Receive( "HCLIB.GetConfig", function(len,ply)

    local without = function()

        net.Start("HCLIB.GetConfig");

            HCLIB:WriteCompressedTable( HCLIB.Config );
        
        net.Broadcast();

    end;


    for k, v in pairs( HCLIB.ScriptManaged ) do 
        
        if not HCLIB.ScriptManaged[k] then continue end;

        local sourceLanguage = HCLIB.ScriptBridge[k].Config.Language;

        local mergedLanguage = { [k] = table.IsEmpty(sourceLanguage) and {} or sourceLanguage };

        local sourceConfig = HCLIB.ScriptBridge[k].Config.Vars;

        local mergedConfig = { [k] = table.IsEmpty(sourceConfig) and {} or sourceConfig };

        table.Merge( HCLIB.Config.Language, mergedLanguage );

        table.Merge( HCLIB.Config.Cfg, mergedConfig );

    end;

    if file.Exists( "hclib/config.json", "DATA" ) then 
        
        if not istable( util.JSONToTable( file.Read( "hclib/config.json", "DATA" ) ) ) then print(1) without() return end;

        local filer = util.JSONToTable(file.Read( "hclib/config.json", "DATA" ) )
        
        if HCLIB.Config == filer then 
            print(2)

            endsendtbl = filer;

            net.Start("HCLIB.GetConfig");

                HCLIB:WriteCompressedTable( endsendtbl );
            
            net.Broadcast();

        else 
            print(3)

            table.Merge( HCLIB.Config, filer );

            net.Start("HCLIB.GetConfig");

                HCLIB:WriteCompressedTable( HCLIB.Config );
            
            net.Broadcast();

        end; 

    else

        without()

    end;

end );
