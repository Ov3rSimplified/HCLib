
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

HCLIB = HCLIB or {}

HCLIB.Scripts = HCLIB.Scripts  or {}

HCLIB.FoundedScripts = HCLIB.FoundedScripts  or {}

HCLIB.ScriptManaged = HCLIB.ScriptManaged or {}

HCLIB.ScriptBridge = HCLIB.ScriptBridge or {}

HCLIB.Config = HCLIB.Config or {}

HCLIB.SupportetLanguages = {
    ["GER"] = true,
    ["ENG"] = true,
    ["ESP"] = true,
    ["JAP"] = true,
}

HCLIB.Debugmode = true; 


--[[                     < -- LOADFUNCTIONS -- >                     ]]--

local LoadFiles = function(dir)  

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

	end;

end;

local LoadScripts = function()

    local files, folder = file.Find( "hclib/scripts/*", "LUA" );

    for k, v in pairs( folder ) do 

        local succ, err = pcall( include, "hclib/scripts/" .. v .. "/sh_load.lua" )

        if file.Exists( "hclib/scripts/" .. v .. "/sh_load.lua", "LUA" ) then 
        
            AddCSLuaFile( "hclib/scripts/" .. v .. "/sh_load.lua" );

            include( "hclib/scripts/" .. v .. "/sh_load.lua" ); 
       
            HCLIB.FoundedScripts[err.Scriptindex] = true;
 
            if ( SERVER ) then 

                if not file.Exists( "hclib/scripts.json", "DATA" ) then 

                    file.CreateDir("hclib");

                    file.Write( "hclib/scripts.json", util.TableToJSON( {} ) );

                else 

                    local filer = util.JSONToTable(file.Read( "hclib/scripts.json", "DATA" ) ); 

                    if filer[err.Scriptindex] == false then 
                        
                        if HCLIB.Debugmode then 
                            
                            print(err.Scriptindex .. " 1");
                        
                        end; 
                        
                        continue; 
                    
                    elseif filer[err.Scriptindex] == true then  
                        
                        if HCLIB.Debugmode then 
                            
                            print(err.Scriptindex .. " 0");
                        
                        end; 
                    
                    else
                    
                        print(err.Scriptindex .. " infile");

                        filer[err.Scriptindex] = true; 

                        file.Write( "hclib/scripts.json", util.TableToJSON( filer ) );

                    end;
 
                end;

            end;

            HCLIB.Scripts[err.Scriptindex] = {};

            err.LoadFiles()

            if SERVER then 

                --err.

            end;

            HCLIB.ScriptBridge[err.Scriptindex] = err;
 
        end;

    end;

end;



local lf = LoadFiles;

--[[                     < -- LOAD SECTOR -- >                     ]]--

lf( "hclib/functions" );

lf( "hclib/gui" );

lf( "hclib/sql" );

lf( "hclib/vgui" );

lf( "hclib/vgui/mainmenu" ); 

lf( "hclib/vgui/utils" );

lf( "hclib/core" );

LoadScripts();

if GAMEMODE then 

    lf( "hclib/functions" );

    lf( "hclib/gui" );
    
    lf( "hclib/sql" );
    
    lf( "hclib/vgui" );

    lf( "hclib/vgui/mainmenu" );

    lf( "hclib/vgui/utils" );
        
    lf( "hclib/core" );

    LoadScripts();

end;
 
local Initialize = function()

    lf( "hclib/functions" );

    lf( "hclib/gui" );

    lf( "hclib/sql" );

    lf( "hclib/vgui" );

    lf( "hclib/vgui/mainmenu" );
    
    lf( "hclib/vgui/utils" );

    lf( "hclib/core" ); 
 
    LoadScripts();

end; hook.Add( "Initialize", "_HCLib.Initialize", Initialize );

HCLIB.isInit = false; // IMPORTANT FOR FUNCTION, WICH RUN ONLY ONE TIME