/*
Made by:
HALV
*/
//private ["_Del_Box","_wepcount","_magcount","_Del_BoxTime","_TheModel","_randcont","_randombox","_plane_start","_pos","_hcGPname","_hcGPUID","_sweetspot","_dist","_Drop_plane","_message","_aigroup","_wp","_pilot","_dropspot1","_sweetspot2","_message2","_wp2","_dropDir","_dropspot2","_pos2","_chute","_box","_smoke1","_smoke2","_flare1","_i","_bam","_smoke3","_smoke4","_flare2","_sweetspot3","_Del_BoxTimeout"];
onMapSingleClick "";
openMap [false, false];
#include "Settings.sqf";
_randcont = _DROPbox call BIS_fnc_selectRandom;
_randombox = _THEboxes call BIS_fnc_selectRandom;
_TheModel = _planeheli call BIS_fnc_selectRandom;
_text = getText (configFile >> "CfgVehicles" >> _TheModel >> "displayName");
_text2 = getText (configFile >> "CfgVehicles" >> _randcont >> "displayName");
_text3 = getText (configFile >> "CfgVehicles" >> _randombox >> "displayName");
_hasRC = _RCitem in items player;
_plane_start = _start_pos call BIS_fnc_selectRandom;
_pos = [_this select 0, _this select 1, _this select 2];
_dist = (_pos distance _plane_start);
hint format ["All-In-A-Package Called In @\n***(%1)***\nContainer:\n%8\n(%2)\nFinal box:\n%9\n(%3)\n%4\nTransporter:\n%7\n(%5)\nDistance to drop spot:\n%6KM" , (mapGridPosition _pos), _randcont, _randombox,_pos,_TheModel,(round(_dist/1000)),_text,_text2,_text3];
diag_log format["Halfcare V2.0 (Admin) Called In: %1 DropBoxtype (%8) - (%2) WeaponsBox (%9) - (%3) Transporter %7 (%4) Dist (%5) Start pos %6", _pos, _randcont, _randombox,_TheModel,_dist,_plane_start,_text,_text2,_text3];

_Drop_plane = createVehicle [_TheModel, _plane_start, [], 0, "FLY"];
_Drop_plane setVariable["Sarge",1,true];
_Drop_plane engineOn true;
_Drop_plane flyInHeight 150;
_Drop_plane forceSpeed 175;
_Drop_plane setspeedmode "LIMITED";

clearMagazineCargoGlobal _Drop_plane;
clearWeaponCargoGlobal _Drop_plane;

_aigroup = creategroup civilian;

_pilot = _aigroup createUnit ["SurvivorW2_DZ",getPos _Drop_plane,[],0,"FORM"];
_pilot moveindriver _Drop_plane;
_pilot assignAsDriver _Drop_plane;

HALV_says_DROPNOW_admin=false;
HALV_DROPcontrol_HALV3=false;

_wp = _aigroup addWaypoint [[(_pos select 0), (_pos select 1),150], 0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointStatements ["true", "HALV_says_DROPNOW_admin=true"];
_wp_pos = waypointPosition [_aigroup,1];

_pilot addWeapon 'NVGoggles';
_pilot addWeapon 'ItemCompass';
_pilot addWeapon 'ItemMap';
_pilot addWeapon 'ItemGPS';

sleep 5;
if (!_hasRC) then {
	_rctxt = (gettext (configFile >> 'cfgWeapons' >> _RCitem >> 'displayName'));
	cutText [format["(If you have a %1 you get advanced drop control and debug info)",_rctxt], "PLAIN DOWN"];
};
_DROP_Action=0;
_Dohintonce=true;
_SetSpeedOnce=true;
while {(_Drop_plane distance _wp_pos) > 500} do {
	scopeName "loop1";
	if (HALV_says_DROPNOW_admin || not alive _Drop_plane || not alive _pilot) then {breakOut "loop1";player removeAction The_DropAction3};
	_hasRC = _RCitem in items player;
	if (_hasRC) then {
		if (_DROP_Action==0) then {
			The_DropAction3 = player addAction [
			"<t color='#FF0000'>Dump airdrop cargo ...</t>",
			_thePath+"drop_now3.sqf",
			"", 
			5, 
			true, 
			true, 
			"", 
			""
			];
			_DROP_Action=1;
			hint "";
			cutText ["Advanced drop control and debug functions enabled!", "PLAIN DOWN"];
		};
		_pic1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'picture'));
		_txt1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'displayName'));
		_txt2 = (gettext (configFile >> 'CfgVehicles' >> _randcont >> 'displayName'));
		_txt3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'displayName'));
		_dist = (_Drop_plane distance _wp_pos);
		_GPS = (mapGridPosition getpos _Drop_plane);
		hintsilent parseText format ["
		<t size='1'font='Bitstream'align='Center'>AdminDrop Enroute @</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#5882FA'>***(%1)***</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#c70000'>Transporter:</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#FFCC00'>%2</t><br/>
		<t size='1'font='Bitstream'align='Center'>[%3]</t><br/>
		<img size='5' image='%4'/><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#c70000'>Container:</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#FFCC00'>%6</t><br/>
		<t size='1'font='Bitstream'align='Center'>[%5]</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#c70000'>Final box:</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#FFCC00'>%8</t><br/>
		<t size='1'font='Bitstream'align='Center'>[%7]</t><br/>
		<t size='1.25'font='Bitstream'align='left'>Distance:</t><t size='1.25'font='Bitstream'align='right'>Speed:</t><br/>
		<t size='1.5'font='Bitstream'align='left'>%9Km</t><t size='1.5'font='Bitstream'align='right'>%10Km/h</t><br/>
		",
		_GPS,
		_txt1,
		_TheModel,
		_pic1,
		_txt2,
		_randcont,
		_txt3,
		_randombox,
		(_dist/1000),
		(round(speed _Drop_plane))
		];
	}else{
		if (_DROP_Action==1) then {
			player removeAction The_DropAction3;
			_DROP_Action=0;
			sleep 1.5;
			hintsilent "";
			cutText ["Advanced drop control disabled!", "PLAIN DOWN"];
		};
	};
	if (alive _Drop_plane && (_Drop_plane distance _wp_pos) <= 2555 && _Dohintonce ) then {
		_Dohintonce=false;
		hintsilent "";
		_txt1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'displayName'));
		hint format["The\n%2\n(%1)\nIs now 2,5KM from the drop spot ...\nGet ready!",_TheModel,_txt1];
	};
	if (alive _Drop_plane && (_Drop_plane distance _wp_pos) <= 1100 && _SetSpeedOnce ) then {
		_SetSpeedOnce=false;
		_Drop_plane forceSpeed 175;
		_Drop_plane flyInHeight 135;
		_Drop_plane setspeedmode "LIMITED";
	};
	sleep 1;
};
waituntil {(_Drop_plane distance _wp_pos) <= 200 || not alive _Drop_plane || not alive _pilot || HALV_says_DROPNOW_admin};
while {_ADVDroptimeOut > 0} do {
	scopeName "loop1";
	_hasRC = _RCitem in items player;
	if (HALV_DROPcontrol_HALV3 || not alive _Drop_plane || not alive _pilot) then {breakOut "loop1"};
	if (_hasRC) then {
		_pic1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'picture'));
		_txt1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'displayName'));
		_dist = (_Drop_plane distance _wp_pos);
		_GPS = (mapGridPosition getpos _Drop_plane);
		hintsilent parseText format ["
		<t size='1'font='Bitstream'align='Center'>RandomDrop @</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#5882FA'>***(%1)***</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#c70000'>Transporter:</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#FFCC00'>%2</t><br/>
		<t size='1'font='Bitstream'align='Center'>[%3]</t><br/>
		<img size='5' image='%4'/><br/>
		<t size='1.25'font='Bitstream'align='left'>Distance:</t><t size='1.25'font='Bitstream'align='right'>Speed:</t><br/>
		<t size='1.5'font='Bitstream'align='left'>%5m</t><t size='1.5'font='Bitstream'align='right'>%6Km/h</t><br/>
		",
		_GPS,
		_txt1,
		_TheModel,
		_pic1,
		(round _dist),
		(round(speed _Drop_plane))
		];
		cutText [format["**Awaiting drop orders**\n(%1 sec to auto drop)",(round _ADVDroptimeOut)], "PLAIN DOWN", 0.1];
	} else {breakOut "loop1"};
	sleep 0.1;
	_ADVDroptimeOut=_ADVDroptimeOut-0.1;
};
if (_DROP_Action==1) then {
	player removeAction The_DropAction3;
	_DROP_Action=0;
};
if (HALV_DROPcontrol_HALV3 && (_Drop_plane distance _wp_pos) > 2500) then{
	_dist = (_Drop_plane distance _wp_pos);
	cutText [format["You dropped the box around (%1)\nDistance from waypoint %2Km",(mapGridPosition getpos _Drop_plane),(_dist/1000)],"PLAIN DOWN"];
} else {
	cutText ["Dumping Carepackage", "PLAIN DOWN"];
};
HALV_says_DROPNOW_admin=false;
HALV_DROPcontrol_HALV3=false;

sleep 0.25;

switch (true) do {
	case not (alive _Drop_plane): {
		_txt1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'displayName'));
		_message2 = format["The\n%2\n(%1)\n was shot down or crashed around:\n***(%2)***",_TheModel,(mapGridPosition getPos _Drop_plane),_txt1]; 
		if (_BCast) then {
			[nil, nil, rHINT, _message2] call RE;
		} else {
			hint _message2; 
		};
diag_log format["Halfcare V2.0 Called In: %1 DropBoxtype (%2) WeaponsBox (%3) %4 crashed, dumping package", getPos _Drop_plane, _randcont, _randombox,_TheModel]; 
	};
	case alive _Drop_plane: {
		sleep 0.75;
		_txt1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'displayName'));
		_message2 = format["The\n%3\n(%1)\nIs now @\n***(%2)***\nDumping Carepackage!",_TheModel,(mapGridPosition getPos _Drop_plane),_txt1]; 
		if (_BCast) then {
			[nil, nil, rHINT, _message2] call RE;
		} else {
			hint _message2; 
		};
		_plane_end = _start_pos call BIS_fnc_selectRandom;
diag_log format["Halfcare V2.0 Called In: %1 DropBoxtype (%2) WeaponsBox (%3) %4 dumping package and flying to %5", getPos _Drop_plane, _randcont, _randombox,_TheModel,_plane_end]; 
		deleteWaypoint [_aigroup, 1];
		_wp2 = _aigroup addWaypoint [_plane_end, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";
		_Drop_plane forceSpeed 350;
		_Drop_plane setspeedmode "FULL";
	};
};
sleep 0.5;

_dropDir = getDir _Drop_plane;
_pos2 = [(getPosATL _Drop_plane select 0)-15*sin(_dropDir), (getPosATL _Drop_plane select 1)-15*cos(_dropDir), (getPosATL _Drop_plane select 2)-10]; //-15m behind plane and -10 hight
_chute = createVehicle ["ParachuteMediumEast", _pos2, [], 0, "FLY"];
_chute setVariable["Sarge",1,true];
_box = createVehicle [_randcont,_pos2,[], 0, "CAN_COLLIDE"];
_box setVariable["Sarge",1,true];
_box attachTo [_chute, [0, 0, 1]];
_smoke1 = createVehicle ["SmokeShell",_pos2,[], 0, "CAN_COLLIDE"];
_smoke1 setVariable["Sarge",1,true];
_smoke1 attachTo [_box,[0, 0, 0]];
_smoke2 = createVehicle ["SmokeShellRed",_pos2,[], 0, "CAN_COLLIDE"];
_smoke2 setVariable["Sarge",1,true];
_smoke2 attachTo [_box,[1, 1, 0]];
_flare1 = createVehicle ["F_40mm_white",[_pos2 select 0, _pos2 select 1, (_pos2 select 2) +100],[], 0, "CAN_COLLIDE"];
_flare1 setVariable["Sarge",1,true];

_pilot removeweapon 'NVGoggles';
_pilot removeweapon 'ItemCompass';
_pilot removeweapon 'ItemMap';
_pilot removeweapon 'ItemGPS';

_i = 0;
while {_i < 45} do {
	scopeName "loop1";
	if (((getPos _box) select 2) < 1) then {breakOut "loop1"};
	sleep 0.1;
	_i=_i+0.1;
};

switch (true) do {
	case not (alive _box): {
		detach _box;
		_box setpos [(getpos _box select 0), (getpos _box select 1), 0];
	};
	case alive _box: {
		detach _box;
		_box setpos [(getpos _box select 0), (getpos _box select 1), 0];
		_bam = createVehicle [_randombox,[(getpos _box select 0),(getpos _box select 1), 0],[],0,"CAN_COLLIDE"];
		_bam setVariable["Sarge",1,true];
		deletevehicle _box;
		deletevehicle _chute;
		clearMagazineCargoGlobal _bam;
		clearWeaponCargoGlobal _bam;
		{_bam addWeaponCargoGlobal [_x, _wepcount];} forEach GET_wepslist;
		{_bam addMagazineCargoGlobal [_x, _magcount];} forEach GET_maglist;
		_bam addBackpackCargoGlobal [_baGType, 1];
		if (_akeYKits) then {
			_bam addWeaponCargoGlobal ["ItemKeyKit", _keYKits];
		};
		_pos3 = [getpos _bam select 0, getpos _bam select 1,0];
		_smoke3 = createVehicle ["SmokeShell",_pos3,[],0,"CAN_COLLIDE"];
		_smoke3 setVariable["Sarge",1,true];
		_smoke4 = createVehicle ["SmokeShellred",_pos3,[],0,"CAN_COLLIDE"];
		_smoke4 setVariable["Sarge",1,true];
		_flare2 = createVehicle ["F_40mm_white",[_pos3 select 0, _pos3 select 1, (_pos3 select 2) +150],[], 0, "CAN_COLLIDE"];
		_flare2 setVariable["Sarge",1,true];
diag_log format["Halfcare V2.0 Landed at %1 Boxtype %2 landed and switched, smoke and flare fired H3", _pos3, _randombox];
		if (_Del_aBox) then {
			_Del_BoxTimeout = _Del_BoxTime + 60;
			_txt3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'displayName'));
			_GPS = (mapGridPosition _pos3);
			hint parseText format ["
			<t size='1'font='Bitstream'align='Center'>Admin Drop Landed @</t><br/>
			<t size='1.25'font='Bitstream'align='Center'color='#00CC00'>***(%1)***</t><br/>
			<t size='1'font='Bitstream'align='Center'color='#c70000'>Box Type:</t><br/>
			<t size='1.25'font='Bitstream'align='Center'>%3</t><br/>
			<t size='1'font='Bitstream'align='Center'color='#FFCC00'>[%2]</t><br/>
			<t size='0.75'font='Bitstream'align='Center'>Box will be deleted in:</t><br/>
			<t size='0.75'font='Bitstream'align='Center'>%4Min</t><br/>
			",
			_GPS,
			_randombox,
			_txt3,
			(round(_Del_BoxTimeout/60))
			];
			sleep 60;
			deletevehicle _Drop_plane;
			deletevehicle _pilot;
			sleep _Del_BoxTime;
			clearWeaponCargoGlobal _bam;
			clearMagazineCargoGlobal _bam;
			clearBackpackCargoGlobal _bam;
			deletevehicle _bam;
			hint "The box is now gone ...";
diag_log format["Halfcare V2.0 Box Deleted at %1 Boxtype %2", _pos3, _randombox];
		} else {
			_txt3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'displayName'));
			_GPS = (mapGridPosition _pos3);
			hint parseText format ["
			<t size='1'font='Bitstream'align='Center'>Admin Drop Landed @</t><br/>
			<t size='1.25'font='Bitstream'align='Center'color='#00CC00'>***(%1)***</t><br/>
			<t size='1'font='Bitstream'align='Center'color='#c70000'>Box Type:</t><br/>
			<t size='1.25'font='Bitstream'align='Center'>%3</t><br/>
			<t size='1'font='Bitstream'align='Center'color='#FFCC00'>[%2]</t><br/>
			",
			_GPS,
			_randombox,
			_txt3
			];
			sleep 60;
			deletevehicle _Drop_plane;
			deletevehicle _pilot;
		};
	};
};