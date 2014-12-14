/*
Made by:
HALV
*/
closedialog 0;
titleText ["Click On The Map", "PLAIN DOWN"]; titleFadeOut 4;
openMap [true, false];
Map_to_box = {
	#include "Settings.sqf";
	_patchpath = _thePath+"the_box.sqf";
	_pos = [_this select 0, _this select 1, _this select 2] execVM _patchpath;
	onMapSingleClick "";
	openMap [false, false];
};
onMapSingleClick "[_pos select 0, _pos select 1, _pos select 2] call Map_to_box;";