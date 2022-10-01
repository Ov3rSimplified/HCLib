
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

util.AddNetworkString( "HCLIB.Manageto" );

util.AddNetworkString( "HCLIB.SetConfig" );

util.AddNetworkString( "HCLIB.GetConfig" );

util.AddNetworkString( "HCLIB.CheckIfAllConfigInSQL" );

util.AddNetworkString( "HCLIB.UpdateConfigTables" );


--[[ < ---------- ( FUNCTIONS ) ---------- > ]]--


function HCLIB:ManagedScripts() // Read Scripts
    
    local filer = {};

    if not cookie.GetString("HCLIB.Scripts", nil ) then 

        cookie.Set( "HCLIB.Scripts", util.TableToJSON( { } ) );

        filer = {};

    else

        local tbl = cookie.GetString("HCLIB.Scripts", nil);

        filer = util.JSONToTable( tbl );

    end;

    net.Start("HCLIB.ManagedScripts");

        HCLIB:WriteCompressedTable(filer);

    net.Broadcast();

end;

function HCLIB:SetScript( Script, Bool ) // STRING Script, BOOL Bool

    local filer = {};

    local readcurcookie = util.JSONToTable( cookie.GetString("HCLIB.Scripts", nil) )

    if not cookie.GetString("HCLIB.Scripts", nil ) then 

        cookie.Set( "HCLIB.Scripts", util.TableToJSON( { [ Script ] = Bool } ) );

        if HCLIB.Debugmode then HCLIB:ConsoleMessage( "info", " *{SetScript} - Created Cookie Manual" ); end; 

    elseif readcurcookie[ Script ] == nil then 

        local tbl = util.JSONToTable( cookie.GetString("HCLIB.Scripts", nil) );

        table.Merge( tbl, { [ Script ] = Bool } );

        cookie.Set( "HCLIB.Scripts", util.TableToJSON( tbl ) ); 

        if HCLIB.Debugmode then HCLIB:ConsoleMessage( "info", " *{SetScript} - Force Inserted when index is NIL" ); end; 

    else 

        local tbl = util.JSONToTable( cookie.GetString("HCLIB.Scripts", nil) );

        tbl[ Script ] = bool;

        cookie.Set( "HCLIB.Scripts", util.TableToJSON( tbl ) ); 

        if HCLIB.Debugmode then HCLIB:ConsoleMessage( "info", " *{SetScript} - ELSE" ); end; 


    end;
    
    HCLIB.ScriptManaged[ Script ] = util.JSONToTable( cookie.GetString("HCLIB.Scripts", nil) );

    net.Start("HCLIB.ManagedScripts");

        HCLIB:WriteCompressedTable( util.JSONToTable( cookie.GetString( "HCLIB.Scripts" ) ) );

    net.Broadcast();

end;

function HCLIB:CIACISQL()  // Check if all Configs in SQL
 
    local st = SQLStr
     
    for k, v in pairs( HCLIB.FoundedScripts ) do 

        if not sql.QueryValue( "SELECT Class FROM HCLIB_Config WHERE Class = '" .. k .. "'" ) then 

            local Query = "INSERT INTO HCLIB_Config( Class, Language, Config, AccessGroups ) VALUES(" .. st( k ) .. ", " .. st( util.TableToJSON( HCLIB.ScriptBridge[k].Config.Language ) ) .. ", " .. st( util.TableToJSON( HCLIB.ScriptBridge[k].Config.Cfg ) ) ..", " .. st( util.TableToJSON( HCLIB.ScriptBridge[k].Config.AccessGroups ) ) ..")"

            sql.Query( Query )

        end

    end;

end;

function HCLIB:NSQLCT( class, section, newtable ) // New SQL Config Table

    sql.Query( "UPDATE HCLIB_Config SET " .. SQLStr( section ) .. " = " .. SQLStr( util.TableToJSON( newtable ) ) .. " WHERE Class = " .. SQLStr( class ) )

end;

function HCLIB:UpdateConfigTables()

    for k, v in pairs( HCLIB.FoundedScripts ) do 

        if sql.QueryValue( "SELECT Class FROM HCLIB_Config WHERE Class = '" .. k .. "'" ) then 
 

            table.Merge(HCLIB.Config.Language[k], HCLIB.ScriptBridge[k].Config.Language);

            table.Merge(HCLIB.Config.Cfg[k], HCLIB.ScriptBridge[k].Config.Cfg);

            table.Merge(HCLIB.Config.AccessGroups[k], HCLIB.ScriptBridge[k].Config.AccessGroups);



            local langtbl = HCLIB.Config.Language[k];

            local cfgtbl = HCLIB.Config.Cfg[k];
  
            local adtbl = HCLIB.Config.AccessGroups[k];



            HCLIB:NSQLCT( k, "Language", langtbl );

            HCLIB:NSQLCT( k, "Config", cfgtbl );

            HCLIB:NSQLCT( k, "AccessGroups", adtbl );
            
            HCLIB:SynchPermissions();

        end; 

    end;

end;
 
function HCLIB:UpdateConfigTable( Class, Section  )

    if not HCLIB.FoundedScripts[ Class ] then 
    
        HCLIB:ConsoleMessage("error", " The class don`t exist!")

        return 
    
    end;
    if not ( Section == "Language" or "Config" or "AccessGroups" or "*" ) then 
        
        HCLIB:ConsoleMessage("error", " Invalid Section!")
        
        return; 
    
    end;

    if sql.QueryValue( "SELECT Class FROM HCLIB_Config WHERE Class = '" .. Class .. "'" ) then 

        HCLIB:Switch( tostring( Section ) , {
            ["*"] = function()
                
                table.Merge(HCLIB.Config.Language[Class], HCLIB.ScriptBridge[Class].Config.Language);

                table.Merge(HCLIB.Config.Cfg[Class], HCLIB.ScriptBridge[Class].Config.Cfg);
    
                table.Merge(HCLIB.Config.AccessGroups[Class], HCLIB.ScriptBridge[Class].Config.AccessGroups);
    
    
    
                local langtbl = HCLIB.Config.Language[Class];
    
                local cfgtbl = HCLIB.Config.Cfg[Class];
      
                local adtbl = HCLIB.Config.AccessGroups[Class];
    
    
    
                HCLIB:NSQLCT( Class, "Language", langtbl );
    
                HCLIB:NSQLCT( Class, "Config", cfgtbl );
    
                HCLIB:NSQLCT( Class, "AccessGroups", adtbl );

                HCLIB:SynchPermissions()

                HCLIB:GetConfig();
                
            end,
            ["Language"] = function()

                table.Merge(HCLIB.Config.Language[Class], HCLIB.ScriptBridge[Class].Config.Language);
                
                local langtbl = HCLIB.Config.Language[Class];

                HCLIB:NSQLCT( Class, "Language", langtbl );

                HCLIB:GetConfig();

            end,
            ["Config"] = function()

                table.Merge(HCLIB.Config.Cfg[Class], HCLIB.ScriptBridge[Class].Config.Cfg);

                local cfgtbl = HCLIB.Config.Cfg[Class];
 
                HCLIB:NSQLCT( Class, "Config", cfgtbl );

                HCLIB:SynchPermissions();

                HCLIB:GetConfig();

            end,
            ["AccessGroups"] = function()
                
                table.Merge(HCLIB.Config.AccessGroups[Class], HCLIB.ScriptBridge[Class].Config.AccessGroups);

                local adtbl = HCLIB.Config.AccessGroups[Class];

                HCLIB:NSQLCT( Class, "AccessGroups", adtbl );

                HCLIB:SynchPermissions();

                HCLIB:GetConfig();

            end,
        }, function()
            
            HCLIB:ConsoleMessage("error", " FATAL ERROR WHILE EXECUTE HCLIB:UpdateConfigTable( " .. Class .. " " .. Section .. "  )")

            return;

        end)

    end;

end; 

function HCLIB:ResetConfigData()

    local st = SQLStr
     
    for k, v in pairs( sql.Query( "SELECT * FROM HCLIB_Config" ) ) do 

        if HCLIB.FoundedScripts[ v.Class ] then     --sql.QueryValue( "SELECT Class FROM HCLIB_Config WHERE Class = " .. st( v.Class ) ) then 

            print( v.Class .. " FOUNDED" )
            
        else

            print( v.Class .. " NOT FOUNDED" )

        end;

    end;

end;

function HCLIB:GetConfig()
    
    local SendToPly = function()
 
        net.Start("HCLIB.GetConfig");

            HCLIB:WriteCompressedTable( HCLIB.Config );
        
        net.Broadcast();

    end;

    local sqltable = sql.Query( "SELECT * FROM HCLIB_Config" );

    for k, v in pairs( sqltable ) do 

    if ( HCLIB.ScriptManaged[ v.Class ] == false ) then continue end;
 
        local languagetbl = { [v.Class] = util.JSONToTable( v.Language ) };
        
        local AccessGrouptbl = { [v.Class] = util.JSONToTable( v.AccessGroups ) };

        local configtbl = { [v.Class] = util.JSONToTable( v.Config ) };


        if table.IsEmpty( util.JSONToTable( v.Config ) ) then 

            HCLIB.Config.Cfg[ v.Class ] = {};

        else

            table.Merge(HCLIB.Config.Cfg, configtbl);
        
        end;

        if table.IsEmpty( util.JSONToTable( v.Language ) ) then 

            HCLIB.Config.Language[ v.Class ] = {};

        else

            table.Merge(HCLIB.Config.Language, languagetbl);
 
        end;    

        if table.IsEmpty( util.JSONToTable( v.AccessGroups ) ) then 

            HCLIB.Config.AccessGroups[ v.Class ] = {};

        else


            table.Merge(HCLIB.Config.AccessGroups, AccessGrouptbl);

        end;
        

        SendToPly()

    end;
 
end;




--[[ < ---------- ( NET FUNCTIONS ) ---------- > ]]--

local function CIACISQL( len, ply )
    
    do HCLIB:CIACISQL() end;
    
end;

local function UCT( len, ply ) // Update Config Tables   
end;

local function GETCONFIG( len, ply )
    
    do HCLIB:GetConfig() end;

end; 

local function CHANGECONFIGVAR( len, ply ) 

    HCLIB.Admin:HasPermission( ply, "main", "HCLIB.Access" );

    local ReceivedTable = HCLIB:ReadCompressedTable();

    local Class = net.ReadString();

    local Section = net.ReadString();


    if not HCLIB.FoundedScripts[ Class ] then return end;

    if not ( Section == "Config" and "Language" and "AccessGroups" ) then  HCLIB:ConsoleMessage("error", " Invalid Section!") return end;


    if sql.QueryValue( "SELECT Class FROM HCLIB_Config WHERE Class = '" .. Class .. "'" ) then 

        local data = util.JSONToTable( sql.QueryValue( "SELECT " .. tostring( Section ) .. " FROM HCLIB_Config WHERE Class = '" .. Class .. "'" ) ); 


        HCLIB:Switch( Section, {

            [ "Config" ] = function()

                HCLIB:NSQLCT( Class, Section, ReceivedTable.Cfg[ Class ] )
                
            end,

            [ "Language" ] = function()

                HCLIB:NSQLCT( Class, Section, ReceivedTable.Language[ Class ] )
                
            end,

            [ "AccessGroups" ] = function()

                HCLIB:NSQLCT( Class, Section, ReceivedTable.AccessGroups[ Class ] )
                
            end,
        }, function()
            
            HCLIB:ConsoleMessage("error", " FATAL ERROR WHILE EXECUTE CHANGVAR( " .. Class .. " " .. Section .. "  )")

            return;

        end )
        

    end;

    do HCLIB:GetConfig() end;

end; 

local function MANAGEDSCRIPTS( len, ply )

    do HCLIB:ManagedScripts() end;
    
end;

local function MANAGETO( len, ply )
      
    HCLIB.Admin:HasPermission( ply, "main", "HCLIB.Access" );

    local str = net.ReadString();

    local bool = net.ReadBool();

    HCLIB:SetScript( str, bool )

end;


--[[ < ---------- ( CREATE NETS ) ---------- > ]]--

net.Receive("HCLIB.ManagedScripts", MANAGEDSCRIPTS );

net.Receive( "HCLIB.Manageto", MANAGETO );

net.Receive( "HCLIB.SetConfig", CHANGECONFIGVAR );

net.Receive( "HCLIB.GetConfig", GETCONFIG );

net.Receive( "HCLIB.CheckIfAllConfigInSQL", CIACISQL );

--[[ < ---------- ( HOOKS ) ---------- > ]]--


hook.Add( "InitPostEntity", "HCLIB.SynchEneabledScripts", function( ply )

    HCLIB:ManagedScripts();

    HCLIB:GetConfig();

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


end );

--[[ < ---------- ( SQL INIT ) ---------- > ]]--


// CREATE MAIN CONFIG 
sql.Query( "CREATE TABLE IF NOT EXISTS HCLIB_Config( Class TEXT NOT NULL PRIMARY KEY, Language TEXT, Config TEXT, AccessGroups TEXT )" );


if ( SERVER ) then 
    
    if HCLIB.isInit then return end;

    HCLIB:CIACISQL()

end;
