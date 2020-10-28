roleList = {
"National", -- National Guardsmen
"SASP", -- SASP 
"LSPD", -- LSPD 
"Owner", -- Fire/EMS Department
}
prefix = '^0[^3LEO Chat^0] ^r';
AddEventHandler('playerDropped', function (reason) 
	isCop[source] = nil;
	inCopChat[source] = nil;
	hideCopChatMessages[source] = nil;
end)
isCop = {}
inCopChat = {}
hideCopChatMessages = {}
function ternary ( cond , T , F )
    if cond then return T else return F end
end
RegisterCommand('leoChat', function(source, args, rawCommand)
	local src = source;
	local canSeeMessages = ternary(hideCopChatMessages[src] == nil, true, false);
	local inChat = ternary(inCopChat[src] == nil, false, true);
	if isCop[src] ~= nil then 
		if #args == 0 then 
			-- Toggle it on or off 
			if inChat then 
				-- Turn it off 
				inCopChat[src] = nil;
				TriggerClientEvent('chatMessage', src, prefix .. '^4You have toggled ^3LEO Chat ^1OFF');
				TriggerEvent('DiscordChatRoles:EnableChat', src);
			else 
				-- Turn it on
				inCopChat[src] = true;
				TriggerClientEvent('chatMessage', src, prefix .. '^4You have toggled ^3LEO Chat ^2ON');
				TriggerEvent('DiscordChatRoles:DisableChat', src);
			end
			if not canSeeMessages then 
				TriggerClientEvent('chatMessage', src, prefix .. '^3WARNING: ^0You have ^4/leoChat vis ^1OFF ^0so you will not see' .. 
					'any ^1LEO Chat ^0messages sent...');
			end
		end
		--[[
		Commands:
		/leoChat on - Turn it on
		/leoChat off - Turn it off
		/leoChat vis - Toggles the visibility of seeing copChat messages
		]]--
		if #args == 1 then 
			-- Correct syntax 
			local subC = args[1];
			if subC == 'on' then 
				-- Turn it on 
				inCopChat[src] = true;
				TriggerClientEvent('chatMessage', src, prefix .. '^4You have turned ^3LEO Chat ^2ON');
				TriggerEvent('DiscordChatRoles:DisableChat', src);
				if not canSeeMessages then 
					TriggerClientEvent('chatMessage', src, prefix .. '^3WARNING: ^0You have ^4/leoChat vis ^1OFF ^0so you will not see' .. 
						'any ^1LEO Chat ^0messages sent...');
				end
			end
			if subC == 'off' then 
				-- Turn it off 
				inCopChat[src] = nil;
				TriggerClientEvent('chatMessage', src, prefix .. '^4You have turned ^3LEO Chat ^1OFF');
				TriggerEvent('DiscordChatRoles:EnableChat', src);
				if not canSeeMessages then 
					TriggerClientEvent('chatMessage', src, prefix .. '^3WARNING: ^0You have ^4/leoChat vis ^1OFF ^0so you will not see' .. 
						'any ^1LEO Chat ^0messages sent...');
				end
			end
			if subC == 'vis' then 
				-- Toggle the visibility 
				if not canSeeMessages then 
					-- Turn it off 
					hideCopChatMessages[src] = nil;
					TriggerClientEvent('chatMessage', src, prefix .. '^4You have ^2ENABLED ^3LEO Chat ^4visibility');
				else 
					-- Turn it on 
					hideCopChatMessages[src] = true;
					TriggerClientEvent('chatMessage', src, prefix .. '^4You have ^1DISABLED ^3LEO Chat ^4visibility');
				end
			end
		end

	else 
		TriggerClientEvent('chatMessage', src, prefix .. '^1You are not detected as a verified LEO to use this... :(')
	end
end)
AddEventHandler('chatMessage', function(source, name, msg)
	local src = source;
	if isCop[src] ~= nil then 
		if inCopChat[src] ~= nil then 
			CancelEvent();
			for k, v in pairs(isCop) do 
				if hideCopChatMessages[k] == nil then 
					TriggerClientEvent('chatMessage', k, prefix .. "^9(^4" .. GetPlayerName(src) .. "^9)^r " .. msg)
				end
			end
		end
	end
end)

RegisterNetEvent('BadgerCopChat:Server:GetUserData')
AddEventHandler('BadgerCopChat:Server:GetUserData', function()
	local src = source
	for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end
	if isCop[src] == nil then
		if identifierDiscord then
			local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
			if not (roleIDs == false) then
				for i = 1, #roleList do
					for j = 1, #roleIDs do
						if exports.Badger_Discord_API:CheckEqual(roleList[i], roleIDs[j]) then
							if isCop[src] == nil then
								isCop[src] = true;
							end
						end
					end
				end
			else
				print("[BadgerCopChat] " .. GetPlayerName(src) .. " has not gotten their access to /leoChat cause roleIDs == false")
			end
		else
			print("[BadgerCopChat] " .. GetPlayerName(src) .. " has not gotten their access to /leoChat cause their discord was not detected...")
		end
	end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end