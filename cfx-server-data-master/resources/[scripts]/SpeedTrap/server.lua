------------------------------------------------------------
-- SpeedTrap- A Simple FiveM Script, Made By Jordan.#2139 --
------------------------------------------------------------

----------------------------------------------------------------------------------------------
                  -- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
        -- DO NOT TOUCH THIS FILE OR YOU /WILL/ FUCK SHIT UP! EDIT THE CONFIG.LUA --
-- DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW. --
----------------------------------------------------------------------------------------------
webhookURL = Config.webhookURL
debugEnabled = Config.debugEnabled;
webhookEnabled = Config.webhookEnabled

function GetAllPlayers()
    local players = {}

    for _, i in ipairs(GetPlayers()) do
        table.insert(players, i)    
    end

    return players
end
AddEventHandler('playerDropped', function (reason)
    Cooldown[source] = nil;
end)

Cooldown = {}
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000); -- Every second
        for k, v in pairs(Cooldown) do 
            Cooldown[k] = Cooldown[k] - 1;
            if Cooldown[k] <= 0 then 
                Cooldown[k] = nil;
            end
        end
    end
end)

Slowdown = {}
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000); -- Every second
        for k, v in pairs(Slowdown) do 
            Slowdown[k] = Slowdown[k] - 1;
            if Slowdown[k] <= 0 then 
                Slowdown[k] = nil;
            end
        end
    end
end)


RegisterNetEvent('AllowSpeed')
AddEventHandler('AllowSpeed', function()
    local src = source;
    local id = source;
    local ids = ExtractIdentifiers(id);
    local steam = ids.steam:gsub("steam:", "");
    local steamDec = tostring(tonumber(steam,16));
    steam = "https://steamcommunity.com/profiles/" .. steamDec;
    local discord = ids.discord;
    if debugEnabled then 
        print("[SpeedTrap Debug] AllowSpeed event ran...");
    end
    if IsPlayerAceAllowed(src, "jordan.gofast") then
        TriggerClientEvent('AllowSpeedClient', src)
    else
        TriggerClientEvent('DoAllowSpeedClient', src)
        if Cooldown[src] == nil then 
            local players = GetAllPlayers()
            for i=1, #players do
                if IsPlayerAceAllowed(players[i], 'jordan.gofastwatch') then 
                    TriggerClientEvent('chatMessage', players[i], Config.StaffAlert:gsub("{PLAYER}", 
                        GetPlayerName(src)):gsub("{SPEED}", Config.maxspeedwarning));
                end
            end
            Cooldown[src] = Config.StaffAlertCooldown;
        else
            -- They are on cooldown, we do nothing for now 
        end
            if Config.webhookEnabled then
                if Slowdown[src] == nil then 
                    sendToDisc("SpeedTrap has caught " .. GetPlayerName(id) .. " going over " .. Config.maxspeedwarning .. "", 
                    'Steam: **' .. steam .. '**\n' ..
                    'Discord Tag: ** <@' .. discord:gsub('discord:', '') .. '> **\n' ..
                    'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
                    Slowdown[src] = Config.StaffAlertCooldown;
                else
                    -- They are on cooldown, we do nothing for now 
                end
            else
        end
    end
end)

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
