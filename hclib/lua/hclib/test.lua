
--[[
-- Create The Subtable
HCLIB.Scripts.Test = {}

--Add all CSLua Files
AddCSLuaFile("hclib/test2.lua")

return { index = "Test",

-- return the function for hotloading the module
load = function()

    -- we need the Scoreboard for this Module
  --  if not Yolo.Config.LoadedModules["Scoreboard"] then
        -- return false, we dont wanna load the module because it will throw errors
        -- return the error message, why we dont want the module to be loaded
   --     return false, "Scoreboard not loaded"
  --  end


    -- loading the actuall module files
    if CLIENT then
        include("hclib/test2.lua")
    end

    
   if ( CLIENT ) then
    print("test2 loaded")
        hook.Add("HUDPaint", "HCLIB.Test", function()
            draw.SimpleText("HCLIB.Test", "DermaLarge", ScrW()/2, ScrH()/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end)
   end
    -- return true because the hotload was successfull
    HCLIB.LoadedScripts["Test"] = true
    return true
end,

-- return the unload function 
unload = function()

    -- remove the timer and the hooks we created in the module
   -- timer.Remove("Ka")
   if ( CLIENT ) then
        hook.Remove("HUDPaint", "HCLIB.Test")
        concommand.Remove("penner")
   end
    -- resetting the module table
    HCLIB.Scripts.Test = {}

    -- return true because the unload was successfull
    return true
end }
]]