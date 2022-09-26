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



local black = Color( 0, 0, 0, 255 );

local white = Color( 255, 255, 255 );

local red = Color( 250, 0, 0, 255 );

local BlueMain = Color( 22, 23, 35, 255 );

local BlueSecond = Color( 22, 23, 41, 255 )

local Purplemain = Color( 63, 15, 164, 255);


local PANEL = {}

function PANEL:Init()

	self:SetFont( "HCLib.VGUI.26" );

	self:SetTextColor( Color( 255, 255, 255 ) );

	self:SetContentAlignment( 5 );

	local PAC = self.AddChoice

	self.AddChoice = function (s, val, data, select, icon)

		PAC( s, val, data, select, icon );

		surface.SetFont( "HCLib.VGUI.26" );

		if ( #val > 13 ) then

			self:SetFont("HCLib.VGUI.22");

		end;

		return #self.Choices;

	end;

end;


function PANEL:ChooseOption( value, index )

	if ( self.Menu and !self.multiple ) then

		self.Menu:Remove();

		self.Menu = nil;

	end;

	if ( !self.multiple and value ) then

		self:SetText( value );

	end;

	self.selected = index;

	self:OnSelect(index, value, self.Data[index]);

	self.textCol = white;

	if (self.isChoice) then

		self.value = self:GetSelectedID() == 1;

	end;

end;

function PANEL:OpenMenu(pControlOpener)

	if ( pControlOpener && pControlOpener == self.TextEntry ) then
		
		return;

	end;

	if (#self.Choices == 0) then return end;

	if (IsValid(self.Menu)) then

		self.Menu:Remove();

		self.Menu = nil;

	end;

	local this = self;

	self.Menu = DermaMenu( false, self );

	function self.Menu:AddOption( strText, funcFunction )

        local pnl = vgui.Create( "DMenuOption", self );

        pnl:SetMenu( self );

        pnl:SetIsCheckable( true );

		if ( funcFunction ) then pnl.DoClick = funcFunction end;



        function pnl:OnMouseReleased( mousecode )

            DButton.OnMouseReleased( self, mousecode );

            if ( self.m_MenuClicking && mousecode == MOUSE_LEFT ) then

                self.m_MenuClicking = false;

            end;

        end;

        self:AddPanel(pnl);

        return pnl;

    end;

	for k, v in pairs( self.Choices ) do
		
		local option = self.Menu:AddOption( v, function() self:ChooseOption(v, k) end );

		function option:PerformLayout(w, h)

			self:SetTall(40);

		end;

		local this = self;
		

		option.Paint = function (self, w, h)

			// local dropdownParent = self:GetParent():GetParent():GetParent();

			if ( k == #this.Choices ) then


				draw.RoundedBoxEx( 12, 0, 0, w, h, Purplemain, false, false, true, true );

				draw.RoundedBoxEx( 12, 2, 0, w - 4, h - 1, ( self:IsHovered() and Purplemain ) or BlueSecond, false, false, true, true );
				
			else

				draw.RoundedBox( 0, 0, 0, w, h, Purplemain );

				draw.RoundedBox( 0, 2, 0, w - 4, h, ( self:IsHovered() and Purplemain ) or BlueSecond );

			end;

			draw.SimpleText( v, "HCLib.VGUI.20", w / 2, h / 2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
			
			return true;

		end;

	end;

	local x, y = self:LocalToScreen( 5, self:GetTall() );

	self.Menu:SetMinimumWidth( self:GetWide() - 19 );

	self.Menu:Open( x + 4, y - 1.5, false, self );

	self.Menu.Paint = nil;

end;

function PANEL:Paint(w, h)

	draw.RoundedBox( 15, 0, 0, w, h, Purplemain );

	draw.RoundedBox( 15, 2, 2, w - 4, h - 4, BlueSecond );

end;

vgui.Register("HCLIB.ComboBox", PANEL, "DComboBox");
