private ["_cTarget","_isOk","_Dis","_display","_inVehicle"];
disableSerialization;
_display = (_this select 0);
_inVehicle = (vehicle player) != player;
_cTarget = cursorTarget;
if(_inVehicle) then {
	_cTarget = (vehicle player);
};

_isOk = false;
{
	if(!_isOk) then {
		_isOk = _cTarget isKindOf _x;
	};
} count ["LandVehicle","Air", "Ship"];
_Dis = if (_cTarget isKindOf "USEC_ch53_E") then {25;} else {12;};
if((locked _cTarget) and _isOk and !_inVehicle and(((vehicle player) distance _cTarget) < 12)) then {	cutText [(localize "str_epoch_player_7") , "PLAIN DOWN"];
	_display closeDisplay 1;
};
