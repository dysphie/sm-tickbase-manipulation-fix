# [NMRiH/Any?] Tickbase Manipulation Fix

Fixes an exploit where players can "speedhack" to skip or break progress triggers, consume no stamina, or any other action that relies on server time.

## Installation
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
  - [backwards](https://forums.alliedmods.net/member.php?u=246029) for helping with coding and testing
