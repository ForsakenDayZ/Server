if (false) then {
    cutText [format["You are in combat and cannot build a Laptop."], "PLAIN DOWN"];
} else {
	closeDialog 602;
    player playActionNow "Medic";
    r_interrupt = false;
	player removeWeapon "ItemGPS";
    _dis=10;
    _sfx = "repair";
    [player,_sfx,0,false,_dis] call dayz_zombieSpeak;
    [player,_dis,true,(getPosATL player)] spawn player_alertZombies;
 
    sleep 6;
 
    _object = "Notebook" createVehicle (position player);
    _object setVariable ["ObjectID", "1", true];
    _object setVariable ["ObjectUID", "1", true];
 
    player reveal _object;
 
    cutText [format["You've used your toolbox and GPS to build a Laptop!"], "PLAIN DOWN"];
 
    r_interrupt = false;
    player switchMove "";
    player playActionNow "stop";
 
    sleep 5;
 
    cutText [format[""], "PLAIN DOWN"];
 
};

