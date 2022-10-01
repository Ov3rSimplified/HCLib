
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

file.CreateDir( "hclib/cache/img" );

file.CreateDir( "hclib/cache/img" );
    
HCLIB.CachedImgurImage = HCLIB.CachedImgurImage or {}

function HCLIB:GetImgurImage( ImgurID )

    if HCLIB.CachedImgurImage[ ImgurID ] then

        return HCLIB.CachedImgurImage[ ImgurID ];

    elseif file.Exists( "hclib/cache/img/" .. ImgurID .. ".png", "DATA" ) then

        HCLIB.CachedImgurImage[ ImgurID ] = Material( "data/hclib/cache/img/" .. ImgurID .. ".png", "noclamp smooth" );

    else
        http.Fetch( "https://i.imgur.com/" .. ImgurID .. ".png", function( Body, Len, Headers )
            
            file.Write( "hclib/cache/img/" .. ImgurID .. ".png", Body );

            HCLIB.CachedImgurImage[ ImgurID ] = Material( "data/hclib/cache/img/" .. ImgurID .. ".png", "noclamp smooth");

        end);

    end;

    return HCLIB.CachedImgurImage[ ImgurID ];

end;