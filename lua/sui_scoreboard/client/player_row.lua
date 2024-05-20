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
Version 2.7 - 2024-05-19 11:25 AM (UTC -03:00)

]]--

include( "player_infocard.lua" )

local texGradient = surface.GetTextureID( "gui/center_gradient" )

surface.GetTextureID( "gui/silkicons/emoticon_smile" )
local PANEL = {}

--- Paint
function PANEL:Paint(w,h)

	local color = Color( 100, 100, 100, 255 )

	if self.Armed then
		color = Color( 125, 125, 125, 255 )
	end

	if self.Selected then
		color = Color( 125, 125, 125, 255 )
	end

	ply = self.Player;

	if ply:IsValid() then
		if ply:Team() == TEAM_CONNECTING then
			color = Color( 100, 100, 100, 155 )
		elseif ply:IsValid() then
			if ply:Team() == TEAM_UNASSIGNED then
				color = Color( 100, 100, 100, 255 )
			else
			  if evolve == nil then
				  tcolor = team.GetColor(ply:Team())
				  color = Color(tcolor.r,tcolor.g,tcolor.b,225)
				else
				 tcolor = evolve.ranks[ ply:EV_GetRank() ].Color

				 color = Color(tcolor.r,tcolor.g,tcolor.b,225)
				end
			end
		elseif ply:IsAdmin() then
			color = Color( 255, 155, 0, 255 )
		end

		if ply == LocalPlayer() then
        if evolve == nil then
          tcolor = team.GetColor(ply:Team())
          color = Color(tcolor.r,tcolor.g,tcolor.b,225)
        else
         tcolor = evolve.ranks[ ply:EV_GetRank() ].Color
         color = Color(tcolor.r,tcolor.g,tcolor.b,225)
        end
		end
	end

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
function PANEL:SetPlayer( ply )
	self.Player = ply
	self.infoCard:SetPlayer( ply )
	self:UpdatePlayerData()
	self.imgAvatar:SetPlayer( ply )
end

--- CheckRating
function PANEL:CheckRating( name, count )
	if self.Player:GetNetworkedInt( "Rating."..name, 0 ) > count then
		count = self.Player:GetNetworkedInt( "Rating."..name, 0 )
	end

	return count
end

--- UpdatePlayerData
function PANEL:UpdatePlayerData()
	if not self.Player:IsValid() then
		return false
	end

	self.lblName:SetText( self.Player:Nick() )
	self.lblTeam:SetText( Scoreboard.getGroup( self.Player ) )

	self.lblHours:SetText( Scoreboard.formatTime( Scoreboard.getPlayerTime( self.Player ) ))
	self.lblHealth:SetText( self.Player:Health() )
	self.lblFrags:SetText( self.Player:Frags() )
	self.lblDeaths:SetText( self.Player:Deaths() )
	self.lblPing:SetText( self.Player:Ping() )

	-- Change the icon of the mute button based on state
	if  self.Muted == nil or self.Muted ~= self.Player:IsMuted() then
		self.Muted = self.Player:IsMuted()
		if self.Muted then
			self.lblMute:SetImage( "icon32/muted.png" )
		else
			self.lblMute:SetImage( "icon32/unmuted.png" )
		end

		self.lblMute.DoClick = function() self.Player:SetMuted( not self.Muted ) end
	end	
	
	-- Show the super awesome port of the vanilla gmod volume slider when right click
	self.lblMute.DoRightClick = function()		
    self:ShowMicVolumeSlider()		
	end

    local k = self.Player:Frags()
    local d = self.Player:Deaths()
    local kdr = "--   "

	if d ~= 0 then
		kdr = k/d
		local y,z = math.modf(kdr)
		z = string.sub(z, 1, 5)

		if y ~= 0 then
			kdr = string.sub(y+z,1,5)
		else
			kdr =  z
		end

		kdr = kdr .. ":1"
		if k == 0 then
			kdr = k .. ":" .. d
		end
	end

	self.lblRatio:SetText( kdr )

	local count = 0

	count = self:CheckRating( 'smile', count )
	count = self:CheckRating( 'love', count )
	count = self:CheckRating( 'artistic', count )
	count = self:CheckRating( 'gold_star', count )
	count = self:CheckRating( 'builder', count )
	count = self:CheckRating( 'lol', count )
	count = self:CheckRating( 'gay', count )
	count = self:CheckRating( 'curvey', count )
	count = self:CheckRating( 'god', count )
	count = self:CheckRating( 'stunter', count )
	count = self:CheckRating( 'best_landvehicle', count )
	count = self:CheckRating( 'best_airvehicle', count )
	count = self:CheckRating( 'friendly', count )
	count = self:CheckRating( 'informative', count )
	count = self:CheckRating( 'naughty', count )
end

--phys' super awesome port of the vanilla gmod volume slider... redecorated a little to match SUI theme
function PANEL:GetPlayer() return self.Player end
function PANEL:ShowMicVolumeSlider()
   local width = 300
   local height = 50
   local padding = 10

   local sliderHeight = 16
   local sliderDisplayHeight = 8

   local x = math.max(gui.MouseX() - width, 0)
   local y = math.min(gui.MouseY(), ScrH() - height)

   local currentPlayerVolume = self:GetPlayer():GetVoiceVolumeScale()
   currentPlayerVolume = currentPlayerVolume ~= nil and currentPlayerVolume or 1

   -- Frame for the slider
   local frame = vgui.Create("DFrame")
   frame:SetPos(x, y)
   frame:SetSize(width, height)
   frame:MakePopup()
   frame:SetTitle("")
   frame:ShowCloseButton(false)
   frame:SetDraggable(false)
   frame:SetSizable(false)
   frame.Paint = function(self, w, h)
      draw.RoundedBox(5, 0, 0, w, h, Color(30, 30, 30, 205))
   end

   -- Automatically close after 10 seconds (something may have gone wrong)
   timer.Simple(10, function() if IsValid(frame) then frame:Close() end end)

   -- "Player volume"
   local label = vgui.Create("DLabel", frame)
   label:SetPos(padding, padding)
   label:SetFont("DermaDefaultBold")
   label:SetSize(width - padding * 2, 20)
   label:SetColor(Color(255, 255, 255, 255))
   label:SetText("Player Volume:")

   -- Slider
   local slider = vgui.Create("DSlider", frame)
   slider:SetHeight(sliderHeight)
   slider:Dock(TOP)
   slider:DockMargin(padding, 0, padding, 0)
   slider:SetSlideX(currentPlayerVolume)
   slider:SetLockY(0.5)
   slider.TranslateValues = function(slider, x, y)
      if IsValid(self:GetPlayer()) then self:GetPlayer():SetVoiceVolumeScale(x) end
      return x, y
   end

   -- Close the slider panel once the player has selected a volume
   slider.OnMouseReleased = function(panel, mcode) frame:Close() end
   slider.Knob.OnMouseReleased = function(panel, mcode) frame:Close() end

   -- Slider rendering
   -- Render slider bar
   slider.Paint = function(self, w, h)
      local volumePercent = slider:GetSlideX()

      -- Filled in box
      draw.RoundedBox(5, 0, sliderDisplayHeight / 2, w * volumePercent, sliderDisplayHeight, Color(208, 208, 208, 255))

      -- Grey box
      draw.RoundedBox(5, w * volumePercent, sliderDisplayHeight / 2, w * (1 - volumePercent), sliderDisplayHeight, Color(84, 84, 84, 255))
   end

   -- Render slider "knob" & text
   slider.Knob.Paint = function(self, w, h)
      if slider:IsEditing() then
         local textValue = math.Round(slider:GetSlideX() * 100) .. "%"
         local textPadding = 5

         -- The position of the text and size of rounded box are not relative to the text size. May cause problems if font size changes
         draw.RoundedBox(
            5, -- Radius
            -sliderHeight * 0.5 - textPadding, -- X
            -25, -- Y
            sliderHeight * 2 + textPadding * 2, -- Width
            sliderHeight + textPadding * 2, -- Height
            Color(55, 55, 55, 208)
         )
         draw.DrawText(textValue, "DermaDefaultBold", sliderHeight / 2, -20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
      end

      draw.RoundedBox(100, 0, 0, sliderHeight, sliderHeight, Color(255, 255, 255, 255))
   end
end


--- Int
function PANEL:Init()
	self.Size = 38
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
	self.lblAvatarFix.DoClick = function  () self.Player:ShowProfile() end

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

	self:OpenInfo( not self.Open )
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
		self.Size = math.Approach( self.Size, self.TargetSize, (math.abs( self.Size - self.TargetSize ) + 1) * 10 * FrameTime() )
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
	self.lblTeam:SetPos( self:GetWide() - COLUMN_SIZE * 16.1, 3 )

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
	if self.Player:Team() == TEAM_CONNECTING then
		return false
	end
	
	if not row.Player then --then its a connecting_player_row.lua
		return true 
	end

	if self.Player:Team() ~= row.Player:Team() then
		return self.Player:Team() < row.Player:Team()
	end

	if self.Player:Frags() == row.Player:Frags() then
		return self.Player:Deaths() < row.Player:Deaths()
	end

	return self.Player:Frags() > row.Player:Frags()
end

vgui.Register( "suiscoreplayerrow", PANEL, "Button" )
