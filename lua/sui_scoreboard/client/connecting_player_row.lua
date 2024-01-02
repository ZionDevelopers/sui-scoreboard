--[[

SUI Scoreboard v2.6 by .Z. Dathus [BR] is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 - 2024 Dathus [BR] <http://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US.
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.6.4 - 2023-05-25 2:19 PM(UTC -03:00)

]]--

local texGradient = surface.GetTextureID( "gui/center_gradient" )

local PANEL = {}

--- Paint
function PANEL:Paint(w,h)

	local color = Color( 100, 100, 100, 155 )

	if self.Open or self.Size ~= self.TargetSize then	
		draw.RoundedBox( 4, 18, 16, self:GetWide()-36, self:GetTall() - 16, color )
		draw.RoundedBox( 4, 20, 16, self:GetWide()-40, self:GetTall() - 16 - 2, Color( 225, 225, 225, 150 ) )
		
		surface.SetTexture( texGradient )
		surface.SetDrawColor( 255, 255, 255, 100 )
		surface.DrawTexturedRect( 20, 16, self:GetWide()-40, self:GetTall() - 16 - 2 ) 	
	end
	
	draw.RoundedBox( 4, 18, 0, self:GetWide()-36, 38, color )
	
	surface.SetTexture( texGradient )
	surface.SetDrawColor( 255, 255, 255, 150 )
	surface.DrawTexturedRect( 0, 0, self:GetWide()-36, 38 ) 
		
	return true
end

--- SetPlayer
function PANEL:SetPlayer( plyName, playerId, playerId64 )
	self.PlayerName = plyName
	self.PlayerId = playerId
	self.PlayerId64 = playerId64
	self:UpdatePlayerData()	
	--self.imgAvatar:SetPlayer( playerId )
end

--- UpdatePlayerData
function PANEL:UpdatePlayerData()
	self.lblName:SetText( self.PlayerName )
	self.lblTeam:SetText( "Connecting" )

	self.lblHours:SetText( "" )
	self.lblHealth:SetText( "" )
	self.lblFrags:SetText( "" )
	self.lblDeaths:SetText( "" )
	self.lblPing:SetText( "" )
	
	self.lblMute:SetImage( "icon32/unmuted.png" )

    self.lblRatio:SetText( "" )
end

--- Int
function PANEL:Init()
	self.Size = 154--38
	self:OpenInfo( false )	
	self.infoCard	= vgui.Create( "suiscoreplayerinfocard", self )
	
	self.lblName = vgui.Create( "DLabel", self )
	self.lblTeam = vgui.Create( "DLabel", self )
	self.lblHours = vgui.Create( "DLabel", self )
	self.lblHealth = vgui.Create( "DLabel", self )
	self.lblFrags = vgui.Create( "DLabel", self )
	self.lblDeaths = vgui.Create( "DLabel", self )
	self.lblRatio = vgui.Create( "DLabel", self )
	self.lblPing = vgui.Create( "DLabel", self )
	self.lblMute = vgui.Create( "DImageButton", self)
	self.imgAvatar = vgui.Create("AvatarImage", self)
	self.lblAvatarFix = vgui.Create( "DLabel", self )
	self.lblAvatarFix:SetText("")
	self.lblAvatarFix:SetCursor( "hand" )
	self.lblAvatarFix.DoClick = function  () gui.OpenURL("http://steamcommunity.com/profiles/" .. self.PlayerId64) end
	
	-- If you don't do this it'll block your clicks
	self.lblName:SetMouseInputEnabled( false )
	self.lblTeam:SetMouseInputEnabled( false )
	self.lblHours:SetMouseInputEnabled( false )
	self.lblHealth:SetMouseInputEnabled( false )
	self.lblFrags:SetMouseInputEnabled( false )
	self.lblDeaths:SetMouseInputEnabled( false )
	self.lblRatio:SetMouseInputEnabled( false )
	self.lblPing:SetMouseInputEnabled( false )
	self.imgAvatar:SetMouseInputEnabled( false )
	self.lblMute:SetMouseInputEnabled( true )
	self.lblAvatarFix:SetMouseInputEnabled( true )
end

--- ApplySchemeSettings
function PANEL:ApplySchemeSettings()
	self.lblName:SetFont( "suiscoreboardplayername" )
	self.lblTeam:SetFont( "suiscoreboardplayername"  )
	self.lblHours:SetFont( "suiscoreboardplayername"  )
	self.lblHealth:SetFont( "suiscoreboardplayername"  )
	self.lblFrags:SetFont( "suiscoreboardplayername"  )
	self.lblDeaths:SetFont( "suiscoreboardplayername"  )
	self.lblRatio:SetFont( "suiscoreboardplayername"  )
	self.lblPing:SetFont( "suiscoreboardplayername"  )
	self.lblAvatarFix:SetFont( "suiscoreboardplayername"  ) 
	
	local namecolor = Color(0,0,0,255)
	
	self.lblName:SetColor( namecolor )
	self.lblTeam:SetColor( namecolor )
	self.lblHours:SetColor( namecolor )
	self.lblHealth:SetColor( namecolor )
	self.lblFrags:SetColor( namecolor )
	self.lblDeaths:SetColor( namecolor )
	self.lblRatio:SetColor( namecolor )
	self.lblPing:SetColor( namecolor)
	self.lblAvatarFix:SetColor( namecolor)
	
	self.lblName:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblTeam:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblHours:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblHealth:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblFrags:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblDeaths:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblRatio:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblPing:SetFGColor( Color( 0, 0, 0, 255 ) )
	self.lblAvatarFix:SetFGColor( Color( 0, 0, 0, 0 ) )
end

--- DoClick
function PANEL:DoClick()
	if self.Open then
		surface.PlaySound( "ui/buttonclickrelease.wav" )
	else
		surface.PlaySound( "ui/buttonclick.wav" )
	end

	self:OpenInfo( false )
end

--- OpenInfo
function PANEL:OpenInfo( bool )
	if bool then
		self.TargetSize = 154
	else
		self.TargetSize = 38
	end
	
	self.Open = bool
end

--- Think
function PANEL:Think()
	if self.Size ~= self.TargetSize then	
		self.Size = self.TargetSize
		self:PerformLayout()
		Scoreboard.vgui:InvalidateLayout()
	end
	
	if not self.PlayerUpdate or self.PlayerUpdate < CurTime() then	
		self.PlayerUpdate = CurTime() + 0.5
		self:UpdatePlayerData()		
	end
end

--- PerformLayout
function PANEL:PerformLayout()
	self:SetSize( self:GetWide(), self.Size ) 
	
	self.lblName:SizeToContents()
	self.lblName:SetPos( 60, 3 )
	self.lblTeam:SizeToContents()	
	self.lblMute:SetSize(32,32)
	self.lblHours:SizeToContents()
	
	self.imgAvatar:SetPos( 21, 4 ) 
 	self.imgAvatar:SetSize( 32, 32 )
 	self.lblAvatarFix:SetPos( 21, 4 ) 
 	self.lblAvatarFix:SetSize( 32, 32 )

	local COLUMN_SIZE = 45
	
	self.lblMute:SetPos( self:GetWide() - COLUMN_SIZE - 8, 0 )
	self.lblPing:SetPos( self:GetWide() - COLUMN_SIZE * 2, 0 )
	self.lblRatio:SetPos( self:GetWide() - COLUMN_SIZE * 3.4, 0 )
	self.lblDeaths:SetPos( self:GetWide() - COLUMN_SIZE * 4.4, 0 )
	self.lblFrags:SetPos( self:GetWide() - COLUMN_SIZE * 5.4, 0 )
	self.lblHealth:SetPos( self:GetWide() - COLUMN_SIZE * 6.4, 0 )
	self.lblHours:SetPos( self:GetWide() - COLUMN_SIZE * 10.3, 0 )
	self.lblTeam:SetPos( self:GetWide() - COLUMN_SIZE * 13.2, 3 )
	
	if self.Open or self.Size ~= self.TargetSize then	
		self.infoCard:SetVisible( true )
		self.infoCard:SetPos( 18, self.lblName:GetTall() + 27 )
		self.infoCard:SetSize( self:GetWide() - 36, self:GetTall() - self.lblName:GetTall() + 5 )	
	else	
		self.infoCard:SetVisible( false )	
	end
end

--- HigherOrLower
function PANEL:HigherOrLower( row )
	return false
end

vgui.Register( "suiscoreconnectingplayerrow", PANEL, "Button" )