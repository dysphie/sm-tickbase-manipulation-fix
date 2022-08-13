# [NMRiH/Any?] Tickbase Manipulation Fix

Fixes an exploit where players can "speedhack" to skip or break progress triggers, consume no stamina, and other actions that relies on game time being accurate.

## Installation
- Upgrade to Sourcemod 1.11 or higher, else install [DHooks2](https://github.com/peace-maker/DHooks2/releases) 
- Download the latest zip in [releases](https://github.com/dysphie/nmrih-tickbase-fix/releases)
- Extract contents into `addons/sourcemod`
- Refresh your plugin list (`sm plugins refresh` in server console)

## CVars

Cvars should be modified in `cfg/plugin.tickbase-manipulation-fix.cfg`

- `sm_tickbase_shift_max_seconds` (Default: 2)
  - How far ahead from server time a client is allowed to be (don't touch unless you know what you're doing)
  
- `sm_tickbase_shift_log_seconds` (Default: 25)
  - Logs the name and steamID of clients that are ahead of server time by more than this many seconds. 
    
    **Important note: A detection does not mean a client is cheating**. However, repeated offenses in a short period most certainly do 
    
## Special thanks
  - [backwards](https://forums.alliedmods.net/member.php?u=246029) for help with coding and testing
  
## Game Support
- This fix should be game-agnostic but I can't maintain gamedata for all of them. If you want support for your game please [submit a pull request](https://github.com/dysphie/nmrih-tickbase-fix/pulls) with valid gamedata or [open an issue](https://github.com/dysphie/nmrih-tickbase-fix/issues).

  Currently tested games:
  - No More Room in Hell
  
