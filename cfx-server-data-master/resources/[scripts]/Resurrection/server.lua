---------------------------------------------------------------
-- Resurrection- A Simple FiveM Script, Made By Jordan.#2139 --
---------------------------------------------------------------

----------------------------------------------------------------------------------------------
                  -- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
        -- DO NOT TOUCH THIS FILE OR YOU /WILL/ FUCK SHIT UP! EDIT THE CONFIG.LUA --
-- DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW. --
----------------------------------------------------------------------------------------------


webhookURL = Config.webhookURL


RegisterCommand('adminrevive', function(source, args, rawCommand)
    if #args == 1 then
        if tonumber(args[1]) then
            local target = tonumber(args[1])
            if GetPlayerName(target) then
                TriggerClientEvent('Revive', target, true, source, false)
            else
                TriggerClientEvent("ShowNotification", source, "~r~Invalid ID~n~Usage: /adrev ID")
            end
        else
            TriggerClientEvent("ShowNotification", source, "~r~Player ID must be a number~n~Usage: /adrev ID")
        end
    else
        TriggerClientEvent('Revive', source, true)
        if Config.webhookEnabled then
            sendToDisc("[Resurrection]: Player " ..  GetPlayerName(target) .. " has been revived by " .. GetPlayerName(admin) .. "", 
            'Steam: **' .. steam .. '**\n' ..
            'Discord Tag: ** <@' .. discord:gsub('discord:', '') .. '> **\n' ..
            'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
        else
        end
    end
 end, true)

 RegisterCommand('adrevall', function(source, args, rawCommand)
    TriggerClientEvent('Revive', -1, true, source, true)
    if Config.webhookEnabled then
        sendToDisc("[Resurrection]: Player " ..  GetPlayerName(target) .. " has used `adrevall`", 
        'Steam: **' .. steam .. '**\n' ..
        'Discord Tag: ** <@' .. discord:gsub('discord:', '') .. '> **\n' ..
        'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
    else
    end
 end, true)

RegisterCommand('adres', function(source, args, rawCommand)
    if #args == 1 then
        if tonumber(args[1]) then
            local target = tonumber(args[1])
            if GetPlayerName(target) then
                TriggerClientEvent('Respawn', target, true, source, false)
            else
                TriggerClientEvent("ShowNotification", source, "~r~Invalid ID~n~Usage: /adres ID")
            end
        else
            TriggerClientEvent("ShowNotification", source, "~r~Player ID must be a number~n~Usage: /adres ID")
        end
    else
        TriggerClientEvent('Respawn', source, true)
        if Config.webhookEnabled then
            sendToDisc("[Resurrection]: Player " ..  GetPlayerName(target) .. " has been respawned by " .. GetPlayerName(admin) .. "", 
            'Steam: **' .. steam .. '**\n' ..
            'Discord Tag: ** <@' .. discord:gsub('discord:', '') .. '> **\n' ..
            'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
        else
        end
    end
end, true)

RegisterCommand('adresall', function(source, args, rawCommand)
    TriggerClientEvent('Respawn', -1, true, source, true)
    if Config.webhookEnabled then
        sendToDisc("[Resurrection]: Player " ..  GetPlayerName(target) .. " has used `adresall`", 
        'Steam: **' .. steam .. '**\n' ..
        'Discord Tag: ** <@' .. discord:gsub('discord:', '') .. '> **\n' ..
        'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
    else
    end
end, true)

-- EVENT REGISTRY -- 

RegisterServerEvent('GlobalChat')
AddEventHandler('GlobalChat', function(Color, Prefix, Message)
	TriggerClientEvent('chatMessage', -1, Prefix, Color, Message)
end)

AddEventHandler('AdminMSG', function(msg, id)
    TriggerClientEvent("ShowNotification", source, msg)
end)

-- Functions --

function sendToDisc(title, message, footer)
    local embed = {}
    embed = {
        {
            ["color"] = 16711680, -- GREEN = 65280 --- RED = 16711680
            ["title"] = "**".. title .."**",
            ["description"] = "" .. message ..  "",
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    -- Start
    -- TODO Input Webhook
    PerformHttpRequest(webhookURL, 
    function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  -- END
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        discord = "" 
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        end
    end

    return identifiers
end
