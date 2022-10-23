// Bind Manger by TwinKlee and Hexagon Cryptics Studios

return { 

    ScriptName = "Bind Manager",
    
    ScriptDescription = [[]], 
    
    ScriptExtraInformations = {},
    
    Scriptindex = "bm", // NEVER CHANGE THIS SHHIT

    Version = "4.2.0",

    Downloadshort = "GIT~HCLIB",
     
    Config = {
        Cfg = {
            ["ScriptBinds"] = {},
            ["CustomBinds"] = {},
        },  
        AccessGroups = {}
    },
     
    ScriptDevDocsentry = {},
    

    CreateIngameConfig = function( lib, parent ) 

    end,
    
    LoadFiles = function()
    
        if ( SERVER ) then 

            AddCSLuaFile( "hclib/lua/binds/cl_init.lua");

            include( "hclib/lua/binds/sv_init.lua");

        end;

            AddCSLuaFile( "hclib/lua/binds/sh_api.lua");

            include( "hclib/lua/binds/sh_api.lua");

        if ( CLIENT ) then 

            AddCSLuaFile( "hclib/lua/binds/cl_init.lua");
            
        end;
    
    end,
    
    }