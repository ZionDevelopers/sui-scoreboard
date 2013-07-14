--- Make the table if it doesn't exist

if not sql.TableExists("sui_ratings") then
	sql.Query( "CREATE TABLE IF NOT EXISTS sui_ratings ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, target INTEGER, rater INTEGER, rating INTEGER );" )
	sql.Query( "CREATE INDEX IDX_RATINGS_TARGET ON sui_ratings ( target DESC )" )
	Msg("SQL: Created ratings table!\n")	
end

--- ValidRatings - only these ratings are valid!
local ValidRatings = { "naughty", "smile", "love", "artistic", "gold_star", "builder", "gay", "informative", "friendly", "lol", "curvey", "best_landvehicle", "best_airvehicle", "stunter", "god" }

--- GetRating
-- @param string name
-- @return mixed
local function GetRatingID( name )
	for k, v in pairs( ValidRatings ) do
		if name == v then 
			return k 
		end
	end
	
	return false
end

--- GetRatingName
-- @param string id
-- @return mixed
local function GetRatingName( id )
	for k, v in pairs( ValidRatings ) do
		if id == k then
			return v
		end
	end
	
	return false
end


--- Update the player's networkvars based on the DB
-- @param entity ply
-- @return boolean
function UpdatePlayerRatings( ply )
	local result = sql.Query( "SELECT rating, count(*) as cnt FROM sui_ratings WHERE target = "..ply:UniqueID().." GROUP BY rating " )
	
	if not result then
		return false
	end
	
	for id, row in pairs( result ) do	
		ply:SetNetworkedInt( "SuiRating."..ValidRatings[ tonumber( row['rating'] ) ], row['cnt'] )	
	end
end
	
--- CCRateUser
-- @param string player
-- @param string command
-- @param array arguments
-- @return boolean
local function CCRateUser( player, command, arguments )

	local Rater 	= player
	local Target 	= Entity( tonumber( arguments[1] ) )
	local Rating	= arguments[2]
	
	-- Don't rate non players
	if not Target:IsPlayer() then 
		return false
	end
	
	-- Don't rate self
	if Rater == Target then 
		return false
	 end
	
	local RatingID = GetRatingID( Rating )
	local RaterID = Rater:UniqueID()
	local TargetID = Target:UniqueID()
	
	-- Rating isn't valid
	if not RatingID then
		return false
	end
	
	-- When was the last time this player rated this player
	-- Only let them rate each other every 60 seconds
	Target.RatingTimers = Target.RatingTimers or {}
	
	if Target.RatingTimers[ RaterID ] and Target.RatingTimers[ RaterID ] > CurTime() - 60 then	
		Rater:ChatPrint( "Please wait before rating ".. Target:Nick() .." again.\n" );
		return false		
	end
	
	Target.RatingTimers[ RaterID ] = CurTime()
	
	-- Tell the target that they have been rated (but don't tell them who to add to the fun and bitching)
	Target:ChatPrint( Rater:Nick() .. " Gave you a '" .. GetRatingName(RatingID) .. "' rating.\n" );
		
	-- Let the rater know that their vote was counted
	Rater:ChatPrint( "Gave ".. Target:Nick() .." a '" .. GetRatingName(RatingID) .. "' rating.\n" );
	
	sql.Query( "INSERT INTO sui_ratings ( target, rater, rating ) VALUES ( "..TargetID..", "..RaterID..", "..RatingID.." )" )

	-- We changed something so update the networked vars
	UpdatePlayerRatings( Target )	
end

concommand.Add( "sui_rateuser", CCRateUser )