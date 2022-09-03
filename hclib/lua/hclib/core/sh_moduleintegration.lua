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
/*

if ( SERVER ) then 
    util.AddNetworkString("HCLIB.ScriptSet")
    util.AddNetworkString("HCLIB.SnychScriptEnabled")

    net.Receive("HCLIB.ScriptSet", function(len,ply)
        
        --[[ < - Data - > ]]--

            local kind = net.ReadString();

            local name = net.ReadString();

            local tbl = net.ReadTable();

            PrintTable(tbl)

        --[[ < - Execute - > ]]--
  
        if kind == "Load" then 

            if file.Exists("hclib/scripts.json", "DATA") then
                local rt = util.JSONToTable(file.Read("hclib/scripts.json"));
                local tr = {}
                tr = rt

                tr[name] = true 

                file.Write("hclib/scripts.json", util.TableToJSON(tr));

            else

                local rt = {};

                rt[name] = true;

                file.Write("hclib/scripts.json", util.TableToJSON(rt));
                
            end;

            HCLIB.LoadedScripts[name] = true;

            local func = CompileString(tbl.load["SERVER"], "Load");

            func();

            net.Start("HCLIB.ScriptSet");

                net.WriteString(kind);

                net.WriteString(name);
        
                net.WriteTable(tbl);

            net.Broadcast();

        end;

        if kind == "Unload" then 

            if file.Exists("hclib/scripts.json", "DATA") then
                local rt = util.JSONToTable(file.Read("hclib/scripts.json"));

                rt[name] = false;

                file.Write("hclib/scripts.json", util.TableToJSON(rt));
            end;

            HCLIB.LoadedScripts[name] = false;

            local func = CompileString(tbl.unload["SERVER"], "Load");

            func();
            
            net.Start("HCLIB.ScriptSet");

                net.WriteString(kind);

                net.WriteString(name);
        
                net.WriteTable(tbl);

            net.Broadcast();
            
        end;

    end);

 else

    net.Receive("HCLIB.ScriptSet", function(len,ply)
        
        --[[ < - Data - > ]]--

        local kind = net.ReadString();

        local name = net.ReadString();

        local tbl = net.ReadTable();

        --[[ < - Execute - > ]]--

        if kind == "Load" then 

            HCLIB.LoadedScripts[name] = true;

            local func = CompileString(tbl.load["CLIENT"], "Load");

            func();

        end;
        
        if kind == "Unload" then 

            HCLIB.LoadedScripts[name] = true;

            local func = CompileString(tbl.unload["CLIENT"], "Load");

            func();

        end;

    end);

end;

if ( SERVER ) then 
 
    net.Receive("HCLIB.SnychScriptEnabled", function()

        if file.Exists("hclib/scripts.json", "DATA") then 

            local read = util.JSONToTable( file.Read( "hclib/scripts.json", "DATA" ) );
        
            if table.IsEmpty(read) then HCLIB.Scripts._MangagedScripts = false; else
                HCLIB.Scripts._MangagedScripts = read
            end;

            PrintTable(HCLIB.Scripts._MangagedScripts)

        else

            file.Write( "hclib/scripts.json", util.TableToJSON({}) );

            HCLIB.Scripts._MangagedScripts = false;

        end;
        
    end);

 else

    net.Receive("HCLIB.SnychScriptEnabled", function()

        HCLIB.Scripts._MangagedScripts = net.ReadTable();

    end);

end; 
*/
--[[         < ---------- (Main Function) ---------- >          ]]--
--|| @name = STRING / Scriptname(the same like the Script Folder)
--|| @ekind = STRING / ("Load"/"Unload") DONT USE OTHER!!
--[[
function HCLIB:ScriptSet( name, ekind )

    if HCLIB.FoundedScripts[name] then else HCLIB:ConsoleMessage("error", "Script not Found!") return end;
    
    if ekind == "Load" or ekind == "Unload" then else  HCLIB:ConsoleMessage("error", "Executkind not availible") return end;

    local bool, data = pcall( include, "hclib/scripts/" .. name .. "/sh_load.lua" );
    
    if not bool then return end;


    if ekind == "Load" then

        local loadsh = CompileString(data.load["SHARED"], name.."sh");
 
        loadsh();

    end;

    if ekind == "Unload" then 

        local unloadsh = CompileString(data.unload["SHARED"], name.."sh");

        unloadsh();

    end;

    net.Start("HCLIB.ScriptSet");

        net.WriteString(ekind);

        net.WriteString(name);

        net.WriteTable(data);

    net.SendToServer();

end; 

local Preloadscripts = function()
    

     local files, folder = file.Find( "hclib/scripts/*", "LUA" );

     for k, v in pairs( folder ) do 
 
         local succ, err = pcall( include, "hclib/scripts/" .. v .. "/sh_load.lua" )
 
 
         if SERVER then 
 
             local svl, svu = CompileString(err.load["SERVER"], v.."svl"), CompileString(err.unload["SERVER"], v.."svu")
             svl();
             svu();
 
         else
 
             local cll, clu = CompileString(err.load["CLIENT"], v.."cll"), CompileString(err.unload["CLIENT"], v.."clu")
             cll();
             clu();
 
         end;
 
         local shl, shu = CompileString(err.load["SHARED"], v.."shl"), CompileString(err.unload["SHARED"], v.."shu")
         shl();
         shu();
     end;

end;

local Scripts = function()

    local files, folder = file.Find( "hclib/scripts/*", "LUA" );
 
    if CLIENT then 

        net.Start("HCLIB.SnychScriptEnabled");
 --
        net.SendToServer();

    end;
            
    local startime = SysTime();

    for k, v in pairs( folder ) do 

        local succ, err = pcall( include, "hclib/scripts/" .. v .. "/sh_load.lua" )

        print(err.index)
        
        if ( SERVER ) then 

            local sfunc = CompileString( err.load["SERVER"], v.."svdcg" );
            
            if HCLIB.Scripts._MangagedScripts[err.index] then sfunc() end; 

            print("pl", HCLIB.Scripts._MangagedScripts[err.index])

             
        else
            
            local cfunc = CompileString( err.load["CLIENT"], v.."cler5tg" );
            
            if HCLIB.Scripts._MangagedScripts[err.index] then cfunc() end;

        end;


        local shfunc = CompileString( err.load["SHARED"], v.."shegdss" );

        if HCLIB.Scripts._MangagedScripts[err.index] then shfunc()   end;

        MsgC( Color( 222, 23, 208), "[HCLIB]", Color( 255, 255, 255 ), " Loaded Script: ", Color( 0, 255, 0 ), err.index, "\n" ); 

    end; 

end;

Scripts()

hook.Add("Initialize", "HCLIB.LoadScripts", function()
    Scripts()
    print(os.date( "%X" ) .. " INITIALIZE")
end )

hook.Add("InitPostEntity", "HCLIB.InitPostentity", function()
    Scripts()
    print(os.date( "%X" ) .. " INITPOSTENTITY")

end)
]]
/*

local scommand = function(ply, cmd, args)
    
    if ply:IsSuperAdmin() then

        if args[2] == "Load" then 

            if HCLIB.FoundedScripts[args[1]] then 

                HCLIB:ScriptSet( args[1], "Load" );

            end;

        end;

        if args[2] == "Unload" then

            if HCLIB.FoundedScripts[args[1]] then 

                HCLIB:ScriptSet( args[1], "Unload" );
                
            end;

        end;

    end;
    
end; concommand.Add( "ScriptsSet", scommand ) 
*/


