/**
 * mf-tow/init.sqf
 * The main script for initalising towing functionality. 
 *
 * Created by Matt Fairbrass (matt_d_rat)
 * Version: 1.1.2
 * MIT Licence
 **/

private ["_cursorTarget", "_towableVehicles", "_towableVehiclesTotal"];

// Public variables
MF_Tow_Base_Path		= "mf-tow"; 		// The base path to the MF-Tow Folder.
MF_Tow_Distance			= 10;					// Minimum distance (in meters) away from vehicle the tow truck must be to tow.
MF_Tow_Multi_Towing	 	= false;				// Allow a vehicle which is towing another vehicle already to be towed by another tow. Disabled by default.

// Functions
MF_Tow_Vehicles	= [
	"Truck",
	"Wheeled_APC",
	"BRDM2_Base",
	"BTR90_Base",
	"GAZ_Vodnik_HMG",
	"LAV25_Base",
	"M1126_ICV_BASE_EP1",
	"StrykerBase_EP1",
	"M1126_ICV_mk19_EP1",
	"M1126_ICV_M2_EP1",
	"BTR40_MG_base_EP1",
	"BTR40_base_EP1",
	"hilux1_civil_1_open",
	"HMMWV_Base",
	"Lada_base",
	"Offroad_DSHKM_base",
	"Pickup_PK_base",
	"SkodaBase",
	"tractor",
	"VWGolf",
	"Volha_TK_CIV_Base_EP1",
	"S1203_TK_CIV_EP1",
	"SUV_Base_EP1",
	"ArmoredSUV_Base_PMC",
	"UAZ_Base",
	"LandRover_Base",
	"GLT_M300_LT",
	"GLT_M300_ST",
	"TowingTractor"
];
/**
 * Returns an array of towable objects which can be pulled by the tow truck.
 * Configure this as required to set which vehicles can pull which types of other vehicles.
 **/
MF_Tow_Towable_Array =
{
    private ["_array","_towTruck"];
    _towTruck = _this select 0;
	_array = [];
	
	switch (typeOf _towTruck) do
	{
		case "Truck": 					{_array = ["Truck","GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open","GAZ_Vodnik_HMG","BRDM2_Base","BTR40_MG_base_EP1","BTR40_base_EP1"];};
		case "Wheeled_APC": 			{_array = ["Motorcycle","Car","Truck","Wheeled_APC","Tracked_APC","M1126_ICV_BASE_EP1","StrykerBase_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","BTR40_MG_base_EP1","BTR40_base_EP1","BTR90_Base","GAZ_Vodnik_HMG"];};
		case "BRDM2_Base": 				{_array = ["Truck","GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open","GAZ_Vodnik_HMG","BRDM2_Base","BTR40_MG_base_EP1","BTR40_base_EP1"];};
		case "BTR90_Base": 				{_array = ["Truck","GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open","GAZ_Vodnik_HMG","BRDM2_Base","BTR40_MG_base_EP1","BTR40_base_EP1","BTR90_Base"];};
		case "GAZ_Vodnik_HMG": 			{_array = ["Truck","GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open","GAZ_Vodnik_HMG","BRDM2_Base","BTR40_MG_base_EP1","BTR40_base_EP1"];};
		case "LAV25_Base": 				{_array = ["Motorcycle","Car","Truck","Wheeled_APC","Tracked_APC","M1126_ICV_BASE_EP1","StrykerBase_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","BTR40_MG_base_EP1","BTR40_base_EP1","BTR90_Base","GAZ_Vodnik_HMG"];};
		case "M1126_ICV_BASE_EP1": 		{_array = ["Motorcycle","Car","Truck","Wheeled_APC","Tracked_APC","M1126_ICV_BASE_EP1","StrykerBase_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","BTR40_MG_base_EP1","BTR40_base_EP1","BTR90_Base","GAZ_Vodnik_HMG"];};
		case "StrykerBase_EP1": 		{_array = ["Motorcycle","Car","Truck","Wheeled_APC","Tracked_APC","M1126_ICV_BASE_EP1","StrykerBase_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","BTR40_MG_base_EP1","BTR40_base_EP1","BTR90_Base","GAZ_Vodnik_HMG"];};
		case "M1126_ICV_mk19_EP1": 		{_array = ["Motorcycle","Car","Truck","Wheeled_APC","Tracked_APC","M1126_ICV_BASE_EP1","StrykerBase_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","BTR40_MG_base_EP1","BTR40_base_EP1","BTR90_Base","GAZ_Vodnik_HMG"];};
		case "M1126_ICV_M2_EP1": 		{_array = ["Motorcycle","Car","Truck","Wheeled_APC","Tracked_APC","M1126_ICV_BASE_EP1","StrykerBase_EP1","M1126_ICV_mk19_EP1","M1126_ICV_M2_EP1","BTR40_MG_base_EP1","BTR40_base_EP1","BTR90_Base","GAZ_Vodnik_HMG"];};
		case "BTR40_MG_base_EP1": 		{_array = ["Truck","GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open","GAZ_Vodnik_HMG","BRDM2_Base","BTR40_MG_base_EP1","BTR40_base_EP1"];};
		case "BTR40_base_EP1": 			{_array = ["Truck","GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open","GAZ_Vodnik_HMG","BRDM2_Base","BTR40_MG_base_EP1","BTR40_base_EP1"];};
		case "hilux1_civil_1_open": 	{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open"];};
		case "HMMWV_Base": 				{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open"];};
		case "Lada_base": 				{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "Offroad_DSHKM_base": 		{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","hilux1_civil_1_open"];};
		case "Pickup_PK_base": 			{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","hilux1_civil_1_open"];};
		case "SkodaBase": 				{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "tractor": 				{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "VWGolf": 					{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "Volha_TK_CIV_Base_EP1": 	{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "S1203_TK_CIV_EP1": 		{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "SUV_Base_EP1": 			{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open"];};
		case "ArmoredSUV_Base_PMC": 	{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open"];};
		case "UAZ_Base": 				{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","hilux1_civil_1_open"];};
		case "LandRover_Base": 			{_array = ["GLT_M300_ST","GLT_M300_LT","LandRover_Base","UAZ_Base","ArmoredSUV_Base_PMC","SUV_Base_EP1","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Offroad_DSHKM_base","Lada_base","HMMWV_Base","hilux1_civil_1_open"];};
		case "GLT_M300_LT": 			{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "GLT_M300_ST": 			{_array = ["GLT_M300_ST","GLT_M300_LT","UAZ_Base","S1203_TK_CIV_EP1","Volha_TK_CIV_Base_EP1","VWGolf","tractor","SkodaBase","Pickup_PK_base","Lada_base"];};
		case "TowingTractor": 			{_array = ["Motorcycle","Car","Truck","Wheeled_APC","Tracked_APC","Air"];};
	};
	
	_array
};

/**
 * Animate the player in a towing action, whilst attaching them to the tow vehicle to ensure safety.
 **/
MF_Tow_Animate_Player_Tow_Action =
{
	private ["_towTruck","_offsetZ"];
	_towTruck = _this select 0;
	_offsetZ = 0.1;
	
	// Bounding box on UAZ is screwed, offset z-axis correctly
	if(_towTruck isKindOf "UAZ_Base") then {
		_offsetZ = 1.8;
	};
	
	[player,20,true,(getPosATL player)] spawn player_alertZombies; // Alert nearby zombies
	[1,1] call dayz_HungerThirst; // Use some hunger and thirst to perform the action
	
	// Attach the player to the tow truck temporarily for safety so that they aren't accidentally hit by the vehicle when it gets attached
	player attachTo [_towTruck, 
		[
			(boundingBox _towTruck select 1 select 0),
			(boundingBox _towTruck select 0 select 1) + 1,
			(boundingBox _towTruck select 0 select 2) - (boundingBox player select 0 select 2) + _offsetZ
		]
	];

	player setDir 270;
	player setPos (getPos player);
	player playActionNow "Medic"; // Force the animation
};

MF_Tow_Get_Vehicle_Name =
{
	private ["_vehicle", "_configVeh", "_vehicleName"];
	_vehicle = _this select 0;
	
	_configVeh = configFile >> "cfgVehicles" >> TypeOf(_vehicle);
	_vehicleName = getText(_configVeh >> "displayName");
	
	_vehicleName
};

// Initialise script
_cursorTarget = cursorTarget;
_towableVehicles = [_cursorTarget] call MF_Tow_Towable_Array;
_towableVehiclesTotal = count (_towableVehicles);

// Add the action to the players scroll wheel menu if the cursor target is a vehicle which can tow.
if(_towableVehiclesTotal > 0) then {
	if (s_player_towing < 0) then {
		if(!(_cursorTarget getVariable ["MFTowIsTowing", false])) then {
			s_player_towing = player addAction ["Attach Tow", format["%1\tow_AttachTow.sqf", MF_Tow_Base_Path], _cursorTarget, 0, false, true, "",""];				
		} else {
			s_player_towing = player addAction ["Detach Tow", format["%1\tow_DetachTow.sqf", MF_Tow_Base_Path], _cursorTarget, 0, false, true, "",""];			
		};
	};
} 
else {
	player removeAction s_player_towing;
	s_player_towing = -1;
};