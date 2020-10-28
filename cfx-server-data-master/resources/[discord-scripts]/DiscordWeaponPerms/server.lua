--------------------------
--- DiscordWeaponPerms ---
--------------------------
roleList = {
"Trusted_Civ",  -- Trusted Civ (1)
"Donator",      -- Donator (2)
"Personal",     -- Personal (3)
"Staff", 	    -- Staff (4)
"T-Mod",	    -- T-Mod (5)
"Mod", 			-- Mod (6)
"Admin", 		-- Admin (7)
"Management",   -- Management (8)
"Owner", 		-- Owner (9)
}


RegisterNetEvent('Print:PrintDebug')
AddEventHandler('Print:PrintDebug', function(msg)
	print(msg)
	TriggerClientEvent('chatMessage', -1, "^7[^1Badger's Scripts^7] ^1DEBUG ^7" .. msg)
end)

RegisterNetEvent("DiscordWeaponPerms:CheckPerms")
AddEventHandler("DiscordWeaponPerms:CheckPerms", function()
	local src = source
	for k, v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("discord:")) == "discord:" then
			identifierDiscord = v
		end
	end
	local hasPerms = {} -- Has perms for indexes:
	if identifierDiscord then
		local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
		if not (roleIDs == false) then
			for i = 1, #roleList do
				for j = 1, #roleIDs do
					if exports.Badger_Discord_API:CheckEqual(roleList[i], roleIDs[j]) then
						table.insert(hasPerms, i)
					end
				end
			end
		else
		print(GetPlayerName(src) .. " has not gotten their permissions cause roleIDs == false")
		end
	end
	TriggerClientEvent('DiscordWeaponPerms:CheckPerms:Return', src, hasPerms)
end)