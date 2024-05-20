--[[

SUI Scoreboard v2.6 by Dathus [BR] is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 - 2024 Dathus [BR] <http://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit <http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US> .
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.7 - 2023-06-05 8:00 PM(UTC -03:00)

]]--

local PANEL = {}

--- DoClick
function PANEL:DoClick()
	if not self:GetParent().Player or LocalPlayer() == self:GetParent().Player then return end

	self:DoCommand( self:GetParent().Player )
	timer.Simple( 0.1, Scoreboard.vgui.UpdateScoreboard())
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