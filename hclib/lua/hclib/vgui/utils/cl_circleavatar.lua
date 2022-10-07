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
]]


local PANEL = {};

local cos, sin, rad = math.cos, math.sin, math.rad;

AccessorFunc( PANEL, "m_masksize", "MaskSize", FORCE_NUMBER );

function PANEL:Init()

    self.Avatar = vgui.Create( "AvatarImage", self );

    self.Avatar:SetPaintedManually( true );

	self:SetMaskSize( self:GetWide() / 2 );

end;

function PANEL:PerformLayout()

    self.Avatar:SetSize( self:GetWide(), self:GetTall() );

end;

function PANEL:SetPlayer( id )

	self.Avatar:SetPlayer( id, self:GetWide() );

end;

function PANEL:Paint( w, h )

    render.ClearStencil();

    render.SetStencilEnable( true );

    render.SetStencilWriteMask( 1 );

    render.SetStencilTestMask( 1 );

    render.SetStencilFailOperation( STENCILOPERATION_REPLACE );

    render.SetStencilPassOperation( STENCILOPERATION_ZERO );

    render.SetStencilZFailOperation( STENCILOPERATION_ZERO );

    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_NEVER );

    render.SetStencilReferenceValue( 1 );

	local _m = self.m_masksize;

	local circle, t = {}, 0;

    for i = 1, 360 do

        t = rad( i * 720 ) / 720;

        circle[ i ] = { x = w / 2 + cos( t ) * _m, y = h / 2 + sin( t ) * _m };

    end;

	draw.NoTexture();

	surface.SetDrawColor( color_white );

	surface.DrawPoly( circle );

    render.SetStencilFailOperation( STENCILOPERATION_ZERO );

    render.SetStencilPassOperation( STENCILOPERATION_REPLACE );

    render.SetStencilZFailOperation( STENCILOPERATION_ZERO );

    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL );

    render.SetStencilReferenceValue( 1 );

    self.Avatar:SetPaintedManually( false );

    self.Avatar:PaintManual();

    self.Avatar:SetPaintedManually( true );

    render.SetStencilEnable( false );

    render.ClearStencil();

end

vgui.Register( "HCLIB.CircleAvatar", PANEL );