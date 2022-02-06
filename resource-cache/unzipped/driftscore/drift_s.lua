local connection
local driftRecords = {}
local loadedClients = {}
local recordListMaxPosition = 50

local excludedUsernames = -- Add accountnames of who you want to blacklist from ranking, like to prevent players tracking (undercover) admins through F5 (current nick + username)
{
	["Adminusername1"] = true,
	["Test2"] = true,
}

local function comp(a,b)

	return a.score > b.score

end

local function checkDriftRecord(score)

	if not client.account then return end
	if excludedUsernames[client.account.name] then return end
	
	local acc = (client.account.name~="guest" and client.account.name or hash("sha512",client.serial))
	local name = client.name
	local oldJSON = toJSON(driftRecords)
	local isGuest = tostring(isGuestAccount(client.account))
	
	if driftRecords[#driftRecords] == nil or (score > driftRecords[#driftRecords].score or #driftRecords < recordListMaxPosition) then
		local existingPosition = false
		for position,record in ipairs(driftRecords) do
			if record.username == acc then
				existingPosition = position
				break
			end
		end
		if existingPosition and score > driftRecords[existingPosition].score then
			driftRecords[existingPosition].score = score
			driftRecords[existingPosition].playername = name
		elseif not existingPosition then
			table.insert(driftRecords,{username=acc,score=score,playername=name,isGuest=isGuest})
		end
	else
		return
	end
	
	table.sort(driftRecords,comp)
	
	if #driftRecords > recordListMaxPosition then
		for position=recordListMaxPosition+1,#driftRecords do
			driftRecords[position]=nil
		end
	end
	
	if oldJSON == toJSON(driftRecords) then
		return
	end
	
	for player,_ in pairs(loadedClients) do
		triggerClientEvent(player,"Drift:loadRecords",player,driftRecords,recordListMaxPosition,player.account.name)
	end
	
	connection:exec("DELETE FROM records")
	
	for position,record in ipairs(driftRecords) do
		connection:exec("INSERT INTO records VALUES (?,?,?,?)",record.username,record.playername,record.score,record.isGuest)
	end
	
end

local function recheckPlayer()

	triggerClientEvent(source,"Drift:loadRecords",source,driftRecords,recordListMaxPosition,source.account.name)

end

local function resetPlayer()

	loadedClients[source] = nil

end

local function clientLoaded()

	if source~=client then return end
	
	triggerClientEvent(client,"Drift:loadRecords",client,driftRecords,recordListMaxPosition,client.account.name)
	addEventHandler("onDriftEnd",client,checkDriftRecord)
	loadedClients[client] = true
	addEventHandler("onPlayerLogin",client,recheckPlayer)
	addEventHandler("onPlayerLogout",client,recheckPlayer)
	addEventHandler("onPlayerQuit",client,resetPlayer)
	
end

local function initScript()
	
	connection = Connection("sqlite",":/drift.db")
	connection:exec("CREATE TABLE IF NOT EXISTS records (username TEXT, playername TEXT, score NUMBER, isGuest TEXT)")
	
	local handle = connection:query("SELECT * FROM records")
	driftRecords = handle:poll(-1)
	
	addEvent("Drift:scriptLoaded",true)
	addEvent("onDriftEnd",true)
	
	addEventHandler("Drift:scriptLoaded",root,clientLoaded)

	for _,v in ipairs({"Best Drift","Total Drift","Last Drift"}) do exports["scoreboard"]:addScoreboardColumn(v) end
	
end

addEventHandler("onResourceStart",resourceRoot,initScript)