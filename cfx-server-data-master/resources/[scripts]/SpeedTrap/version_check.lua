-- Branding!
local label = 
[[ 
  //
  || 
  ||   _____                     ________               
  ||   / ___/____  ___  ___  ____/ /_  __/________ _____ 
  ||   \__ \/ __ \/ _ \/ _ \/ __  / / / / ___/ __ `/ __ \
  ||  ___/ / /_/ /  __/  __/ /_/ / / / / /  / /_/ / /_/ /
  || /____/ .___/\___/\___/\__,_/ /_/ /_/   \__,_/ .___/ 
  ||     /_/                                    /_/      
  ||   
  ||              Created by Jordan.#2139
  ||]]
  
Citizen.CreateThread(function()
	local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
	if not CurrentVersion then
		print('^1SpeedTrap Version Check Failed!^7')
	end

	function VersionCheckHTTPRequest()
		PerformHttpRequest('https://raw.githubusercontent.com/Jordan2139/versions/master/speedtrap.json', VersionCheck, 'GET')
	end

	function VersionCheck(err, response, headers)
		Citizen.Wait(3000)
		if err == 200 then
			local Data = json.decode(response)
			if CurrentVersion ~= Data.NewestVersion then
				print( label )			
				print('  ||    \n  ||    SpeedTrap is outdated!')
				print('  ||    Current version: ^2' .. Data.NewestVersion .. '^7')
				print('  ||    Your version: ^1' .. CurrentVersion .. '^7')
				print('  ||    Please download the lastest version from ^5' .. Data.DownloadLocation .. '^7')
				if Data.Changes ~= '' then
					print('  ||    \n  ||    ^5Changes: ^7' .. Data.Changes .. "\n^0  \\\\\n")
				end
			else
				print( label )			
				print('  ||    ^2SpeedTrap is up to date!\n^0  ||\n  \\\\\n')
			end
		else
			print( label )			
			print('  ||    ^1There was an error getting the latest version information, if the issue persists contact Jordan.#2139 on Discord.\n^0  ||\n  \\\\\n')
		end
		
		SetTimeout(60000000, VersionCheckHTTPRequest)
	end

	VersionCheckHTTPRequest()
end)
