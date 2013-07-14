local PANEL = {}

--- DoClick
function PANEL:DoClick()
	if not self:GetParent().Player or LocalPlayer() == self:GetParent().Player then return end

	self:DoCommand( self:GetParent().Player )
	timer.Simple( 0.1, SuiScoreBoard.UpdateScoreboard())
end

--- Paint
function PANEL:Paint(w,h)	
	local bgColor = Color( 200,200,200,100 )

	if self.Selected then
		bgColor = Color( 135, 135, 135, 100 )
	elseif self.Armed then
		bgColor = Color( 175, 175, 175, 100 )
	end
	
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), bgColor )	
	draw.SimpleText( self.Text, "DefaultSmall", self:GetWide() / 2, self:GetTall() / 2, Color(0,0,0,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	return true
end

vgui.Register( "suispawnmenuadminbutton", PANEL, "Button" )

--- PlayerKickButton
PANEL = {}
PANEL.Text = "Kick"

vgui.Register( "suiplayerkickbutton", PANEL, "suispawnmenuadminbutton" )

--- PlayerPermBanButton
PANEL = {}
PANEL.Text = "PermBan"

vgui.Register( "suiplayerpermbanbutton", PANEL, "suispawnmenuadminbutton" )

--- PlayerPermBanButton
PANEL = {}
PANEL.Text = "1hr Ban"

vgui.Register( "suiplayerbanbutton", PANEL, "suispawnmenuadminbutton" )