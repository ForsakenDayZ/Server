
private ["_dis","_sfx","_object","_onLadder","_canDo"];
_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder);

if (false) then {
cutText [format["You are in combat and cannot build a bike."], "PLAIN DOWN"];
} else {
if (_canDo) then {
closeDialog 602;
player playActionNow "Medic";
r_interrupt = false;
player removeWeapon "ItemToolbox";

_dis=10;
_sfx = "repair";
[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
[player,_dis,true,(getPosATL player)] spawn player_alertZombies;

sleep 6;

_object = "Old_bike_TK_INS_EP1" createVehicle (position player);
_object setVariable ["ObjectID", "1", true];
_object setVariable ["ObjectUID", "1", true];

player reveal _object;

cutText [format["You've built a bike!"], "PLAIN DOWN"];

r_interrupt = false;
player switchMove "";
player playActionNow "stop";

sleep 10;

cutText [format["Warning: Spawned bikes DO NOT SAVE after server restart!"], "PLAIN DOWN"];
} else {
cutText [format["You are busy and cannot build a bike."], "PLAIN DOWN"];
}
};