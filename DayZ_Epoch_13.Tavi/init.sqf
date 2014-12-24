/*-----------------Important Values------------------*/
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];
dayZ_instance = 13;	//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0; 
player setVariable ["BIS_noCoreConversations", true];
enableRadio false;
enableSentences false;
/*-----------------Important Values------------------*/
/*-----------------Epoch Configs------------------*/
// DZEdebug = true;
spawnShoremode = 0;
spawnArea = 2500;
DefaultMagazines = ["ItemBandage","ItemBandage","ItemPainkiller","ItemMorphine","6Rnd_45ACP"]; 
DefaultWeapons = ["ItemRadio","ItemToolbox","ItemMap","ItemHatchet_DZE","ItemCompass","revolver_EP1"]; 
DefaultBackpack = "DZ_Assault_Pack_EP1";
DefaultBackpackWeapon = "";
dayz_fullMoonNights = true;
dayz_minpos = -26000; 
dayz_maxpos = 26000;
dayz_sellDistance_vehicle = 20;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 50;
dayz_paraSpawn = false;
dayz_maxAnimals = 5;
dayz_tameDogs = true;
DynamicVehicleDamageLow = 0;
DynamicVehicleDamageHigh = 80;
DZE_ConfigTrader = true;
DZE_SelfTransfuse = true;
DZE_BuildOnRoads = true;
DZE_R3F_WEIGHT = false;
DZE_MissionLootTable = true;
DZE_GodModeBase = true;
DZE_BuildingLimit = 500;
dayz_MapArea = 20000;
MaxVehicleLimit = 400;
MaxDynamicDebris = 0;
/*-------------------Extra Configs--------------------*/
DZE_crashLootConfig = [true,2,5,5,0];
DZE_AsReMix_PLAYER_HUD = true;
DZE_Garage = ["Land_MBG_Garage_Single_A"];
/*------------------Events Start---------------------*/
EpochEvents = [
["any","any","any","any",15,"crash_spawner"],
["any","any","any","any",45,"crash_spawner"],
["any","any","any","any",15,"supply_drop"],
["any","any","any","any",30,"supply_drop"],
["any","any","any","any",45,"supply_drop"],
["any","any","any","any",0,"supply_drop"],
["any","any","any",4,50,"animated_crash_spawner"],
["any","any","any",8,20,"animated_crash_spawner"],
["any","any","any",12,10,"animated_crash_spawner"],
["any","any","any",16,45,"animated_crash_spawner"],
["any","any","any",20,15,"animated_crash_spawner"],
["any","any","any",23,30,"animated_crash_spawner"]
];
/*------------------Load in compiled functions---------------------*/
call compile preprocessFileLineNumbers "Scripts\Variables\Variables.sqf";//Single Coin/Epoch Variables
call compile preprocessFileLineNumbers "origins\config.sqf";//Origins Configs
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "dayz_code\Init\publicEH.sqf";//Initialize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "Scripts\Server_Compile\compiles.sqf";//Custom Compiles
call compile preprocessFileLineNumbers "origins\compiles.sqf";//Origins Compiles	
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "Scripts\Server_Traders\server_traders.sqf";//Traders Config
progressLoadingScreen 1.0;
"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";
/*------------------Load in Server Functions---------------------*/
if (isServer) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_13.Tavi\dynamic_vehicle.sqf";//Compile vehicle configs
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_13.Tavi\mission.sqf";//Add trader citys
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";//Server Monitor
};
/*------------------Load in Player Functions---------------------*/
if (!isDedicated) then {
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death; _nul = [] execVM "playerspawn.sqf";}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	[] execVM "dzgm\init.sqf";
	_nul = [] execVM "playerspawn.sqf";
	execVM "service_point\service_point.sqf";
	if (DZE_AsReMix_PLAYER_HUD) then {
		execVM "Scripts\Player_Hud\playerHud.sqf"
	};
	execVM "player_tradermarkers.sqf";
	execVM "custom\kill_msg.sqf";
	_nil = [] execVM "custom\JAEM\EvacChopper_init.sqf";
};
execVM "Scripts\Gold_Coin_system\init.sqf";
execVM "custom\DynamicWeatherEffects.sqf";
[] execVM "custom\SafeZone.sqf";
#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"
waitUntil {!isNil ("PVDZE_plr_LoginRecord")};
if (dayzPlayerLogin2 select 2) then
{
    [] execVM "Scripts\spawnselection\DRNSpawn.sqf";
};
_logistic = execVM "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";
call compile preprocessFileLineNumbers "addons\suicide\init.sqf";
//Christmas
[] execVM "Christmas\config.sqf"; 
