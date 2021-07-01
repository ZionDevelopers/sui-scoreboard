--[[

SUI Scoreboard v2.6 by .Z. Dathus [BR] is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 - 2021 .Z. Dathus [BR] <http://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US.
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.6.3 - 2021-07-01 06:14 PM(UTC -03:00)

]]--

surface.CreateFont( "gmodtooltip", {font="Verdana", size=14, weight=500, antialiasing=true} )

--- DrawTooltip
local function DrawTooltip( )
	if not vgui.CursorVisible() then return end

	local tab = GAMEMODE.ToolTipData or {}
	
	local font = "gmodtooltip"
	local text = GetTooltipText()
	local x, y = gui.MousePos()
	local alpha = 255
		
	if not text then return end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	
	x = x - w / 2.0
	y = y - h - 50
	
	if ( y < 0 ) then y = y + 50 end
	if ( x - 8 < 5 ) then x = 5 + 8 end
	if ( x + w + 16 > ScrW() - 5 ) then x = ScrW() - 5 - w - 16 end	
	
	if tab.text ~= text then	
		tab.text = text
		tab.alpha = 0
		tab.yv = 50
		tab.start = RealTime()	
	end
	
	text = tab.text
	tab.alpha = math.Approach( tab.alpha, 255, (RealTime() - tab.start) * 500 )
	tab.yv = math.Approach( tab.yv, 0, (RealTime() - tab.start) * 10 )
	
	y = y + math.sin( RealTime() * 40 ) * tab.yv * 0.1
	
	alpha	= tab.alpha
	x 		= math.Round(x)
	y 		= math.Round(y)
	
	draw.RoundedBox( 8, x - 8 + 1, y - 4 + 1, w + 16, h + 9, Color( 0, 0, 0, alpha * 0.5 ) )
	draw.RoundedBox( 8, x - 8 + 2, y - 4 + 2, w + 18, h + 11, Color( 0, 0, 0, alpha * 0.25 ) )
	draw.RoundedBox( 8, x - 8 , y - 4, w + 16, h + 8, Color( 255, 250, 150, alpha ) )
		
	draw.SimpleText( text, font, x, y, Color( 40, 40, 20, alpha) )
	
	GAMEMODE.ToolTipData = tab
end

--- Draws on top of VGUI..
function GM:PostRenderVGUI()
	self.BaseClass:PostRenderVGUI()	
	DrawTooltip()
end