/*
Made by:
HALV
*/
if (isNil "GET_wepslist") then {
	GET_wepslist = [];
	_cfgweps = configFile >> "cfgWeapons";
	for "_i" from 0 to (count _cfgweps)-1 do {
		_weapon = _cfgweps select _i;
		if (isClass _weapon) then {
			_wpn_type = configName(_weapon);
			_plx = toArray _wpn_type;
			_plx resize 7;
			_plx;
			_plx = toString _plx;
			if (_plx != "ItemKey") then {
				if (((getNumber (_weapon >> "scope") == 0) or (getNumber (_weapon >> "scope") == 2)) && (getText (_weapon >> "picture") != "") && !(_wpn_type == "MineE") && !(_wpn_type == "ItemCore") && !(_wpn_type == "MeleeBaseBallBat")) then {
					GET_wepslist = GET_wepslist + [_wpn_type];
				};
			};
		};
	};
	titleText ["Weapons list loaded ...", "PLAIN DOWN"]; titleFadeOut 4;
	sleep 2;
};
if (isNil "GET_maglist") then {
	GET_maglist = [];
	_cfgweps = configFile >> "cfgmagazines";
	for "_i" from 0 to (count _cfgweps)-1 do {
		_weapon = _cfgweps select _i;
		if (isClass _weapon) then {
			_wpn_type = configName(_weapon);
			if (((getNumber (_weapon >> "scope") == 0) or (getNumber (_weapon >> "scope") == 2)) && (getText (_weapon >> "picture") != "") && !(_wpn_type == "AngelCookies") && !(_wpn_type == "SkinBase") && !(_wpn_type == "ItemBriefcase_Base")) then {
				GET_maglist = GET_maglist + [_wpn_type];
			};
		};
	};
	titleText ["Magazines list loaded ...", "PLAIN DOWN"]; titleFadeOut 2;
	sleep 2;
};
closeDialog 0;
titleText ["Ready to drop!\nClick On The Map", "PLAIN"]; titleFadeOut 4;
openMap [true, false];
Map_to_box1 = {
	#include "Settings.sqf";
	_patchpath = _thePath+"the_box3.sqf";
	_pos = [_this select 0, _this select 1, _this select 2] execVM _patchpath;
	onMapSingleClick "";
	openMap [false, false];
};
onMapSingleClick "[_pos select 0, _pos select 1, _pos select 2] call Map_to_box1;";