/*
Made by:
HALV
*/
//private ["_Del_Box","_BCast","_Del_BoxTime","_TheModel","_randcont","_randombox","_plane_start","_pos","_hcGPname","_hcGPUID","_sweetspot","_dist","_Drop_plane","_message","_aigroup","_wp","_pilot","_dropspot1","_sweetspot2","_message2","_wp2","_dropDir","_dropspot2","_pos2","_chute","_box","_smoke1","_smoke2","_flare1","_i","_bam","_smoke3","_smoke4","_flare2","_sweetspot3","_Del_BoxTimeout"];
onMapSingleClick "";
openMap [false, false];
#include "Settings.sqf";
_TheModel = _planeheli call BIS_fnc_selectRandom;
if (_TheModel isKindOf "An2_Base_EP1") then {_TheModel="MV22"};
_randombox = THElandlist2 call BIS_fnc_selectRandom;
_plane_start = _start_pos call BIS_fnc_selectRandom;
_pos = [_this select 0, _this select 1, _this select 2];
_hasRC = _RCitem in items player;
_hcGPUID = getPlayerUID player;
_dist = (_pos distance _plane_start);
_txt1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'displayName'));
_txt3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'displayName'));
_message = format["CareCar called in:\n%5\n(%1)\nBy:\n%2\nTransporter:\n%4\n(%3)\nDistance:\n%6KM",_randombox , dayz_playerName,_TheModel,_txt1,_txt3,(round(_dist/1000))];
if (_BCast) then {
	[nil, nil, rHINT, _message] call RE;
} else {
	hint _message;
};
diag_log format["RandomCar V2.0 Called In by: (%2) - (UID: %3) Start at: %6 Drop at: %1 Transporter: (%5) Vehicle type: (%4)", _pos, dayz_playerName, _hcGPUID, _randombox,_TheModel,_plane_start]; 

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

HALV_says_DROPNOW_veh=false;
HALV_DROPcontrol_HALVveh=false;

_wp = _aigroup addWaypoint [[(_pos select 0), (_pos select 1),150], 0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointStatements ["true", "HALV_says_DROPNOW_veh=true"];
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
	if (HALV_says_DROPNOW_veh || not alive _Drop_plane || not alive _pilot) then {breakOut "loop1";player removeAction The_DropAction1};
	_hasRC = _RCitem in items player;
	if (_hasRC) then {
		if (_DROP_Action==0) then {
			The_DropAction1 = player addAction [
			"<t color='#FF0000'>Dump airdrop vehicle ...</t>",
			_thePath+"drop_nowveh.sqf",
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
		_pic3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'picture'));
		_txt3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'displayName'));
		_dist = (_Drop_plane distance _wp_pos);
		_GPS = (mapGridPosition getpos _Drop_plane);
		hintsilent parseText format ["
		<t size='1'font='Bitstream'align='Center'>Random Vehicle Enroute @</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#5882FA'>***(%1)***</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#c70000'>Transporter:</t><br/>
		<img size='5' image='%2'/><br/>
		<t size='1.25'font='Bitstream'align='Center'>%3</t><br/>
		<t size='1'font='Bitstream'align='Center'color='#FFCC00'>[%7]</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#c70000'>Vehicle:</t><br/>
		<img size='5' image='%5'/><br/>
		<t size='1.25'font='Bitstream'align='Center'>%6</t><br/>
		<t size='1'font='Bitstream'align='Center'color='#FFCC00'>[%4]</t><br/>
		<t size='1.25'font='Bitstream'align='left'>Distance:</t><t size='1.25'font='Bitstream'align='right'>Speed:</t><br/>
		<t size='1.5'font='Bitstream'align='left'>%8Km</t><t size='1.5'font='Bitstream'align='right'>%9Km/h</t><br/>
		",
		_GPS,
		_pic1,
		_txt1,
		_randombox,
		_pic3,
		_txt3,
		_TheModel,
		(_dist/1000),
		(round(speed _Drop_plane))
		];
	}else{
		if (_DROP_Action==1) then {
			player removeAction The_DropAction1;
			_DROP_Action=0;
			sleep 2;
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
waituntil {(_Drop_plane distance _wp_pos) <= 200 || not alive _Drop_plane || not alive _pilot || HALV_says_DROPNOW_veh};
while {_ADVDroptimeOut > 0} do {
	scopeName "loop1";
	_hasRC = _RCitem in items player;
	if (HALV_DROPcontrol_HALVveh || not alive _Drop_plane || not alive _pilot) then {breakOut "loop1"};
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
	player removeAction The_DropAction1;
	_DROP_Action=0;
};
if (HALV_DROPcontrol_HALVveh && (_Drop_plane distance _wp_pos) > 2500) then{
	_dist = (_Drop_plane distance _wp_pos);
	cutText [format["You dropped the Vehicle around (%1)\nDistance from waypoint %2Km",(mapGridPosition getpos _Drop_plane),(_dist/1000)],"PLAIN DOWN"];
} else {
	cutText ["Dumping Vehicle", "PLAIN DOWN"];
};
HALV_says_DROPNOW_veh=false;
HALV_DROPcontrol_HALVveh=false;

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
diag_log format["RandomCar V2.0 Crash: %1 Vehicle (%2) Model (%3) crashed, dumping Vehicle", getpos _Drop_plane, _randombox,_TheModel]; 
	};
	case alive _Drop_plane: {
		sleep 0.75;
		_txt1 = (gettext (configFile >> 'CfgVehicles' >> _TheModel >> 'displayName'));
		_message2 = format["The\n%3\n(%1)\nIs now @\n***(%2)***\nDumping Vehicle!",_TheModel,(mapGridPosition getPos _Drop_plane),_txt1]; 
		if (_BCast) then {
			[nil, nil, rHINT, _message2] call RE;
		} else {
			hint _message2; 
		};
		_plane_end = _start_pos call BIS_fnc_selectRandom;
diag_log format["RandomCar V2.0 Called In: %1 Vehicle (%2) Model (%3) dumping vehicle and flying to %4", getpos _Drop_plane, _randombox,_TheModel,_plane_end]; 
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
_box = createVehicle [_randombox,_pos2,[], 0, "CAN_COLLIDE"];
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
		detach _box;_box setpos [(getpos _box select 0), (getpos _box select 1), 0];
		_bam = createVehicle [_randombox,[(getpos _box select 0),(getpos _box select 1), 0],[],0,"CAN_COLLIDE"];
		_bam setVariable["Sarge",1,true];
		deletevehicle _box;
		deletevehicle _chute;
		if (_Clr_VehInv) then {
			clearMagazineCargoGlobal _bam;
			clearWeaponCargoGlobal _bam;
		};
		if(_Vehammo==0) then {
			_bam setVehicleAmmo 0;
		};
		if(_Vehammo==1) then {
			_bam setVehicleAmmo 0.2;
		};
		if(_Vehammo==2) then {
			_bam setVehicleAmmo 1;
		};
		_pos3 = [getpos _bam select 0, getpos _bam select 1,0];
		_smoke3 = createVehicle ["SmokeShell",_pos3,[],0,"CAN_COLLIDE"];
		_smoke3 setVariable["Sarge",1,true];
		_smoke4 = createVehicle ["SmokeShellred",_pos3,[],0,"CAN_COLLIDE"];
		_smoke4 setVariable["Sarge",1,true];
		_flare2 = createVehicle ["F_40mm_white",[_pos3 select 0, _pos3 select 1, (_pos3 select 2) +150],[], 0, "CAN_COLLIDE"];
		_flare2 setVariable["Sarge",1,true];
		_pic3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'picture'));
		_txt3 = (gettext (configFile >> 'CfgVehicles' >> _randombox >> 'displayName'));
		_GPS = (mapGridPosition _pos3);
		hint parseText format ["
		<t size='1'font='Bitstream'align='Center'>Random Vehicle Landed @</t><br/>
		<t size='1.25'font='Bitstream'align='Center'color='#00CC00'>***(%1)***</t><br/>
		<t size='1'font='Bitstream'align='Center'color='#c70000'>Vehicle:</t><br/>
		<img size='5' image='%3'/><br/>
		<t size='1.25'font='Bitstream'align='Center'>%4</t><br/>
		<t size='1'font='Bitstream'align='Center'color='#FFCC00'>[%2]</t><br/>
		",
		_GPS,
		_randombox,
		_pic3,
		_txt3
		];
diag_log format["RandomCar landed at: %1 Vehicle type: (%2) Car landed and switched, smoke and flare fired H3", _pos3, _randombox];
		sleep 60;
		deletevehicle _Drop_plane;
		deletevehicle _pilot;
	};
};