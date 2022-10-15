
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

--[[                     < -- GLOBAL VARS -- >                     ]]--

HCLIB = HCLIB or {};

HCLIB.SQL = HCLIB.SQL or {};

HCLIB.Scripts = HCLIB.Scripts  or {};

HCLIB.FoundedScripts = HCLIB.FoundedScripts  or {};
 
HCLIB.ScriptManaged = HCLIB.ScriptManaged or {};

HCLIB.ScriptBridge = HCLIB.ScriptBridge or {};

HCLIB.Config = HCLIB.Config or {};

HCLIB.Config.Language = HCLIB.Config.Language or {};

HCLIB.Config.Cfg = HCLIB.Config.Cfg or {};

HCLIB.Config.AccessGroups = HCLIB.Config.AccessGroups or {};


HCLIB.SupportetLanguages = {
    ["GER"] = true,
    ["ENG"] = true,
    ["ESP"] = true,
    ["JAP"] = true,
    ["FRA"] = true,
}

HCLIB.Debugmode = true; 



if ( SERVER ) then      

    if not cookie.GetString( "HCLIB.SQL" ) then

        cookie.Set( "HCLIB.SQL", util.TableToJSON( { use = false, IP = "0.0.0.0", UserName = "", Password = "", Databasename = "", Port = "3306"  } ) );

    end;
    
end;





function HCLIB:ConsoleMessage(mode, text)

    if mode == "error" then 

        MsgC( Color( 222, 23, 208), "[HCLIB]", Color(250,0,0), " - [ERROR] ", Color(255,255,255), text, "\n" );

    end;

    if mode == "info" then 

        MsgC( Color( 222, 23, 208), "[HCLIB]", Color(216,197,21), " - [INFO] ", Color(255,255,255), text, "\n" );

    end;
     
    if mode == "success" then 

        MsgC( Color( 222, 23, 208), "[HCLIB]", Color(64,244,14), " - [SUCCESS] ", Color(255,255,255), text, "\n" );

    end;

end;


--[[                     < -- LOADFUNCTIONS -- >                     ]]--

local function LoadFiles(dir)  

	local files = file.Find(dir.. "/".. "*", "LUA");

	for k, v in pairs(files) do

        if string.StartWith(v, "sh") then

			local load = include(dir.. "/".. v);

			if load then load() end;

			AddCSLuaFile(dir.. "/".. v);

		end;

        if string.StartWith(v, "cl") then

			if CLIENT then 

				local load = include(dir.. "/".. v);

				if load then load() end;

			end;

			AddCSLuaFile(dir.. "/".. v);
 
		end;
	
		if string.StartWith(v, "sv") then

			if SERVER then 

				local load = include(dir.. "/".. v);

				if load then load() end;
 
			end;

		end;

        HCLIB:ConsoleMessage( "success", " LoadedFile: " .. v)
	end;

end; 

local function LoadScripts()

    HCLIB:ConsoleMessage( "info", " Start Loading Scripts..." )

    local files, folder = file.Find( "hclib/scripts/*", "LUA" )

    for k, v in pairs( folder ) do 
    
        local succ, err = pcall( include, "hclib/scripts/" .. v .. "/setup/sh_load.lua" )
        
        local LoadFilesile, LoadFilesolder = file.Find( "hclib/scripts/" .. v .. "/setup/languages/*", "LUA" );

        if file.Exists( "hclib/scripts/" .. v .. "/setup/sh_load.lua", "LUA" ) then 
        
            AddCSLuaFile( "hclib/scripts/" .. v .. "/setup/sh_load.lua" );

            include( "hclib/scripts/" .. v .. "/setup/sh_load.lua" ); 
       
            HCLIB.FoundedScripts[err.Scriptindex] = true;
 
            if ( SERVER ) then 

                if not file.Exists( "hclib/scripts.json", "DATA" ) then 

                    file.CreateDir("hclib");

                    file.Write( "hclib/scripts.json", util.TableToJSON( {} ) );

                else 

                    local filer = util.JSONToTable(file.Read( "hclib/scripts.json", "DATA" ) ); 

                    if filer[err.Scriptindex] == false then 
                        
                        if HCLIB.Debugmode then 

                            HCLIB:ConsoleMessage( "info", err.Scriptindex .. " are disabled" )
                            
                        end; 
                        
                        continue; 
                    
                    elseif filer[err.Scriptindex] == true then  
                        
                        if HCLIB.Debugmode then 
                            
                            HCLIB:ConsoleMessage( "info", " loaded " .. err.Scriptindex .. " Normally" )

                        end; 
                    
                    else
                    
                        filer[err.Scriptindex] = true; 

                        file.Write( "hclib/scripts.json", util.TableToJSON( filer ) );

                        if HCLIB.Debugmode then 

                            HCLIB:ConsoleMessage( "info", " loaded " .. err.Scriptindex .. " and wrote again in the json " )

                        end;

                    end;
 
                end;

            end;
             
            HCLIB.Config.Language[ err.Scriptindex ] = {};


            for lang, data in pairs( file.Find( "hclib/scripts/" .. v .. "/setup/languages/*", "LUA" ) ) do 

                local code = string.upper( string.Left( data, 3 ) );
 
                if not HCLIB.SupportetLanguages[ code ] then continue end;

                local s, e = pcall( include, "hclib/scripts/" .. v .. "/setup/languages/" .. data  )
                
               HCLIB.Config.Language[ err.Scriptindex ][ code ] = e;
                
            end; 


            HCLIB.Scripts[ err.Scriptindex ] = {};
            
            err.LoadFiles()


            HCLIB:ConsoleMessage( "success", "Script: " .. err.Scriptindex .. " loaded" )

            HCLIB.ScriptBridge[ err.Scriptindex ] = err;
 
        end; 

    end;

end;


--[[                     < -- LOAD SECTOR -- >                     ]]--

HCLIB:ConsoleMessage( "info", " Start Loading")

LoadFiles( "hclib/sql" );

LoadFiles( "hclib/functions" );

LoadFiles( "hclib/gui" );

LoadFiles( "hclib/vgui" );

LoadFiles( "hclib/vgui/mainmenu" ); 

LoadFiles( "hclib/vgui/utils" );

LoadFiles( "hclib/core" );

LoadScripts();

if GAMEMODE then 

    LoadFiles( "hclib/sql" );

    LoadFiles( "hclib/functions" );

    LoadFiles( "hclib/gui" );
         
    LoadFiles( "hclib/vgui" );

    LoadFiles( "hclib/vgui/mainmenu" ); 

    LoadFiles( "hclib/vgui/utils" );
        
    LoadFiles( "hclib/core" );

    LoadScripts();

end;
 
local Initialize = function()
    
    LoadFiles( "hclib/sql" );

    LoadFiles( "hclib/functions" );

    LoadFiles( "hclib/gui" ); 
 
    LoadFiles( "hclib/vgui" );

    LoadFiles( "hclib/vgui/mainmenu" );
    
    LoadFiles( "hclib/vgui/utils" );
 
    LoadFiles( "hclib/core" ); 
 
    LoadScripts();

end; hook.Add( "Initialize", "_HCLib.Initialize", Initialize );

HCLIB.isInit = false; // IMPORTANT FOR FUNCTION, WICH RUN ONLY ONE TIME  

