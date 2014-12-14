/*
	Taviana static spawn configuration 
	
	Last updated: 11:58 PM 6/6/2013
	
*/

#include "spawn_markers\markers_tavi.sqf"	//Load manual spawn point definitions file.

if ((DZAI_maxHeliPatrols > 0) or {(DZAI_maxLandPatrols > 0)}) then {
	"DZAI_centerMarker" setMarkerPos [10887.825, 11084.657, 1.5322094];
	"DZAI_centerMarker" setMarkerSize [8500, 8500];
};
	
waitUntil {sleep 0.1; !isNil "DZAI_classnamesVerified"};	//Wait for DZAI to finish verifying classname arrays or finish building classname arrays if verification is disabled.

if (DZAI_staticAI) then {
	//begin triggers

_this = createTrigger ["EmptyDetector", [6737.3384, 13217.881]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Sabina";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,250,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_64 = _this;

_this = createTrigger ["EmptyDetector", [6332.5972, 13137.449]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Podgorica";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,2,250,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_66 = _this;

_this = createTrigger ["EmptyDetector", [6780.4351, 13137.371]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Sabina NW";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_68 = _this;

_this = createTrigger ["EmptyDetector", [6513.646, 13332.008, 0.36575985]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Uyezd";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,250,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_70 = _this;

_this = createTrigger ["EmptyDetector", [22050.043, 19559.408, 3.4304581]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Swamp";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_72 = _this;

_this = createTrigger ["EmptyDetector", [22927.881, 20005.439]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Airport Dubovo";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_74 = _this;

_this = createTrigger ["EmptyDetector", [22018.963, 19751.293]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Swamp Military Base";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,175,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_76 = _this;

_this = createTrigger ["EmptyDetector", [22231.102, 19884.078, 6.0764122]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Dubovo Hotel";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [0,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_78 = _this;

_this = createTrigger ["EmptyDetector", [6550.5674, 12831.092]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Novy Bor";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,200,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_80 = _this;

_this = createTrigger ["EmptyDetector", [6447.7998, 12948.171]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Solibor";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,250,thisTrigger,[],1,2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_82 = _this;

_this = createTrigger ["EmptyDetector", [6877.6616, 12989.032]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Etanovsk";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,2,250,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_84 = _this;

_this = createTrigger ["EmptyDetector", [22277.076, 19663.525]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Doriyanov";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,200,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_88 = _this;

_this = createTrigger ["EmptyDetector", [22482.334, 19402.48]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Vinograd";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_90 = _this;

_this = createTrigger ["EmptyDetector", [22637.285, 20017.695]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Chrveni Gradok";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,200,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_92 = _this;

_this = createTrigger ["EmptyDetector", [22406.807, 19754.1]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Nina";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_94 = _this;

_this = createTrigger ["EmptyDetector", [22603.246, 19542.775]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Kustik";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_96 = _this;

_this = createTrigger ["EmptyDetector", [22991.629, 19231.879]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Zelenogorod";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_98 = _this;

_this = createTrigger ["EmptyDetector", [22670.758, 19302.74]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Bori";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_100 = _this;

_this = createTrigger ["EmptyDetector", [22922.732, 19818.5]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Stari Grad";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],1,2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_102 = _this;

_this = createTrigger ["EmptyDetector", [22317.596, 20103.32]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Dubravka";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,250,thisTrigger,[],2,2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_104 = _this;

_this = createTrigger ["EmptyDetector", [22858.803, 19665.053]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Vishkov";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,2,250,thisTrigger,[],1,2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_106 = _this;

_this = createTrigger ["EmptyDetector", [22638.521, 19389.838, 1.7702827]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Krakov";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_108 = _this;

_this = createTrigger ["EmptyDetector", [23100.641, 19437.141]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Yaroslav";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,250,thisTrigger,[],2,2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_110 = _this;

_this = createTrigger ["EmptyDetector", [23015.27, 19709.994]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Ekaterinburg";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_112 = _this;

_this = createTrigger ["EmptyDetector", [22924.15, 19273.525]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Kameni";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [0,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_114 = _this;

_this = createTrigger ["EmptyDetector", [22622.074, 19067.607]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Helfenburg";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,175,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_116 = _this;

_this = createTrigger ["EmptyDetector", [22365.049, 19231.963, 5.151721]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Dalnogorsk Docks";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,175,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_120 = _this;

_this = createTrigger ["EmptyDetector", [22172.793, 19343.457]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Dalnogorsk";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [0,2,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_122 = _this;

_this = createTrigger ["EmptyDetector", [22828.336, 19556.861, 0.0069999695]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Sevastopol";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,250,thisTrigger,[],1,2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_124 = _this;

_this = createTrigger ["EmptyDetector", [22705.338, 19750.561, 0.10200119]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Gorka";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_126 = _this;

_this = createTrigger ["EmptyDetector", [22882.922, 19763.734]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Sevastopol Mil Base";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,175,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_128 = _this;

_this = createTrigger ["EmptyDetector", [22697.117, 20048.188]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Martin Mil Base";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,175,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_130 = _this;

_this = createTrigger ["EmptyDetector", [22554.164, 19349.199]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Padynya";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_132 = _this;

_this = createTrigger ["EmptyDetector", [22578.418, 19698.539]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Martin";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_134 = _this;

_this = createTrigger ["EmptyDetector", [22930.27, 19693.656]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Church of St Ivan";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_136 = _this;

_this = createTrigger ["EmptyDetector", [22536.506, 19662.172, 0.071762085]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Molotovsk";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_138 = _this;

_this = createTrigger ["EmptyDetector", [22542.117, 19740.283]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Molotovski Zlaiv";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [0,1,150,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_140 = _this;

_this = createTrigger ["EmptyDetector", [22560.711, 20195.961, 0.42528534]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "DZAI Trigger";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,1,200,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_142 = _this;

_this = createTrigger ["EmptyDetector", [22648.467, 19843.32]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Jaroslavski Airport";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,2,250,thisTrigger,[],2] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_150 = _this;

_this = createTrigger ["EmptyDetector", [22422.859, 19590.203]];
_this setTriggerArea [600, 600, 0, false];
_this setTriggerActivation ["ANY", "PRESENT", true];
_this setTriggerTimeout [10, 15, 20, true];
_this setTriggerText "Khotanovsk";
_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [0,1,175,thisTrigger,[],1] call fnc_spawnBandits;", "nul = [thisTrigger] spawn fnc_despawnBandits;"];
_trigger_152 = _this;


	//end of triggers
};

#include "custom_markers\cust_markers_tavi.sqf"
#include "custom_spawns\cust_spawns_tavi.sqf"
//----------------------------Do not edit anything below this line -----------------------------------------
DZAI_customSpawnsReady = true;
diag_log "Taviana static spawn configuration loaded.";
