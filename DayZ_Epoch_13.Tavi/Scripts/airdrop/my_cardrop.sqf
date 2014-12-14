/*
Made by:
HALV
*/
#include "Settings.sqf";
#define RANDOMCAR_ARRAY(a,b) [##a,##b] call {_veh = _this select 0;_types = _this select 1;_res = false; {if (_veh isKindOf _x) exitwith { _res = true };}forEach _types;_res}
if (isNil "THElandlist2") then {
	THElandlist2 = [] ;
	_kindOf = _TheVehList;
	_filter = _TheVehNogoList;
	_cfgvehicles = configFile >> "cfgVehicles";
	titleText ["Generating Vehicle list... Please Wait...","PLAIN DOWN"];titleFadeOut 2;
	for "_i" from 0 to (count _cfgvehicles)-1 do {
		_vehicle = _cfgvehicles select _i;
		if (isClass _vehicle) then {
			_veh_type = configName(_vehicle);
			if (
				(getNumber(_vehicle >> "scope")==2) and 
				(getText(_vehicle >> "picture")!="") and 
				(RANDOMCAR_ARRAY(_veh_type,_kindOf)) and 
				!(RANDOMCAR_ARRAY(_veh_type,_filter))) 
			then 
			{THElandlist2 set [count THElandlist2,_veh_type];};
		};
	};
	titleText ["List is ready...","PLAIN DOWN"];titleFadeOut 2;
};
closeDialog 0;
titleText ["Click On The Map \n(Airdrop vehicles do not save after restart!)", "PLAIN DOWN"]; titleFadeOut 4;
openMap [true, false];
Map_to_box_veh = {
	#include "Settings.sqf";
	_patchpath = _thePath+"the_box_car.sqf";
	_pos = [_this select 0, _this select 1, _this select 2] execVM _patchpath;
	onMapSingleClick "";
	openMap [false, false];
};
onMapSingleClick "[_pos select 0, _pos select 1, _pos select 2] call Map_to_box_veh;";