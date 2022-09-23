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



--[[ < ---------- ( VGUI CREATION ) ---------- > ]]

function HCLIB:RegisterVGUI( Index, panel, base  )
    
    vgui.Register( "hclib_" .. Index, panel, base);

end;

function HCLIB:DefineVguiElement( Index, description, tab, base )
    
    derma.DefineControl( "hclib_" .. Index, description, tab, base);

end;



--[[ < ---------- ( DEBUGGING ) ---------- > ]]
// Colors
local purple = Color(255,0,230);

local red = Color(235,12,12);

local white = Color(255,255,255);

local blue = Color(12,164,235);

local green = Color(6,241,29);

local orange = Color(255,102,0);

local yellow = Color(212,255,0);


function HCLIB:Errorlog( difficulty, title, description, fixtext )

    MsgC( "\n\n\n\n\n\n[[ < ---------- ( ERROR LOG ) ---------- > ]]\n " );

    MsgC( Color(255,0,230), " - [HCLIB] ", white, " RECEIVED AN ERROR!!! \n");
    MsgC( yellow, "  - Difficulty: ", difficulty == 1 and green or difficulty == 2 and orange or difficulty == 3 and red or white, difficulty == 1 and "low" or difficulty == 2 and "medium" or difficulty == 3 and "hard" or "N/A", "\n\n"  );
    MsgC( white, " - " .. title or "N/A", "\n" );

 

end
--HCLIB:Errorlog( 1, "Your Console has an error!", description, fixtext )



--[[ < ---------- ( SWITCH ) ---------- > ]]

function HCLIB:Switch( var, cases, default )

    if not isstring( var ) then return end;

    if not istable( cases ) then return end;

    if table.IsEmpty( cases ) then return end;

    if table.IsSequential( cases ) then return end;


    if cases[var] then 

        cases[var]();

    else

        if default then 

            default();

        else

            return;

        end;
        
    end;

end;

 

/*
HCLIB:Switch( variablemabler, {

    ["1"] = function()

        print("Akemat");
    
    end,
    
    ["2"] = function()
    
        print("Tameka")
    
    end,

}, function()
    
    print( "Keine Tamy oda Akemy :C " );

end )
*/