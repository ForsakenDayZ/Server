/*
Made by:
HALV
*/
private ["_timeLeft","_dropcountdown","_i","_dropCooldown","_droptimer","_Is_Admin","_EXECscrt","_Has_Kit","_Has_Tools","_thePath","_InCombMode","_kitItem","_timeout","_inCombat","_txt1"];
#include "Settings.sqf";
_EXECscrt = 'player execVM "'+_thePath+'%1"';
_dropcountdown = 50;
_droptimer = time - DROP_CooldownTimer;
_Has_Kit = _kitItem in magazines player;
_Has_Tools = "ItemToolbox" in items player;
_timeout = player getVariable["combattimeout", 0];
_inCombat = if (_timeout>=diag_tickTime)then{true}else{false};
if(_droptimer < _dropCooldown) exitWith {
	cutText [format["Airdrop planes are busy for another %1sec ...",(_droptimer - _dropCooldown)], "PLAIN DOWN"];
};
if ((_InCombMode==1) && (dayz_combat == 1)) exitWith {//Old Combat check
	titleText [format["You can't call airdrops while in combat ..."], "PLAIN DOWN"];
};
if ((_InCombMode==2) && _inCombat) exitWith {//new Combat check
	titleText [format["You can't call airdrops while in combat ..."], "PLAIN DOWN"];
};
if(_Has_Kit and _Has_Tools) then {
	player removeMagazine _kitItem;
	player playActionNow "Medic";
	[player,"repair",0,false,10] call dayz_zombieSpeak;
	sleep 1;
	_timeLeft = _dropcountdown;
	for "_i" from 0 to _dropcountdown do {
		sleep 1;
		_timeLeft = _timeLeft - 1;
		if(_disablePlayer)then{
			disableUserInput true;
		};
		if (_timeLeft > 0) then {
			cutText [format["**** Waiting for Laptop to boot up %1 seconds left ****",_timeLeft], "PLAIN DOWN"];
		} else {
			cutText [format["*** Airdrop Program Loaded and Ready! ***"], "PLAIN"];
		};
		if (_timeLeft == 45) then {
			[objNull, player, rSwitchMove,"AinvPknlMstpSnonWnonDnon_1"] call RE;
			cutText [format["** Checking RAM **"], "BLACK FADED"];
			playsound "beep";
			sleep 0.5;
			playsound "beep";
			sleep 4;
			cutText [format["*** Checking HDD ***"], "BLACK FADED"];
			playsound "beep";
			sleep 0.5;
			playsound "beep";
			sleep 4;
			cutText [format["**** Checking OS ****"], "BLACK FADED"];
			playsound "beep";
			sleep 0.5;
			playsound "beep";
		};
		if (_timeLeft == 30) then {
			[objNull, player, rSwitchMove,"AmovPercMstpSlowWrflDnon_seeWatch"] call RE;
			cutText [format["*** ERROR *** WINFAIL/OS FAILURE *** ERROR ***"], "BLACK FADED"];
			playsound "beep";
			sleep 0.25;
			playsound "beep";
			sleep 2;
			playsound "beep";
			sleep 0.25;
			playsound "beep";
			sleep 2;
			playsound "beep";
			sleep 0.25;
			playsound "beep";
			sleep 2;
			cutText [format["*** Rebooting system NOW ***"], "PLAIN DOWN"];
			playsound "beep";
			sleep 0.25;
			playsound "beep";
			sleep 2;
			playsound "beep";
			sleep 0.25;
			playsound "beep";
		};
		if (_timeLeft == 15) then {
			[objNull, player, rSwitchMove,"AmovPsitMstpSlowWrflDnon_WeaponCheck2"] call RE;
			cutText [format["** Checking RAM **"], "BLACK FADED"];
			playsound "beep";
			sleep 0.5;
			playsound "beep";
			sleep 3;
			cutText [format["*** Checking HDD ***"], "BLACK FADED"];
			playsound "beep";
			sleep 0.5;
			playsound "beep";
			sleep 2;
			cutText [format["**** Checking OS ****"], "BLACK FADED"];
			playsound "beep";
			sleep 0.5;
			playsound "beep";
		};
		if (_timeLeft == 5) then {
			[objNull, player, rSwitchMove,"AmovPercMstpSlowWrflDnon_seeWatch"] call RE;
			cutText [format["***** Loading WINFAIL/OS *****"], "BLACK FADED"];
			playsound "beep";
			sleep 0.5;
			playsound "beep";
			sleep 3;
			playsound "beep";
			sleep 0.5;
			playsound "beep";
		};
	};
	if (_timeLeft == 0 || _timeLeft < 0) then { // If drop countdown is done then.....
		if(_disablePlayer)then{
			disableUserInput false;
		};
		playsound "beep";
		sleep 0.4;
		playsound "beep";
		sleep 1.2;
		playsound "beep";
		sleep 0.4;
		playsound "beep";
		[objNull, player, rSwitchMove,"AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon"] call RE;
		cutText [format["<<<------ \n****** Choose airdrop type: ******"], "PLAIN DOWN"];
		if ((getPlayerUID player) in _Is_Admin) then { 
			Airdrop =
			[
				["",true],
				["WINFAIL/OS Menu", [-1], "", -5, [["expression", ""]], "1", "0"],
				["       Choose Airdrop:", [-1], "", -5, [["expression", ""]], "1", "0"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Airdrop Admin SupplyDrop ***", [2],  "", -5, [["expression", format[_EXECscrt,"my_caredrop3.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Airdrop HALV SupplyDrop ***", [3],  "", -5, [["expression", format[_EXECscrt,"my_caredrop2.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Airdrop Random WeaponsBox ***", [4],  "", -5, [["expression", format[_EXECscrt,"my_caredrop.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Airdrop Random Vehicle ***", [5],  "", -5, [["expression", format[_EXECscrt,"my_cardrop.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Call Artillery Strike ***", [6],  "", -5, [["expression", format[_EXECscrt,"Arti.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Surveillance Program ***", [7],  "", -5, [["expression", format[_EXECscrt,"AlPmaker_survcam.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Abort Program ***", [13], "", -3, [["expression", ""]], "1", "1"]
			];
			showCommandingMenu "#USER:Airdrop";
			DROP_CooldownTimer = time;
		} else {
			Airdrop =
			[
				["",true],
				["WINFAIL/OS Menu", [-1], "", -5, [["expression", ""]], "1", "0"],
				["       Choose Airdrop:", [-1], "", -5, [["expression", ""]], "1", "0"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Airdrop HALV SupplyDrop ***", [2],  "", -5, [["expression", format[_EXECscrt,"my_caredrop2.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Airdrop Random WeaponsBox ***", [3],  "", -5, [["expression", format[_EXECscrt,"my_caredrop.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Airdrop Random Vehicle ***", [4],  "", -5, [["expression", format[_EXECscrt,"my_cardrop.sqf"]]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Surveillance Program ***", [6],  "", -5, [["expression", format[_EXECscrt,"AlPmaker_survcam.sqf"]]], "1", "1"],
/*
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Artillery Strike ***", [5],  "", -5, [["expression", format[_EXECscrt,"Arti.sqf"]]], "1", "1"],
*/
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
				["*** Abort Program ***", [13], "", -3, [["expression", ""]], "1", "1"]
			];
			showCommandingMenu "#USER:Airdrop";
			DROP_CooldownTimer = time;
		};
	};
} else {
	_txt1 = (gettext (configFile >> 'cfgmagazines' >> _kitItem >> 'displayName'));
	cutText [format["You need a Toolbox and %1 to fix the Laptop for Airdrops!",_txt1], "PLAIN DOWN"];
};
