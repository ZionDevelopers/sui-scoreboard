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
Version 2.7 - 2023-06-06 8:00 PM(UTC -03:00)

]]--

local PANEL = {}

--- Init
function PANEL:Init()
	self.pnlCanvas 	= vgui.Create( "Panel", self )
	self.YOffset = 0
end

--- GetCanvas
function PANEL:GetCanvas()
  return self.pnlCanvas
end

--- OnMouseWheeled
function PANEL:OnMouseWheeled( dlta )

	local MaxOffset = self.pnlCanvas:GetTall() - self:GetTall()
	if MaxOffset > 0 then	
		self.YOffset = math.Clamp( self.YOffset + dlta * -100, 0, MaxOffset )		
	else		
		self.YOffset = 0	
	end
	
	self:InvalidateLayout()	
end

--- PerformLayout

function PANEL:PerformLayout()
	self.pnlCanvas:SetPos( 0, self.YOffset * -1 )
	self.pnlCanvas:SetSize( self:GetWide(), self.pnlCanvas:GetTall() )
end

vgui.Register( "suiplayerframe", PANEL, "Panel" )