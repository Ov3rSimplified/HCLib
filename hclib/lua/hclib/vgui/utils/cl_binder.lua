
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



local PANEL = {}

local white = Color( 255, 255, 255 );

local red = Color( 250, 0, 0, 255 );

local BlueMain = Color( 22, 23, 35, 255 );

local BlueSecond = Color( 22, 23, 41, 255 )

local Purplemain = Color( 63, 15, 164, 255);

local color = Color( Purplemain["r"], Purplemain["g"], Purplemain["b"], 20 );

local trad, speed, speed2 = 360, 4, 12;

local Rad, Alpha, ClickX, ClickY = 0, 0, 0, 0;

local font = "HCLib.VGUI.30";			

function PANEL:Init()

	self.BadKeys = {};

	self:SetSelectedNumber( 0 )

	self:SetSize( 60, 30 )

	self:SetFont( font )

	self:SetTextColor( white );

end

function PANEL:UpdateText()

	local str = input.GetKeyName( self:GetSelectedNumber() )

	if ( !str ) then str = "NONE" end

	str = language.GetPhrase( str )

	self:SetText( str )

end

function PANEL:DoClick()

	ClickX, ClickY = self:CursorPos();

	Rad = 0;

	Alpha = color["a"];

	self:SetText( HCLIB:L( "main", "vgui.binder.pressakey" ) )

	input.StartKeyTrapping()
	
	self.Trapping = true

end

function PANEL:DoRightClick()

	self:SetText( "NONE" )

	self:SetValue( 0 )

end

function PANEL:SetSelectedNumber( iNum )

	self.m_iSelectedNumber = iNum

	self:ConVarChanged( iNum )

	self:UpdateText()

	self:OnChange( iNum )

end

function PANEL:Think()

	if ( input.IsKeyTrapping() && self.Trapping ) then

		local code = input.CheckKeyTrapping()

		if ( code ) then

			if ( code == KEY_ESCAPE ) then

				self:SetValue( self:GetSelectedNumber() )

			else

				self:SetValue( code )

			end

			self.Trapping = false

		end

	end

	if self.Trapping == true or self:GetValue() == 0 then 

		self:SetFont( "HCLib.VGUI.15" )

	else

		self:SetFont( font )

	end

	self:ConVarNumberThink()

end

function PANEL:SetValue( iNumValue )

	self:SetSelectedNumber( iNumValue )

end

function PANEL:SetBadKey( key )

	// local code = input.CheckKeyTrapping()?

	self.BadKeys[ key ] = true;
	
end

function PANEL:GetValue()

	return self:GetSelectedNumber()

end

function PANEL:OnChange()
end


function PANEL:Paint( w, h )
	
	draw.RoundedBox( 15, 0, 0, w, h, Purplemain );

	draw.RoundedBox( 15, 2, 2, w - 4, h - 4, BlueSecond );

	if ( Alpha >= 1 ) then

		surface.SetDrawColor( Color( Purplemain["r"], Purplemain["g"], Purplemain["b"], 20 ) );

		draw.NoTexture();

		draw.DrawCircle( ClickX, ClickY, Rad, color );

		Rad = Lerp( FrameTime() * speed, Rad, trad || w );

		Alpha = Lerp( FrameTime() * speed2, Alpha, 0 );

	end;

end;

vgui.Register( "HCLIB.Binder", PANEL, "DBinder" )