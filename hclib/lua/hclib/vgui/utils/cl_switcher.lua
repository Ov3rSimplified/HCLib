
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

--[[ < ------- ( - LOCALS - ) ------- > ]]--

local PANEL = {};

local on_color  = Color(70,168,53);

local off_color = Color(216,75,75);

local BlueMain = Color( 22, 23, 35, 255 );

local BlueSecond = Color( 22, 23, 41, 255 );

local Purplemain = Color( 63, 15, 164, 255);

local switch_width = 40;

local switch_height = 20;

local label_margin = 7;

--[[ < ------- ( - NEEDED FUNCTION - ) ------- > ]]--

local function Circle( x, y, radius, seg )

	local cir = {};

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } );

	for i = 0, seg do

		local a = math.rad( ( i / seg ) * -360 );

		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } );

	end;

	local a = math.rad( 0 );

	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } );

	return cir;

end;

--[[ < ------- ( - PANEL - ) ------- > ]]--

function PANEL:Init()
	self.LeftCircle = false;

	self.RightCircle = false;

	self.Active = false;

	self.ColorInterpolation = HCLIB:LerpColor(off_color, off_color, .25);

	self.SwitchInterpolation = HCLIB:Lerp(switch_height / 2, switch_height / 2, .25);


	self.Label = vgui.Create("DLabel", self);

	self.Label:SetContentAlignment(4);

	self.Label:SetFont("HCLib.VGUI.25");

	self.Label:SetTextColor(Color(255,255,255));

	self:SetText("Switch");


	self.ClickableArea = vgui.Create("DPanel", self);

	self.ClickableArea:SetMouseInputEnabled(true);

	self.ClickableArea:SetCursor("hand");


	function self.ClickableArea.Paint(self,w,h)

		return;

	end;


	function self.ClickableArea:OnMouseReleased(m)

		if (m ~= MOUSE_LEFT) then return end;

		local checked = not self:GetParent().Active;

		self:GetParent():SetChecked(checked, true);

		if (self:GetParent().OnChange) then

			self:GetParent():OnChange();

		end;

	end;

end;


function PANEL:PerformLayout()

	self.ClickableArea:SetSize(switch_width + label_margin + self.Label:GetWide() + label_margin, switch_height);

end;


function PANEL:SetText(text)

	self.Text = text;
 
	self.Label:SetText(text);

	self.Label:SizeToContents();

	self.Label:AlignLeft(switch_width + label_margin);

	self.Label:SizeToContents();

	self:SetSize(switch_width + label_margin + self.Label:GetWide(), switch_height);

	self.Label:CenterVertical();

end;


function PANEL:GetText(text)

	return self.Text;

end;


function PANEL:Paint(w)

	if !self.LeftCircle or !self.RightCircle then

		self.LeftCircle = Circle(switch_height / 2, switch_height / 2, switch_height / 2,20);

		self.RightCircle = Circle(switch_width - switch_height / 2, switch_height / 2, switch_height / 2,20);

	end;


	self.ColorInterpolation:DoLerp();

	self.SwitchInterpolation:DoLerp();

	surface.SetDrawColor(self.ColorInterpolation:GetColor());

	draw.NoTexture();

	surface.DrawPoly(self.LeftCircle);

	surface.DrawPoly(self.RightCircle);

	surface.DrawRect(switch_height / 2, 0, switch_width - switch_height, switch_height);

	surface.SetDrawColor(255, 255, 255);

	surface.DrawPoly(Circle(self.SwitchInterpolation:GetValue(), switch_height / 2, switch_height / 2 - 2,20));


	local ww, hh, txtt, clr = 0, 0, "", nil;

	if ( self:GetChecked() ) then 

		ww = switch_height / 2 - 5;

		hh = switch_height / 2 - 11;

		txtt = "✓";

		clr = Color(255,255,255);
	else 

		ww = switch_width / 2 + 3;

		hh = switch_height / 2 -11;

		txtt = "X";

		clr = Color(255,255,255);

	end;

	draw.SimpleText(txtt, "HCLib.VGUI.20", ww, hh, clr, TEXT_ALIGN_LEFT );

end;

function PANEL:SetChecked(active, animate)

	if (self.Disabled) then return end;

	self.Active = active;

	local from;

	local to;

	if ( active ) then

		from = switch_height / 2;

		to = switch_width - (switch_height / 2);

	else

		from = switch_width - (switch_height / 2);

		to = switch_height / 2;

	end;


	if ( animate ) then

		self.SwitchInterpolation:SetTo(to);

		self.ColorInterpolation:SetTo(active and on_color or off_color);

	else

		self.SwitchInterpolation = HCLIB:Lerp(to, to, .25);

		if (active) then

			self.ColorInterpolation = HCLIB:LerpColor(on_color, on_color, .25);

		else

			self.ColorInterpolation = HCLIB:LerpColor(off_color, off_color, .25);
		end;

	end;

end;

function PANEL:GetChecked()

	return self.Active;

end;

function PANEL:SetHelpText(text)

	self.HelpLabel = vgui.Create("DLabel", self);

	self.HelpLabel:SetTextColor(Color(200,200,200));

	self.HelpLabel:SetAutoStretchVertical(true);

	self.HelpLabel:SetWrap(true);

	self.HelpLabel:SetFont("HCLib.VGUI.15");

	self.HelpLabel:AlignTop(switch_height + 10);

	self.HelpLabel:SetText(text);

	function self.HelpLabel:PerformLayout()

		local w = math.min(500, self:GetParent():GetWide());

		if (self:GetWide() ~= w) then

			self:SetWide(w);

		end;

		self:GetParent():SetSize(switch_width + label_margin + self:GetParent().Label:GetWide(), switch_height + 10 + self:GetTall());

	end;

end;


function PANEL:SetDisabled(disabled)

	self.Disabled = disabled;

	if (self.Disabled) then

		self.ColorInterpolation:SetColor(Color(165,165,165));

		self.Label:SetTextColor(Color(180,180,180));

		self.ClickableArea:SetCursor("no");

	else

		self.ClickableArea:SetCursor("hand");

		self.Label:SetTextColor(Color(255,255,255));

		if (self:GetChecked()) then

			self.ColorInterpolation:SetColor(on_color);

		else

			self.ColorInterpolation:SetColor(off_color);

		end;

	end;

end;


function PANEL:GetDisabled()

	return self.Disabled;

end;

derma.DefineControl("HCLIB.Switch", nil, PANEL, "DPanel");