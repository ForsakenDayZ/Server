//===================piXel 15-02-2013===========
waitUntil {!isNil ("PVDZE_plr_Login")};

//dog commands
sleep 1;
player setVariable ["dogAction","follow",true];
sleep 6;
//useless failsafe
_commd = player getVariable "dogAction";
if (_commd != "follow") then 
{
player setVariable ["dogAction","follow",true];
};
s_player_dogStay = player addAction ["Dog |<t color='#00a6eb'> Stay here</t>","custom\dog\dogCommand.sqf",["stay"],-10,false,true,"","((nearestObjects [player, ['Pastor','Fin'], 40]) select 0) isKindOf 'Pastor' || ((nearestObjects [player, ['Pastor','Fin'], 40]) select 0) isKindOf 'Fin' && player in dogOwner"];
s_player_dogFollow = player addAction ["Dog |<t color='#00a6eb'> Follow me</t>","custom\dog\dogCommand.sqf",["follow"],-11,false,true,"","((nearestObjects [player, ['Pastor','Fin'], 40]) select 0) isKindOf 'Pastor' || ((nearestObjects [player, ['Pastor','Fin'], 40]) select 0) isKindOf 'Fin' && player in dogOwner"];
s_player_dogFind = player addAction ["Dog |<t color='#00a6eb'> Find animal</t>","custom\dog\dogCommand.sqf",["find"],-12,false,true,"","((nearestObjects [player, ['Pastor','Fin'], 40]) select 0) isKindOf 'Pastor' || ((nearestObjects [player, ['Pastor','Fin'], 40]) select 0) isKindOf 'Fin' && player in dogOwner"];