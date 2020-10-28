AddEventHandler('playerSpawned', function() 
	TriggerServerEvent('BadgerCopChat:Server:GetUserData');
end)