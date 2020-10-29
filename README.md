#  How-To-FiveM
### A Full Demo Server Made By Jordan.#2139
---
# Can I Use This Code For My Server?
### Yes you can use this code for your server, that's the point of this repo! Just remember to configure the bot for your server.

# How Do I Set Up This Code?
- 1.) Click the green `Code` button in the middle right of your screen
  - Click `Download ZIP`
  ---
- 2.) Extract the code from the `.rar` file using [WinZip](https://download.winzip.com/gl/gad/winzip25.exe) or my personal preference [WinRAR](https://www.rarlab.com/download.htm)
---
- 3.) Navigate to `How-To-FiveM/cfx-server-data-master/` and open the `server.cfg` using your preferred test editor/ IDE
  - I recommend [Visual Studio Code](https://code.visualstudio.com/download)
    - *Note: If the name of the file is just `server` please follow these instructions to show the file name extensions: Open File Explorer -> Navigate To The Server Folder -> Click "View" -> Check The "Show File Name Extensions" Box -> change the name of your server.cfg.txt to just server.cfg*
      - The file should look like this: ![Files](https://i.imgur.com/9fnQaGl.png)
      ---
- 4.) Inside the `server.cfg` go to lines `193` & `198`
  - `193` - Please navigate to [Steam Web Dev](https://steamcommunity.com/dev/apikey) and create your own `Web API Key` and set that there
  - `198` - Please navigate to [FiveM Keymaster](https://keymaster.fivem.net/) and create your own `FiveM Server License Key` and set that on line `198`
    - *Note: You must disable your VPN and use your real IP adress for this process to work!*
  - Save (ctrl + s) and close the `server.cfg`
  ---
- 5.) Navigate to `How-To-FiveM/cfx-server-data-master/resources/[discord-scripts]/Badger_Discord_API/`
  - Open the `config.lua`
  - Navigate to your Discord and copy your guild ID using right click and paste in line `2`
  ![guildID](https://im4.ezgif.com/tmp/ezgif-4-f1a81125e264.gif)
  - Navigate to [Discord Dev Portal](https://discord.com/developers) and create a bot:
    ![MakeBot](https://im4.ezgif.com/tmp/ezgif-4-50d0c15de76b.gif)
  - Paste your bot token into line `3`
  - Copy and paste your desired role IDs using the same right click method used for guild ID
  ---
- 6.) Navigate to `How-To-FiveM/cfx-server-data-master/resources/[discord-scripts]/`
  - Go through these various folders and configure them with the appropriate role nicknames set in `Badger_Discord_API`
  ---
- 7.) Navigate to `How-To-FiveM` and launch the `FXServer.exe`
  - Go to [TxAdmin](http://localhost:40120/) and fill in the required boxes
  - Click `Start` on the dashboard. Congrats! Your server is running!
  ---
- 8.) Launch your FiveM
  - Navigate to `Settings (cog in top right) -> Scroll to the "Interface" section and check "enable the 'localhost' menu item"`
  - Click the FiveM logo (top left) 
  - Click the "LOCALHOST" button
  - Enjoy your new server!
---
# Notes:
- For a much more detailed version of this along with a FAQ section please navigate to the GitBook (coming soon). 
- You have free access to this code but please do not claim it as your own, us devs for hard for what we do so some credit is always nice!
- If you found this helpful please click the `star` (it's the like button of GitHub)
- If you found this helful please follow me on [GitHub](https://github.com/Jordan2139)!
- For additional support please join my [Discord](https://discord.gg/4MqR5vz)
  - *Guidlines:* 
    - Please do not dm me as I will __not__ respond to anyones dms
    - Do not ping me or any other people for help, we will help when we can
    - Please be patient and only type in one, **support** channel
