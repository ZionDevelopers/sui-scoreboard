 -- Exsto
 -- SUI Scoreboard V3 for Exsto Plugin 

local PLUGIN = exsto.CreatePlugin()

PLUGIN:SetInfo({
	Name = "SUI Scoreboard V3 for Exsto",
	ID = "sui_scoreboardv3",
	Desc = "SUI Scoreboard V3 ported to Exsto!",
	Owner = "Nexus [BR]"
})

function PLUGIN:Init()	
	if SERVER then	
		resource.AddSingleFile("materials/gui/silkicons/exclamation.vmt")
		resource.AddSingleFile("materials/gui/silkicons/exclamation.vtf")
		resource.AddSingleFile("materials/gui/silkicons/heart.vmt")
		resource.AddSingleFile("materials/gui/silkicons/heart.vtf")
		resource.AddSingleFile("materials/gui/silkicons/palette.vmt")
		resource.AddSingleFile("materials/gui/silkicons/palette.vtf")
		resource.AddSingleFile("materials/gui/silkicons/star.vmt")
		resource.AddSingleFile("materials/gui/silkicons/star.vtf")
		resource.AddSingleFile("materials/gui/silkicons/user.vmt")
		resource.AddSingleFile("materials/gui/silkicons/user.vtf")	
	
		AddCSLuaFile()
		AddCSLuaFile("sui_scoreboard/admin_buttons.lua")
		AddCSLuaFile("sui_scoreboard/cl_tooltips.lua")
		AddCSLuaFile("sui_scoreboard/player_frame.lua")
		AddCSLuaFile("sui_scoreboard/player_infocard.lua")
		AddCSLuaFile("sui_scoreboard/player_row.lua")
		AddCSLuaFile("sui_scoreboard/scoreboard.lua")
		AddCSLuaFile("sui_scoreboard/vote_button.lua")
	
		include( "sui_scoreboard/rating.lua" )		
	else
		include( "sui_scoreboard/scoreboard.lua" )	
		SuiScoreBoard = nil			
	end
	
	function PLUGIN:CreateScoreboard()		
		if ScoreBoard then			
			ScoreBoard:Remove()
			ScoreBoard = nil				
		end
		
		SuiScoreBoard = vgui.Create( "suiscoreboard" )			
		return true	
	end
	
	function PLUGIN:ScoreboardShow()	
		if not SuiScoreBoard then
			self:CreateScoreboard()
		end

		GAMEMODE.ShowScoreboard = true
		gui.EnableScreenClicker( true )

		SuiScoreBoard:SetVisible( true )
		SuiScoreBoard:UpdateScoreboard( true )
		
		return true
	end
	
	function PLUGIN:ScoreboardHide()	
		GAMEMODE.ShowScoreboard = false
		gui.EnableScreenClicker( false )

		SuiScoreBoard:SetVisible( false )		
		return true		
	end
end

--- When the player joins the server we need to restore the NetworkedInt's
function PLUGIN:PlayerInitialSpawn( ply )
	timer.Simple( 5, function() UpdatePlayerRatings( ply ) end) -- Wait a few seconds so we avoid timeouts.
end

PLUGIN:Register()