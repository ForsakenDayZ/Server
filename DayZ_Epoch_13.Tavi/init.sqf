dayz_antihack = 0;
dayz_REsec = 0;
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance = 13;	//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civilian?" messages from NPC
enableSentences false;

// DayZ Epoch config
spawnShoremode = 0; // Default = 1 (on shore)
spawnArea = 2500; // Default = 1500
DefaultMagazines = ["ItemBandage","ItemBandage","ItemPainkiller","ItemMorphine"]; 
DefaultWeapons = ["ItemRadio","ItemToolbox","ItemMap","ItemHatchet_DZE","ItemCompass"]; 
DefaultBackpack = "DZ_Assault_Pack_EP1";
DefaultBackpackWeapon = "";


MaxVehicleLimit = 400; // Default = 50
MaxDynamicDebris = 0; // Default = 100
dayz_MapArea = 20000; // Default = 10000

EpochEvents = [["any","any","any","any",15,"crash_spawner"],["any","any","any","any",45,"crash_spawner"],["any","any","any","any",15,"supply_drop"],["any","any","any","any",0,"animated_crash_spawner"]];
dayz_fullMoonNights = true;

dayz_minpos = -26000; 
dayz_maxpos = 26000;

dayz_sellDistance_vehicle = 10;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;

dayz_paraSpawn = false;

dayz_maxAnimals = 5; // Default: 8
dayz_tameDogs = true;
DynamicVehicleDamageLow = 0; // Default: 0
DynamicVehicleDamageHigh = 100; // Default: 100
DZE_ConfigTrader = true;
DZE_AsReMix_PLAYER_HUD = true;
DZE_SelfTransfuse = true;
DZE_BuildOnRoads = false; // Default: False
DZE_R3F_WEIGHT = false;
DZE_MissionLootTable = true;
DZE_GodModeBase = true;
DZE_BuildingLimit = 500;
/*
select 0 = Prevent gear from spawning on locked vehicles (boolean)
select 1 = Guaranteed loot piles (int)
select 2 = Max additional loot piles on top of guaranteed (int)
select 3 = Radius around crash site to spawn loot (double or int)
select 4 = Chance of gear being destroyed (Between 0-1, Ex: 0 = Never lost, 0.5 = Half lost, 1 = All lost)
Default: DZE_crashLootConfig = [true,2,5,5,0];
*/
DZE_crashLootConfig = [true,2,5,5,0];



// DZEdebug = true;

//Load in compiled functions
call compile preprocessFileLineNumbers "Scripts\Variables\Variables.sqf";//Single Coin/Epoch Variables
call compile preprocessFileLineNumbers "origins\config.sqf";//Origins Configs
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "Scripts\Server_Compile\compiles.sqf";
call compile preprocessFileLineNumbers "origins\compiles.sqf";//Origins Compiles	
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "Scripts\Server_Traders\server_traders.sqf";
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	//dogOwner = []; //Experimental Dog Script
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_13.Tavi\dynamic_vehicle.sqf";				//Compile vehicle configs
	
	// Add trader citys
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_13.Tavi\mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
//----------------------Experimental Dog Script In Development Start-----------------------------
	//_id = player addEventHandler ["Respawn", {_id = [] spawn player_death; _nul = [] execVM "custom\dog\plrInit.sqf";}];
	//_nul = [] execVM "custom\dog\plrInit.sqf";
//----------------------Experimental Dog Script In Development End-------------------------------
	//Run the player monitor
	    _id = player addEventHandler ["Respawn", {_id = [] spawn player_death; _nul = [] execVM "playerspawn.sqf";}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	[] execVM "dzgm\init.sqf";
	_nul = [] execVM "playerspawn.sqf";
	
	if (DZE_AsReMix_PLAYER_HUD) then {
	execVM "Scripts\Player_Hud\playerHud.sqf"//Single Coin Debug Hud
    };
	execVM "player_tradermarkers.sqf";//Dynamic Traders
	execVM "custom\kill_msg.sqf";//Custom Kill Messages
	_nil = [] execVM "custom\JAEM\EvacChopper_init.sqf";//Evac Chopper
};
execVM "Scripts\Gold_Coin_system\init.sqf";//Single Coin Currency
//execVM "Scripts\Gold_Coin_system\Bank_Markers\addbankmarkers.sqf"; //Only Used For Static Banks

execVM "custom\DynamicWeatherEffects.sqf"; //Start Dynamic Weather No Rain/Fog
[] execVM "custom\SafeZone.sqf";
#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"
//Spawn Selection
waitUntil {!isNil ("PVDZE_plr_LoginRecord")};
if (dayzPlayerLogin2 select 2) then
{
    [] execVM "Scripts\spawnselection\DRNSpawn.sqf";
};
// Lift
_logistic = execVM "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";

