------------------------------------------------------------
-- SpeedTrap- A Simple FiveM Script, Made By Jordan.#2139 --
------------------------------------------------------------
----------------------------------------------------------------------------------------------
                  -- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
        -- DO NOT TOUCH THIS FILE OR YOU /WILL/ FUCK SHIT UP! EDIT THE CONFIG.LUA --
-- DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW. --
----------------------------------------------------------------------------------------------
debugEnabled = Config.debugEnabled;
print("\n^7Simple Whitelisted Speed Warning | ^6 Made By Jordan.#2139^7")

warnplayer = false;
RegisterNetEvent('DoAllowSpeedClient')
AddEventHandler('DoAllowSpeedClient', function()
    warnplayer = true
    if debugEnabled then 
        print("[SpeedTrap Debug] DoAllowSpeedClient event ran...");
    end
end)

warnplayer = false;
RegisterNetEvent('AllowSpeedClient')
AddEventHandler('AllowSpeedClient', function()
    warnplayer = false;
    if debugEnabled then 
        print("[SpeedTrap Debug] AllowSpeedClient event ran...");
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        
        local player = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(player)
        local mph = math.ceil(GetEntitySpeed(veh) * 2.23)
        local class = GetVehicleClass(veh)
            
        if warnplayer then
            warn(Config.warningmsg)
        end
            if class ~= 15 and class ~= 16 then
                if GetPedInVehicleSeat(veh, -1) == player then
                    if mph > Config.maxspeedwarning then
                        if not warningstring then 
                            TriggerServerEvent('AllowSpeed')
                        end
                    else
                    warnplayer = false;
                    warningstring = false;
                    end
                end
        else
        end
    end
end)


function warn(msg)
	warningstring = true
	PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
    Wait(3000);
	warningstring = false
end

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~r~WARNING!")
    PushScaleformMovieFunctionParameterString(Config.warningmsg)
    PopScaleformMovieFunctionVoid()
    return scaleform
end


Citizen.CreateThread(function()
    scaleform = Initialize("mp_big_message_freemode")
while true do
	Citizen.Wait(0)
    if warningstring then
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
    end
end
end)
