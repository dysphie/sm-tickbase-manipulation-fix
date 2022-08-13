# [ANY] Tickbase Manipulation Fix

[AlliedModders thread](https://forums.alliedmods.net/showthread.php?t=339058)

Fixes an exploit where players can manipulate game time to perform actions instantly (using progress triggers, detonating grenades, firing, etc.)

## Installation
- Upgrade to Sourcemod 1.11 or higher, else install [DHooks2](https://github.com/peace-maker/DHooks2/releases) 
- Download the latest zip in [releases](https://github.com/dysphie/sm-tickbase-manipulation-fix/releases)
- Extract contents into `addons/sourcemod`
- Refresh your plugin list (`sm plugins refresh` in server console)

## CVars

Cvars should be modified in `cfg/plugin.tickbase-manipulation-fix.cfg`

- `sm_tickbase_shift_max_seconds` (Default: 2)
  - How far ahead from server time a client is allowed to be (don't touch unless you know what you're doing)
  
- `sm_tickbase_shift_log_seconds` (Default: 25)
  - Logs the name and steamID of clients that are ahead of server time by more than this many seconds. 
    
    **Important note: A detection does not mean a client is cheating**. However, repeated offenses in a short period most certainly do 
  
## Game Support
- No More Room in Hell
- Team Fortress 2
- Contagion
- Pirates, Vikings, and Knights II
- Day of Defeat: Source
-  Zombie Panic Source (2.4 only)
- Any other game where the current signature matches, I guess

If you want support for your game please [submit a pull request](https://github.com/dysphie/sm-tickbase-manipulation-fix/pulls) with valid gamedata or [open an issue](https://github.com/dysphie/sm-tickbase-manipulation-fix/issues). Hint: The signature for `"CPlayerMove::RunCommand"` can be found in a disassembler by searching for the string `"sv_maxusrcmdprocessticks_warning at server tick %u:"`

## Special thanks
- [backwards](https://forums.alliedmods.net/member.php?u=246029) for help with coding and testing
- Felis for letting me use their server as a nuke testing site
- [nosoop](https://github.com/nosoop) for gamedata contributions
