# Badger-911

## What is it?

Badger-911 is a simple, but efficient 911 script for your server. 911 calls are only displayed to those who have a police discord role on your discord server. When someone calls in 911, the call will only be relayed to the cops on the server. There is also a webhook in which you can set up to print the 911 transmissions in as well. What makes this 911 script stand out though is responding to calls. Instead of needing someone to give a postal in the 911 transmission or need them to say where, you can get their exact location the call was made from. Using the command `/resp <response code>` will set your waypoint on the map to the location the call was made at! Now, that's pretty cool.

## Dependency

https://forum.cfx.re/t/discord-roles-for-permissions-im-creative-i-know/233805

## Screenshots

![Webhook example](https://i.gyazo.com/0defc99164134834ad7f5bf4ce527cb4.png)

![Using /911](https://i.gyazo.com/bae5e3a4f7b443c24c7dd9979d9526c5.gif)

![Setting waypoint via /resp <response code>](https://i.gyazo.com/481aaacd2b679ec63aca2e25c011804f.gif)

## Commands

`/911 <info>` - Call 911 for a situation 

`/resp <response code>` - Respond to the 911 call with this response code

## Configuration

**Found in the server.lua file:**

```
--- CONFIG ---
webhookURL = ''
prefix = '^5[^1911^5] ^3';
roleList = {
    ['SAHP'] = 1,
    ['BCSO'] = 1,
    ['BCPD'] = 1,
    ['CO'] = 1,
    ['Fire & EMS'] = 1,
}
```

Replace the 1s with the role IDs of your corresponding discord roles... (You should all know the drill by now)

## Download

https://github.com/JaredScar/Badger-911/
