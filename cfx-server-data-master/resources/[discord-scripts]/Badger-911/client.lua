Citizen.CreateThread(function()
	TriggerServerEvent('Badger-911:CheckPerms')
end)

RegisterNetEvent("Badger-911:SetWaypoint")
AddEventHandler("Badger-911:SetWaypoint", function(x, y)
	-- Set the waypoint for this player
	SetNewWaypoint(x, y)
end)