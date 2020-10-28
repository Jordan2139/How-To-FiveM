--- CONFIG ---
webhookURL = ''
prefix = '^5[^1911^5] ^3';
roleList = {
    "SAHP",
    "BCSO",
    "BCPD",
    "CO",
    "EMS",
}



--- CODE ---
function sendMsg(src, msg)
    TriggerClientEvent('chat:addMessage', src, {
        args = { prefix .. msg }
    })
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
isCop = {}
AddEventHandler('playerDropped', function (reason) 
  -- Clear their lists 
  local src = source;
  isCop[src] = nil;
end)

RegisterNetEvent('Badger-911:CheckPerms')
AddEventHandler('Badger-911:CheckPerms', function()
    local src = source;
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end
    -- TriggerClientEvent("FaxDisVeh:CheckPermission:Return", src, true, false)

if identifierDiscord then
    local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
    if not (roleIDs == false) then
        for i = 1, #roleList do
            for j = 1, #roleIDs do
                if exports.Badger_Discord_API:CheckEqual(roleList[i], roleIDs[j]) then
                    isCop[tonumber(src)] = true;
                    print("[911]" .. GetPlayerName(src) .. " received Badger-911 permissions SUCCESS")
                end
            end
        end
    else
        print(GetPlayerName(src) .. " did not receive permissions because roles == false")
    end
elseif identifierDiscord == nil then
    print("identifierDiscord == nil")
end
end)

locationTracker = {}
idCounter = 0;
function mod(a, b)
    return a - (math.floor(a/b)*b)
end
RegisterCommand("resp", function(source, args, raw)
    if (#args > 0) then 
        if tonumber(args[1]) ~= nil then 
            if locationTracker[tonumber(args[1])] ~= nil then 
                -- It is valid, set their waypoint 
                local loc = locationTracker[tonumber(args[1])]
                TriggerClientEvent("Badger-911:SetWaypoint", source, loc[1], loc[2]);
                sendMsg(source, "Your waypoint has been set to the situation!")
            else 
                -- Not valid 
                sendMsg(source, "^1ERROR: That is not a valid situation...")
            end
        else 
            -- Not a valid number 
            sendMsg(source, "^1ERROR: That is not a valid number you supplied...")
        end
    end
end)
RegisterCommand("911", function(source, args, raw)
    -- /911 command 
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)));
    if (#args > 0) then 
        idCounter = idCounter + 1;
        locationTracker[idCounter] = {x, y};
        if mod(idCounter, 12) == 0 then 
            -- Is a multiple of 12 with no remainder, we can remove 6 of the last 
            local cout = idCounter - 12;
            while cout < (idCounter - 6) do 
                locationTracker[cout] = nil;
                cout = cout + 1;
            end
            idCounter = 1;
            locationTracker[idCounter] = {x, y};
        end
        sendMsg(source, "Your 911 call has been received! The authorities are on their way!");
        sendToDisc("[RESPONSE CODE: " .. idCounter .. "] " ..
         "INCOMING TRANSMISSION:", table.concat(args, " "), "[" .. source .. "] " .. GetPlayerName(source))
        for _, id in ipairs(GetPlayers()) do 
            if isCop[tonumber(id)] ~= nil and isCop[tonumber(id)] == true then 
                -- They are a cop, send them it 
                sendMsg(id, "[^7Use ^2/resp " .. idCounter .. "^7 to respond^3] " .. "^1INCOMING TRANSMISSION: ^3" .. table.concat(args, " "));
            end
        end
    end
end)
