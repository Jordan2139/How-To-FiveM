---------------------------------------------------------------
-- Resurrection- A Simple FiveM Script, Made By Jordan.#2139 --
---------------------------------------------------------------

----------------------------------------------------------------------------------------------
                  -- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
        -- DO NOT TOUCH THIS FILE OR YOU /WILL/ FUCK SHIT UP! EDIT THE CONFIG.LUA --
-- DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW. --
----------------------------------------------------------------------------------------------


AddEventHandler("Revive", function( adrev, admin, all)
	local ped = PlayerPedId()
	if all then
		revivePed( ped )
		resetTimers()
		ShowNotification("~g~You have been revived by an admin!")
		return;
	end
	if GetEntityHealth( ped ) <= 1 then --if you are dead
			revivePed( ped )
			resetTimers()
			if adrev then
				ShowNotification("~g~You have been revived by an admin!")
                TriggerServerEvent('AdminMSG', '~g~Player have been revived', admin)
                TriggerServerEvent('GlobalChat', "^9[^Resurrection^9] Player " ..  GetPlayerName(ped) .. " has been revived by " .. GetPlayerName(admin) .. "")
			end
	else
		if adrev then
			TriggerServerEvent('AdminMSG', '~r~Player is alive', admin)
		else
			ShowNotification("~g~You're alive!")
		end
	end
end)

AddEventHandler("Respawn", function( adres, admin, all)
	local ped = PlayerPedId()
	if adres then RespawnAllowed = true end
	if all then
		respawnPed( ped, spawnPoints[math.random(1,#spawnPoints)] )
		resetTimers()
		ShowNotification("~g~You have been respawned by an admin!")
		return;
	end
	if GetEntityHealth( ped ) <= 1 then --if you are dead	
			respawnPed( ped, spawnPoints[math.random(1,#spawnPoints)] )
			resetTimers()
			if adres then
				ShowNotification("~g~You have been respawned by an admin!")
                TriggerServerEvent('AdminMSG', '~g~Player have been respawned', admin)
                TriggerServerEvent('GlobalChat', "^9[^Resurrection^9] Player " ..  GetPlayerName(ped) .. " has been respawned by " .. GetPlayerName(admin) .. "")
			end
	else
		if adres then
			TriggerServerEvent('AdminMSG', '~r~Player is alive', admin)
		else
			ShowNotification("~g~You're alive!")
		end
	end
end)

-- EVENTS --

AddEventHandler('ShowNotification', function( str )
	ShowNotification( str )
end)
