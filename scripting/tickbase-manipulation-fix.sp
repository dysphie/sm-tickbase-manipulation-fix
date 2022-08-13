#include <sourcemod>
#include <dhooks>

ConVar cvMaxTime;
ConVar cvLogTime;

int g_MaxAheadTicks;
int g_LogTicks;
float g_TickInterval;

#define PLUGIN_DESCRIPTION "Stops exploits related to tickbase manipulation"
#define PLUGIN_VERSION "1.0.3"

public Plugin myinfo = {
    name        = "Tickbase Manipulation Fix",
    author      = "Dysphie & backwards",
    description = PLUGIN_DESCRIPTION,
    version     = PLUGIN_VERSION,
    url         = "https://github.com/dysphie/sm-tickbase-manipulation-fix"
};

public void OnPluginStart()
{	
	g_TickInterval = GetTickInterval();

	CreateConVar("tickbasefix_version", PLUGIN_VERSION, PLUGIN_DESCRIPTION,
    	FCVAR_SPONLY|FCVAR_NOTIFY|FCVAR_DONTRECORD);

	cvMaxTime = CreateConVar("sm_tickbase_shift_max_seconds", "2.0", "Maximum desync in seconds before client tickbase is re-synced");
	cvMaxTime.AddChangeHook(OnMaxTimeConVarChanged);

	cvLogTime = CreateConVar("sm_tickbase_shift_log_seconds", "25.0", 
		"Log players who shift more than this many seconds (must be greater than sm_tickbase_shift_max_seconds). Set to 0 to disable logging");
	cvLogTime.AddChangeHook(OnLogTimeConVarChanged);

	AutoExecConfig(true, "plugin.tickbase-manipulation-fix");

	GameData gamedata = new GameData("tickbase-manipulation-fix.games");
	if (!gamedata) {
		SetFailState("Failed to find gamedata/tickbase-manipulation-fix.games.txt");
	}

	DynamicDetour detour = DynamicDetour.FromConf(gamedata, "CPlayerMove::RunCommand");
	if (!detour)
		SetFailState("Failed to find signature CPlayerMove::RunCommand");
	detour.Enable(Hook_Pre, CPlayerMoveRunCommand);

	delete gamedata;
}

MRESReturn CPlayerMoveRunCommand(int pThis, DHookParam params)
{
	int client = params.Get(1);
	int tickBase = GetEntProp(client, Prop_Send, "m_nTickBase");
	int tickCount = GetGameTickCount();
	int aheadTicks = tickCount - tickBase;

	// If player went too far ahead, reset their tickbase
	if (aheadTicks > g_MaxAheadTicks)
	{
		SetEntProp(client, Prop_Send, "m_nTickBase", tickCount);

		if (g_LogTicks > 0 && aheadTicks > g_LogTicks)
		{
			LogMessage("[%d] %L ahead by %.f seconds. Clamping..", tickCount, client, aheadTicks * g_TickInterval);
		}
	}

	return MRES_Ignored;
}

int TimeToTicks(float time)
{
	return RoundToNearest(time / GetTickInterval())
}

// Cache some stuff to save on native calls/calculations later
void OnMaxTimeConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue) 
{
	CacheMaxAheadTicks();
}

void OnLogTimeConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue) 
{
	CacheMinLogTicks();
}

public void OnConfigsExecuted()
{
	CacheMaxAheadTicks();
	CacheMinLogTicks();
}

void CacheMaxAheadTicks()
{
	g_MaxAheadTicks = TimeToTicks(cvMaxTime.FloatValue);
}

void CacheMinLogTicks()
{
	g_LogTicks = TimeToTicks(cvLogTime.FloatValue);
}
