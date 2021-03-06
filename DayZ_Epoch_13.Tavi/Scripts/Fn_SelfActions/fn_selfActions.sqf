
private ["_isWreckBuilding","_temp_keys","_magazinesPlayer","_isPZombie","_vehicle","_inVehicle","_hasFuelE","_hasRawMeat","_hasKnife","_hasToolbox","_onLadder","_nearLight","_canPickLight","_canDo","_text","_isHarvested","_isVehicle","_isVehicletype","_isMan","_traderType","_ownerID","_isAnimal","_isDog","_isZombie","_isDestructable","_isTent","_isFuel","_isAlive","_Unlock","_lock","_buy","_dogHandle","_lieDown","_warn","_hastinitem","_allowedDistance","_menu","_menu1","_humanity_logic","_low_high","_cancel","_traderMenu","_isWreck","_isRemovable","_isDisallowRepair","_rawmeat","_humanity","_speed","_dog","_hasbottleitem","_isAir","_isShip","_playersNear","_findNearestGens","_findNearestGen","_IsNearRunningGen","_cursorTarget","_isnewstorage","_itemsPlayer","_ownerKeyId","_typeOfCursorTarget","_hasKey","_oldOwner","_combi","_key_colors","_player_deleteBuild","_player_flipveh","_player_lockUnlock_crtl","_player_butcher","_player_studybody","_player_cook","_player_boil","_hasFuelBarrelE","_hasHotwireKit","_player_SurrenderedGear","_isSurrendered","_isModular","_isModularDoor","_ownerKeyName","_temp_keys_names","_hasAttached","_allowTow","_liftHeli","_found","_posL","_posC","_height","_liftHelis","_attached","_lightweight","_mediumweight","_heavyweight","_superheavyweight","_matched","_playerPUID","_buildOwner","_nearestBuildList","_originHousing","_nearestBuilding","_isAirdrop","_weapons","_isNotebook"];
scriptName "Functions\misc\fn_selfActions.sqf";
/***********************************************************
	ADD ACTIONS FOR SELF
	- Function
	- [] call fnc_usec_selfActions;
************************************************************/

if (DZE_ActionInProgress) exitWith {}; // Do not allow if any script is running.

_vehicle = vehicle player;
_isPZombie = player isKindOf "PZombie_VB";
_inVehicle = (_vehicle != player);

_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_canDo = (!r_drag_sqf && !r_player_unconscious && !_onLadder);

_nearLight = 	nearestObject [player,"LitObject"];
_canPickLight = false;
if (!isNull _nearLight) then {
	if (_nearLight distance player < 4) then {
		_canPickLight = isNull (_nearLight getVariable ["owner",objNull]);
	};
};
/*===================================Airdrops=====================================================//
_isAirdrop = cursorTarget isKindOf "Notebook";
if ((speed player <= 1) && _isAirdrop && _canDo && (player distance cursorTarget < 4)) then {
	if (s_player_Airdrop < 0) then {
		s_player_Airdrop = player addAction [("<t color=""#0096ff"">" + ("Fix Notebook (Airdrop)") +"</t>"),"Scripts\airdrop\Airdropp.sqf",cursorTarget, 0, false, true, "",""];
	};
} else {
	player removeAction s_player_Airdrop;
	s_player_Airdrop = -1;
};
//==================================END=========================================================/*/
//Grab Flare
if (_canPickLight && !dayz_hasLight && !_isPZombie) then {
	if (s_player_grabflare < 0) then {
		_text = getText (configFile >> "CfgAmmo" >> (typeOf _nearLight) >> "displayName");
		s_player_grabflare = player addAction [format[localize "str_actions_medical_15",_text], "\z\addons\dayz_code\actions\flare_pickup.sqf",_nearLight, 1, false, true, "", ""];
		s_player_removeflare = player addAction [format[localize "str_actions_medical_17",_text], "\z\addons\dayz_code\actions\flare_remove.sqf",_nearLight, 1, false, true, "", ""];
	};
} else {
	player removeAction s_player_grabflare;
	player removeAction s_player_removeflare;
	s_player_grabflare = -1;
	s_player_removeflare = -1;
};
if (_inVehicle && (_vehicle isKindOf "MV22")) then {
   if (isEngineOn _vehicle) then {[_vehicle,0] call mv22_pack;};
   if (mv22_fold < 0) then {
     themv22 = _vehicle;
     if !(isEngineOn themv22) then {
       mv22_fold = themv22 addAction ["Fold","custom\animate\mv22_fold.sqf","",5,false,true];
       mv22_unfold = themv22 addAction ["UnFold","custom\animate\mv22_unfold.sqf","",5,false,true];
       mv22_open = themv22 addAction ["Open Ramp","custom\animate\mv22_open.sqf","",5,false,true];
       mv22_close = themv22 addAction ["Close Ramp","custom\animate\mv22_close.sqf","",5,false,true];
     };
   };
   if (isEngineOn themv22) then {
     themv22 removeAction mv22_fold;
     mv22_fold = -1;
     themv22 removeAction mv22_unfold;
     mv22_unfold = -1;
     themv22 removeAction mv22_open;
     mv22_open = -1;
     themv22 removeAction mv22_close;
     mv22_close = -1;
   };
} else {
    if (!isNil "themv22") then {
       themv22 removeAction mv22_fold;
       mv22_fold = -1;
       themv22 removeAction mv22_unfold;
       mv22_unfold = -1;
       themv22 removeAction mv22_open;
       mv22_open = -1;
       themv22 removeAction mv22_close;
       mv22_close = -1;
   };
};

if (_inVehicle && (_vehicle isKindOf "ArmoredSUV_Base_PMC")) then {
   if ((_vehicle animationPhase "HideGun_01") == 1) then {
     _unit = _vehicle turretUnit [0];
     if (!(isNull _unit)) then {
       _unit action ["moveToCargo",_vehicle,2];
       titleText ["\n\nYou must open the hatch first.","PLAIN DOWN"];titleFadeOut 4;
     };
   };
   if (suv_close < 0) then {
     thesuv = _vehicle;
     suv_close = thesuv addAction ["Close Hatch","custom\animate\suv_close.sqf","",5,false,true];
     suv_open = thesuv addAction ["Open Hatch","custom\animate\suv_open.sqf","",5,false,true];
   };
} else {
    if (!isNil "thesuv") then {
        thesuv removeAction suv_close;
        suv_close = -1;
        thesuv removeAction suv_open;
        suv_open = -1;
    };
};
if (DZE_HeliLift) then {
	_hasAttached = _vehicle getVariable["hasAttached",false];
	if(_inVehicle && (_vehicle isKindOf "Air") && ((([_vehicle] call FNC_getPos) select 2) < 30) && (speed _vehicle < 5) && (typeName _hasAttached == "OBJECT")) then {
		if (s_player_heli_detach < 0) then {
			dayz_myLiftVehicle = _vehicle;
			s_player_heli_detach = dayz_myLiftVehicle addAction ["Detach Vehicle","\z\addons\dayz_code\actions\player_heliDetach.sqf",[dayz_myLiftVehicle,_hasAttached],2,false,true,"",""];
		};
	} else {
		dayz_myLiftVehicle removeAction s_player_heli_detach;
		s_player_heli_detach = -1;
	};
};

if(DZE_HaloJump) then {
	if(_inVehicle && (_vehicle isKindOf "Air") && ((([_vehicle] call FNC_getPos) select 2) > 400)) then {
		if (s_halo_action < 0) then {
			DZE_myHaloVehicle = _vehicle;
			s_halo_action = DZE_myHaloVehicle addAction [localize "STR_EPOCH_ACTIONS_HALO","\z\addons\dayz_code\actions\halo_jump.sqf",[],2,false,true,"",""];
		};
	} else {
		DZE_myHaloVehicle removeAction s_halo_action;
		s_halo_action = -1;
	};
};

if (!DZE_ForceNameTagsOff) then {
	if (s_player_showname < 0 && !_isPZombie) then {
		if (DZE_ForceNameTags) then {
			s_player_showname = 1;
			player setVariable["DZE_display_name",true,true];
		} else {
			s_player_showname = player addAction [localize "STR_EPOCH_ACTIONS_NAMEYES", "\z\addons\dayz_code\actions\display_name.sqf",true, 0, true, false, "",""];
			s_player_showname1 = player addAction [localize "STR_EPOCH_ACTIONS_NAMENO", "\z\addons\dayz_code\actions\display_name.sqf",false, 0, true, false, "",""];
		};
	};
};

if(DZE_Origins_Building_System) then {
	if(isnil "s_player_build_origins_house") then {s_player_build_origins_house = -1;};
	if(isnil "s_player_build_origins_garage") then {s_player_build_origins_garage = -1;};
	if(isnil "s_player_build_origins_stronghold") then {s_player_build_origins_stronghold = -1;};
	if(isnil "s_player_origins_unlock") then {s_player_origins_unlock = -1;};
	if(isnil "s_player_origins_stronghold_doors") then {s_player_origins_stronghold_doors = -1;};
	_cursorTarget = cursorTarget;
	if (!isNull _cursorTarget) then {
		_typeOfCursorTarget = (typeOf _cursorTarget);
		if(_typeOfCursorTarget == DZE_Origins_Container ) then {
			if((player distance _cursorTarget) < DZE_Origins_Build_Distance) then {
				private["_humanity","_playerUID","_hasLevel1","_hasLevel2","_hasLevel3","_hasSG","_hasLG","_hasKING","_hasSH","_canBuildHouse","_houselevel","_humanityNeed","_actionText","_classname","_neededMaterials","_canBuildSH","_canBuildGarage"];
				_humanity = player getVariable["humanity",0];
				_playerUID = dayz_playerUID;
				_hasLevel1 = (_playerUID in owner_H1 || _playerUID in owner_B1);
				_hasLevel2 = (_playerUID in owner_H2 || _playerUID in owner_B2);
				_hasLevel3 = (_playerUID in owner_H3 || _playerUID in owner_B3);
				_hasSG = (_playerUID in owner_SG);
				_hasLG = (_playerUID in owner_LG);
				_hasKING = (_playerUID in owner_KING);
				_hasSH = (_playerUID in owner_SH);
				
				{
					_houselevel = _x select 0;
					_humanityNeed = _x select 1;
					_actionText = _x select 2;
					_classname = _x select 3;
					_neededMaterials = _x select 4;
					_canBuildHouse = false;
					_canBuildGarage = false;
					_canBuildSH = false;
					
					if((_humanityNeed > 0 && _humanity >= _humanityNeed) || (_humanityNeed < 0 && _humanity <= _humanityNeed)) then {
						if(_houselevel in ["H1","B1"] && !_hasLevel1) then {
							_canBuildHouse = true;
						};
						if(_houselevel in ["H2","B2"] && !_hasLevel2) then {
							_canBuildHouse = true;
						};
						if(_houselevel in ["H3","B3"] && !_hasLevel3) then {
							_canBuildHouse = true;
						};
						if(_houselevel in ["SGH","SGB"] && _hasLevel1 && !_hasSG) then {
							_canBuildGarage = true;
						};
						if(_houselevel in ["LGH","LGB"] && _hasLevel3 && !_hasLG) then {
							_canBuildGarage = true;
						};
						if(_houselevel in ["KINGH","KINGB"] && _hasLevel3 && _hasLG && !_hasKING) then {
							_canBuildGarage = true;
						};	
						if(_houselevel in ["SHH","SHB"] && _hasLevel1 && _hasLevel2 && _hasLevel3 && !_hasSH) then {
							_canBuildSH = true;
						};
					};
					
					if(_canBuildHouse) then {
						if(s_player_build_origins_house < 0) then {
							s_player_build_origins_house = player addAction ["Build " + _actionText, "origins\player_build.sqf", [_cursorTarget, _houselevel, _classname, _neededMaterials, _actionText]];
						};
					};
					if(_canBuildGarage) then {
						if(s_player_build_origins_garage < 0) then {
							s_player_build_origins_garage = player addAction ["Build " + _actionText, "origins\player_build.sqf", [_cursorTarget, _houselevel, _classname, _neededMaterials, _actionText]];
						};
					};
					if(_canBuildSH) then {
						if(s_player_build_origins_stronghold < 0) then {
							s_player_build_origins_stronghold = player addAction ["Build " + _actionText, "origins\player_build.sqf", [_cursorTarget, _houselevel, _classname, _neededMaterials, _actionText]];
						};
					};
					
				} forEach DZE_Origins_Build_HousesGarages;
			} else {
				[1] call origins_removeActions;
			};
		};
		
		if(_typeOfCursorTarget in DZE_Origins_Buildings && (player distance _cursorTarget) < DZE_Origins_LockUnlock_Distance) then {
			private["_ownerUID","_ownerName","_playerUID","_state","_openClose"];
			_playerUID = dayz_playerUID;
			_ownerUID = _cursorTarget getVariable ["OwnerUID","0"];
			_ownerName = _cursorTarget getVariable ["OwnerName","0"];
			
			if(_playerUID != _ownerUID && !(_typeOfCursorTarget in DZE_Origins_Stronghold)) exitWith {
				cutText [format["This house was built by %1", _ownerName], "PLAIN DOWN",5];
				sleep 5;
			};
			_state = (_cursorTarget getVariable ["CanBeUpdated",false]);
			if(_typeOfCursorTarget in DZE_Origins_Stronghold && _state) then {
				private["_strongholdDoorsOpen"];
				_strongholdDoorsOpen = (_cursorTarget getVariable ["DoorsOpen",false]);
				if(_strongholdDoorsOpen) then {
					if(s_player_origins_stronghold_doors < 0) then {
						s_player_origins_stronghold_doors = player addAction [ "Close Doors","origins\origins_strongholdDoors.sqf",[_cursorTarget,0]];
					};
				} else {
					if(s_player_origins_stronghold_doors < 0)then {
						s_player_origins_stronghold_doors = player addAction [ "Open Doors","origins\origins_strongholdDoors.sqf",[_cursorTarget,1]];
					};
				};
			} else {
				[3] call origins_removeActions;
			};
			
			if(s_player_origins_unlock < 0) then {
				_matched = false;
				{
					if(_typeOfCursorTarget == (_x select 0)) then {
						if(_state) then {
							_openClose = format["Lock %1", _X select 1];
						} else {
							_openClose = format["Unlock %1", _X select 1];
						};
						_matched = true;
					};
					if (_matched) exitWith {
						s_player_origins_unlock = player addAction [_openClose, "origins\player_lockUnlock.sqf", [_cursorTarget,_typeOfCursorTarget,_state]];
					};
				} count DZE_Origins_NameLookup;
			};
		} else {
			[2] call origins_removeActions;
		};
	} else {
		[0] call origins_removeActions;
	};
};
/*
//Submarine Submerging
if (_inVehicle and (_vehicle isKindOf "ori_submarine")) then {
   _thesub = _vehicle;
   if (sub_up < 0) then {
	 sub_down = _thesub addAction ["Rise","Scripts\Sub\sub_down.sqf","",5,false,true];
     sub_up = _thesub addAction ["Submerge","Scripts\Sub\sub_up.sqf","",5,false,true];
   };
} else {
   _thesub removeAction sub_up;
   sub_up = -1;
   _thesub removeAction sub_down;
   sub_down = -1;
};
//allow demolition of Origins Housing
     if (typeOf(vehicle player)=="ori_excavator") then
     {
         if (bucketOut < 0) then {
             ExcavateVeh = _vehicle;
             bucketOut = ExcavateVeh addAction ["Bucket Out","Scripts\Excavator\bucketOut.sqf","",5,false,true];
         };
         if(bucketIn < 0) then {
             ExcavateVeh = _vehicle;
             bucketIn = ExcavateVeh addAction ["Bucket In","Scripts\Excavator\bucketIn.sqf","",5,false,true];
         };
         _nearestBuildList = nearestObjects [_vehicle, _originHousing, 20];
         _nearestBuilding = _nearestBuildList select 0;
         if(!isNil "_nearestBuilding") then
         {
             _buildOwner = _nearestBuilding getVariable['OwnerPUID','0'];
             if(s_demolish == -1) then {
                 if (_buildOwner == _playerPUID) then {    
                     ExcavateVeh = vehicle player;            
                     s_demolish = ExcavateVeh addaction [("<t color=""#ff0000"">" + format["Demolish %1",typeOf(_nearestBuilding)] +"</t>"),"Scripts\Excavator\demolish.sqf",_nearestBuilding,6,false,true,"",""];
                     sleep 5;
                 };
             } else {
                 ExcavateVeh removeAction s_demolish;
                 s_demolish = -1;
             };
         } else {
             if(!isNil "ExcavateVeh") then {
                 ExcavateVeh removeAction s_demolish;
                 s_demolish = -1;
             };
         };        
     } else {
         ExcavateVeh removeAction bucketIn;
         bucketIn = -1;
         ExcavateVeh removeAction bucketOut;
         bucketOut = -1;
         ExcavateVeh removeAction s_demolish;
         s_demolish = -1;
};
*/	 
if(_isPZombie) then {
	if (s_player_callzombies < 0) then {
		s_player_callzombies = player addAction [localize "STR_EPOCH_ACTIONS_RAISEHORDE", "\z\addons\dayz_code\actions\call_zombies.sqf",player, 5, true, false, "",""];
	};
	if (DZE_PZATTACK) then {
		call pz_attack;
		DZE_PZATTACK = false;
	};
	if (s_player_pzombiesvision < 0) then {
		s_player_pzombiesvision = player addAction [localize "STR_EPOCH_ACTIONS_NIGHTVIS", "\z\addons\dayz_code\actions\pzombie\pz_vision.sqf", [], 4, false, true, "nightVision", "_this == _target"];
	};
	if (!isNull cursorTarget && (player distance cursorTarget < 3)) then {	//Has some kind of target
		_isAnimal = cursorTarget isKindOf "Animal";
		_isZombie = cursorTarget isKindOf "zZombie_base";
		_isHarvested = cursorTarget getVariable["meatHarvested",false];
		_isMan = cursorTarget isKindOf "Man";
		// Pzombie Gut human corpse || animal
		if (!alive cursorTarget && (_isAnimal || _isMan) && !_isZombie && !_isHarvested) then {
			if (s_player_pzombiesfeed < 0) then {
				s_player_pzombiesfeed = player addAction [localize "STR_EPOCH_ACTIONS_FEED", "\z\addons\dayz_code\actions\pzombie\pz_feed.sqf",cursorTarget, 3, true, false, "",""];
			};
		} else {
			player removeAction s_player_pzombiesfeed;
			s_player_pzombiesfeed = -1;
		};
	} else {
		player removeAction s_player_pzombiesfeed;
		s_player_pzombiesfeed = -1;
	};
};

// Increase distance only if AIR || SHIP
_allowedDistance = 4;
_isAir = cursorTarget isKindOf "Air";
_isShip = cursorTarget isKindOf "Ship";
if(_isAir || _isShip) then {
	_allowedDistance = 8;
};

if (!isNull cursorTarget && !_inVehicle && !_isPZombie && (player distance cursorTarget < _allowedDistance) && _canDo) then {	//Has some kind of target

	// set cursortarget to variable
	_cursorTarget = cursorTarget;

	// get typeof cursortarget once
	_typeOfCursorTarget = typeOf _cursorTarget;

	// hintsilent _typeOfCursorTarget;

	_isVehicle = _cursorTarget isKindOf "AllVehicles";
	_isVehicletype = _typeOfCursorTarget in ["ATV_US_EP1","ATV_CZ_EP1"];
	_isnewstorage = _typeOfCursorTarget in DZE_isNewStorage;
	
	// get items && magazines only once
	_magazinesPlayer = magazines player;

	//boiled Water
	_hasbottleitem = "ItemWaterbottle" in _magazinesPlayer;
	_hastinitem = false;
	{
		if (_x in _magazinesPlayer) then {
			_hastinitem = true;
		};
	} count boil_tin_cans;
	_hasFuelE = 	"ItemJerrycanEmpty" in _magazinesPlayer;
	_hasFuelBarrelE = 	"ItemFuelBarrelEmpty" in _magazinesPlayer;
	_hasHotwireKit = 	"ItemHotwireKit" in _magazinesPlayer;

	_itemsPlayer = items player;
	
	_temp_keys = [];
	_temp_keys_names = [];
	// find available keys
	_key_colors = ["ItemKeyYellow","ItemKeyBlue","ItemKeyRed","ItemKeyGreen","ItemKeyBlack"];
	{
		if (configName(inheritsFrom(configFile >> "CfgWeapons" >> _x)) in _key_colors) then {
			_ownerKeyId = getNumber(configFile >> "CfgWeapons" >> _x >> "keyid");
			_ownerKeyName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
			_temp_keys_names set [_ownerKeyId,_ownerKeyName];
			_temp_keys set [count _temp_keys,str(_ownerKeyId)];
		};
	} count _itemsPlayer;

	_hasKnife = 	"ItemKnife" in _itemsPlayer;
	_hasToolbox = 	"ItemToolbox" in _itemsPlayer;

	_isMan = _cursorTarget isKindOf "Man";
	_traderType = _typeOfCursorTarget;
	_ownerID = _cursorTarget getVariable ["CharacterID","0"];
	_isAnimal = _cursorTarget isKindOf "Animal";
	_isDog =  (_cursorTarget isKindOf "DZ_Pastor" || _cursorTarget isKindOf "DZ_Fin");
	_isZombie = _cursorTarget isKindOf "zZombie_base";
	_isDestructable = _cursorTarget isKindOf "BuiltItems";
	_isWreck = _typeOfCursorTarget in DZE_isWreck;
	_isWreckBuilding = _typeOfCursorTarget in DZE_isWreckBuilding;
	_isModular = (_cursorTarget isKindOf "ModularItems") or ((typeOf _cursorTarget) in WG_OwnerRemove);
	_isModularDoor = _typeOfCursorTarget in ["Land_DZE_WoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_GarageWoodDoor","CinderWallDoor_DZ","CinderWallDoorSmall_DZ"];

	_isRemovable = _typeOfCursorTarget in DZE_isRemovable;
	_isDisallowRepair = _typeOfCursorTarget in ["M240Nest_DZ"];

	_isTent = _cursorTarget isKindOf "TentStorage";
	
	_isAlive = alive _cursorTarget;
	
	_text = getText (configFile >> "CfgVehicles" >> _typeOfCursorTarget >> "displayName");
	
	_rawmeat = meatraw;
	_hasRawMeat = false;
	{
		if (_x in _magazinesPlayer) then {
			_hasRawMeat = true;
		};
	} count _rawmeat; 
	
	_isFuel = false;
	if (_hasFuelE || _hasFuelBarrelE) then {
		{
			if(_cursorTarget isKindOf _x) exitWith {_isFuel = true;};
		} count dayz_fuelsources;
	};

	// diag_log ("OWNERID = " + _ownerID + " CHARID = " + dayz_characterID + " " + str(_ownerID == dayz_characterID));
	
	// logic vars
	_player_flipveh = false;
	_player_deleteBuild = false;
	_player_lockUnlock_crtl = false;

	 if (_canDo && (speed player <= 1) && (_cursorTarget isKindOf "Plastic_Pole_EP1_DZ")) then {
		 if (s_player_maintain_area < 0) then {
		  	s_player_maintain_area = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTAREA"], "\z\addons\dayz_code\actions\maintain_area.sqf", "maintain", 5, false];
		 	s_player_maintain_area_preview = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTPREV"], "\z\addons\dayz_code\actions\maintain_area.sqf", "preview", 5, false];
		 };
	 } else {
    		player removeAction s_player_maintain_area;
    		s_player_maintain_area = -1;
    		player removeAction s_player_maintain_area_preview;
    		s_player_maintain_area_preview = -1;
	 };

	// CURSOR TARGET ALIVE
	if(_isAlive) then {
		
		//Allow player to delete objects
		if(_isDestructable || _isWreck || _isRemovable || _isWreckBuilding) then {
			if(_hasToolbox && "ItemCrowbar" in _itemsPlayer) then {
				_player_deleteBuild = true;
			};
		};
		
		//Allow owners to delete modulars
                if(_isModular && (dayz_characterID == _ownerID)) then {
                        if(_hasToolbox && "ItemCrowbar" in _itemsPlayer) then {
                                _player_deleteBuild = true;
                        };
                };
		//Allow owners to delete modular doors without locks
				if(_isModularDoor && (dayz_characterID == _ownerID)) then {
                        if(_hasToolbox && "ItemCrowbar" in _itemsPlayer) then {
                                _player_deleteBuild = true;
                        };		
				};	
		// CURSOR TARGET VEHICLE
		if(_isVehicle) then {
			
			//flip vehicle small vehicles by your self && all other vehicles with help nearby
			if (!(canmove _cursorTarget) && (player distance _cursorTarget >= 2) && (count (crew _cursorTarget))== 0 && ((vectorUp _cursorTarget) select 2) < 0.5) then {
				_playersNear = {isPlayer _x} count (player nearEntities ["CAManBase", 6]);
				if(_isVehicletype || (_playersNear >= 2)) then {
					_player_flipveh = true;	
				};
			};


			if(!_isMan && _ownerID != "0" && !(_cursorTarget isKindOf "Bicycle")) then {
				_player_lockUnlock_crtl = true;
			};

		};
	
	};

	if(_player_deleteBuild) then {
		if (s_player_deleteBuild < 0) then {
			s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "\z\addons\dayz_code\actions\remove.sqf",_cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_deleteBuild;
		s_player_deleteBuild = -1;
	};
	
    //----DZE_HeliLift START-----
    if (DZE_HeliLift) then {
        _liftHeli = objNull;
        _found = false;
        _allowTow = false;
        _lightweight = false;
        _mediumweight = false;
        _heavyweight = false;
        _superheavyweight = false;
        if ((count (crew _cursorTarget)) == 0) then {
            { if(!_allowTow) then { _allowTow = _cursorTarget isKindOf _x; }; } forEach DZE_HeliAllowToTowLight;
            if(_allowTow) then { _lightweight = true; } else { _lightweight = false; };
        };
        if ((count (crew _cursorTarget)) == 0) then {
            { if(!_allowTow) then { _allowTow = _cursorTarget isKindOf _x; }; } forEach DZE_HeliAllowToTowMedium;
            if(_allowTow and !_lightweight) then { _mediumweight = true; } else { _mediumweight = false; };
        };
        if ((count (crew _cursorTarget)) == 0) then {
            { if(!_allowTow) then { _allowTow = _cursorTarget isKindOf _x; }; } forEach DZE_HeliAllowToTowHeavy;
            if(_allowTow and !_lightweight and !_mediumweight) then { _heavyweight = true; } else { _heavyweight = false; };
        };
        if ((count (crew _cursorTarget)) == 0) then {
            { if(!_allowTow) then { _allowTow = _cursorTarget isKindOf _x; }; } forEach DZE_HeliAllowToTowSuperHeavy;
            if(_allowTow && !_lightweight && !_mediumweight && !_heavyweight) then { _superheavyweight = true; } else { _superheavyweight = false; };
        };
        //diag_log format["CREW: %1 ALLOW: %2",(count (crew _cursorTarget)),_allowTow];
        if (_allowTow && _lightweight && !_found) then {
            _liftHelis = nearestObjects [player, DZE_HeliAllowTowFromLight, 15];
            {
                if(!_found) then {
                    _posL = getPos _x;
                    _posC = getPos _cursorTarget;
                    _height = (_posL select 2) - (_posC select 2);
                    _hasAttached = _x getVariable["hasAttached",false];
                    if(_height < 15 && _height > 5 && (typeName _hasAttached != "OBJECT")) then {
                        if(((abs((_posL select 0) - (_posC select 0))) < 10) && ((abs((_posL select 1) - (_posC select 1))) < 10)) then {
                            _liftHeli = _x;
                            _found = true;
                        };
                    };
                };
            } forEach _liftHelis;
        };
        if ( _allowTow && !_found && ( _mediumweight || _lightweight ) ) then {
            _liftHelis = nearestObjects [player, DZE_HeliAllowTowFromMedium, 15];
            {
                if(!_found) then {
                    _posL = getPos _x;
                    _posC = getPos _cursorTarget;
                    _height = (_posL select 2) - (_posC select 2);
                    _hasAttached = _x getVariable["hasAttached",false];
                    if(_height < 15 && _height > 5 && (typeName _hasAttached != "OBJECT")) then {
                        if(((abs((_posL select 0) - (_posC select 0))) < 10) && ((abs((_posL select 1) - (_posC select 1))) < 10)) then {
                            _liftHeli = _x;
                            _found = true;
                        };
                    };
                };
            } forEach _liftHelis;
        };
        if ( _allowTow && !_found && ( _heavyweight || _mediumweight || _lightweight ) ) then {
            _liftHelis = nearestObjects [player, DZE_HeliAllowTowFromHeavy, 15];
            {
                if(!_found) then {
                    _posL = getPos _x;
                    _posC = getPos _cursorTarget;
                    _height = (_posL select 2) - (_posC select 2);
                    _hasAttached = _x getVariable["hasAttached",false];
                    if(_height < 15 && _height > 5 && (typeName _hasAttached != "OBJECT")) then {
                        if(((abs((_posL select 0) - (_posC select 0))) < 10) && ((abs((_posL select 1) - (_posC select 1))) < 10)) then {
                            _liftHeli = _x;
                            _found = true;
                        };
                    };
                };
            } forEach _liftHelis;
        };
        if ( _allowTow && !_found && ( _superheavyweight || _heavyweight || _mediumweight || _lightweight ) ) then {
            _liftHelis = nearestObjects [player, DZE_HeliAllowTowFromSuperHeavy, 15];
            {
                if(!_found) then {
                    _posL = getPos _x;
                    _posC = getPos _cursorTarget;
                    _height = (_posL select 2) - (_posC select 2);
                    _hasAttached = _x getVariable["hasAttached",false];
                    if(_height < 15 && _height > 5 && (typeName _hasAttached != "OBJECT")) then {
                        if(((abs((_posL select 0) - (_posC select 0))) < 10) && ((abs((_posL select 1) - (_posC select 1))) < 10)) then {
                            _liftHeli = _x;
                            _found = true;
                        };
                    };
                };
            } forEach _liftHelis;
        };
        //diag_log format["HELI: %1 TARGET: %2",_found,_cursorTarget];
        _attached = _cursorTarget getVariable["attached",false];
        if(_found && _allowTow && _canDo && !locked _cursorTarget && !_isPZombie && (typeName _attached != "OBJECT")) then {
            if ((_cursortarget getVariable ["MFTowInTow", false]) || (_cursortarget getVariable ["MFTowIsTowing", false])) then {
                cutText ["You cannot lift this vehicle because it is towing or being towed.", "PLAIN DOWN"];
            } else {
                if (s_player_heli_lift < 0) then {
                    s_player_heli_lift = player addAction [("<t color=""#ffab00"">" + ("Attach to Heli") + "</t>"), "\z\addons\dayz_code\actions\player_heliLift.sqf",[_liftHeli,_cursorTarget], -10, false, true, "",""];
                };
            };
        } else {
            player removeAction s_player_heli_lift;
            s_player_heli_lift = -1;
        };
    };
    //----DZE_HeliLift END-----
	
	/*
	if (DZE_HeliLift) then {
		_liftHeli = objNull;
		_found = false;
	
		_allowTow = false;
		if ((count (crew _cursorTarget)) == 0) then {
			{
				if(!_allowTow) then {
					_allowTow = _cursorTarget isKindOf _x;
				};
			} count DZE_HeliAllowToTow;
		};

		//diag_log format["CREW: %1 ALLOW: %2",(count (crew _cursorTarget)),_allowTow];

		if (_allowTow) then {
			_liftHelis = nearestObjects [player, DZE_HeliAllowTowFrom, 15];
			{
				if(!_found) then {
					_posL = [_x] call FNC_getPos;
					_posC = [_cursorTarget] call FNC_getPos;
					_height = (_posL select 2) - (_posC select 2);
					_hasAttached = _x getVariable["hasAttached",false];
					if(_height < 15 && _height > 5 && (typeName _hasAttached != "OBJECT")) then {
						if(((abs((_posL select 0) - (_posC select 0))) < 10) && ((abs((_posL select 1) - (_posC select 1))) < 10)) then {
							_liftHeli = _x;
							_found = true;
						};
					};
				};
			} count _liftHelis;
		};
		//diag_log format["HELI: %1 TARGET: %2",_found,_cursorTarget];

		_attached = _cursorTarget getVariable["attached",false];
		if(_found && _allowTow && _canDo && !locked _cursorTarget && !_isPZombie && (typeName _attached != "OBJECT")) then {
			if (s_player_heli_lift < 0) then {
				s_player_heli_lift = player addAction ["Attach to Heli", "\z\addons\dayz_code\actions\player_heliLift.sqf",[_liftHeli,_cursorTarget], -10, false, true, "",""];
			};
		} else {
			player removeAction s_player_heli_lift;
			s_player_heli_lift = -1;
		};
	};
	*/
	// Allow Owner to lock && unlock vehicle  
	if(_player_lockUnlock_crtl) then {
		if (s_player_lockUnlock_crtl < 0) then {
			_hasKey = _ownerID in _temp_keys;
			_oldOwner = (_ownerID == dayz_playerUID);
			if(locked _cursorTarget) then {
				if(_hasKey || _oldOwner) then {
					_Unlock = player addAction [format[localize "STR_EPOCH_ACTIONS_UNLOCK",_text], "\z\addons\dayz_code\actions\unlock_veh.sqf",[_cursorTarget,(_temp_keys_names select (parseNumber _ownerID))], 2, true, true, "", ""];
					s_player_lockunlock set [count s_player_lockunlock,_Unlock];
					s_player_lockUnlock_crtl = 1;
				} else {
					if(_hasHotwireKit) then {
						_Unlock = player addAction [format[localize "STR_EPOCH_ACTIONS_HOTWIRE",_text], "\z\addons\dayz_code\actions\hotwire_veh.sqf",_cursorTarget, 2, true, true, "", ""];
					} else {
						_Unlock = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_VEHLOCKED"], "",_cursorTarget, 2, true, true, "", ""];
					};
					s_player_lockunlock set [count s_player_lockunlock,_Unlock];
					s_player_lockUnlock_crtl = 1;
				};
			} else {
				if(_hasKey || _oldOwner) then {
					_lock = player addAction [format[localize "STR_EPOCH_ACTIONS_LOCK",_text], "\z\addons\dayz_code\actions\lock_veh.sqf",_cursorTarget, 1, true, true, "", ""];
					s_player_lockunlock set [count s_player_lockunlock,_lock];
					s_player_lockUnlock_crtl = 1;
				};
			};
		};
		 
	} else {
		{player removeAction _x} count s_player_lockunlock;s_player_lockunlock = [];
		s_player_lockUnlock_crtl = -1;
	};

	if(DZE_AllowForceSave) then {
		//Allow player to force save
		if((_isVehicle || _isTent) && !_isMan) then {
			if (s_player_forceSave < 0) then {
				s_player_forceSave = player addAction [format[localize "str_actions_save",_text], "\z\addons\dayz_code\actions\forcesave.sqf",_cursorTarget, 1, true, true, "", ""];
			};
		} else {
			player removeAction s_player_forceSave;
			s_player_forceSave = -1;
		};
	};

	
	
	if(DZE_AllowCargoCheck) then {
		if((_isVehicle || _isTent || _isnewstorage || _typeOfCursorTarget in DZE_Origins_Buildings) && _isAlive && !_isMan && !locked _cursorTarget) then {
			if (s_player_checkGear < 0) then {
				s_player_checkGear = player addAction [localize "STR_EPOCH_PLAYER_CARGO", "\z\addons\dayz_code\actions\cargocheck.sqf",_cursorTarget, 1, true, true, "", ""];
			};
		} else {
			player removeAction s_player_checkGear;
			s_player_checkGear = -1;
		};
	};
	
	
	//flip vehicle small vehicles by your self && all other vehicles with help nearby
	if(_player_flipveh) then {
		if (s_player_flipveh  < 0) then {
			s_player_flipveh = player addAction [format[localize "str_actions_flipveh",_text], "\z\addons\dayz_code\actions\player_flipvehicle.sqf",_cursorTarget, 1, true, true, "", ""];		
		};
	} else {
		player removeAction s_player_flipveh;
		s_player_flipveh = -1;
	}; 
	
	//Allow player to fill jerrycan
	if((_hasFuelE || _hasFuelBarrelE) && _isFuel) then {
		if (s_player_fillfuel < 0) then {
			s_player_fillfuel = player addAction [localize "str_actions_self_10", "\z\addons\dayz_code\actions\jerry_fill.sqf",[], 1, false, true, "", ""];
		};
	} else {
		player removeAction s_player_fillfuel;
		s_player_fillfuel = -1;
	};
	
	// logic vars for addactions
	_player_butcher = false;
	_player_studybody = false;
	_player_SurrenderedGear = false;

	// CURSOR TARGET NOT ALIVE
	if (!_isAlive) then {

		// Gut animal/zed
		if((_isAnimal || _isZombie) && _hasKnife) then {
			_isHarvested = _cursorTarget getVariable["meatHarvested",false];
			if (!_isHarvested) then {
				_player_butcher = true;
			};
		};

		// Study body
		if (_isMan && !_isZombie && !_isAnimal) then {
			_player_studybody = true;
		}
	} else {
		// unit alive

		// gear access on surrendered player
		if(_isMan && !_isZombie && !_isAnimal) then {
			_isSurrendered = _cursorTarget getVariable ["DZE_Surrendered",false];
			if (_isSurrendered) then {
				_player_SurrenderedGear = true;
			};
		};
	};


	// Human Gut animal || zombie
	if (_player_butcher) then {
		if (s_player_butcher < 0) then {
			if(_isZombie) then {
				s_player_butcher = player addAction [localize "STR_EPOCH_ACTIONS_GUTZOM", "\z\addons\dayz_code\actions\gather_zparts.sqf",_cursorTarget, 0, true, true, "", ""];
			} else {
				s_player_butcher = player addAction [localize "str_actions_self_04", "\z\addons\dayz_code\actions\gather_meat.sqf",_cursorTarget, 3, true, true, "", ""];
			};
		};
	} else {
		player removeAction s_player_butcher;
		s_player_butcher = -1;
	};

	// Study Body
	if (_player_studybody) then {
		if (s_player_studybody < 0) then {
				s_player_studybody = player addAction [("<t color=""#FF0000"">"+("Check Wallet") + "</t>"), "Scripts\Gold_Coin_system\Check_Wallet\check_wallet.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_studybody;
		s_player_studybody = -1;
	};

	// logic vars
	_player_cook = false;
	_player_boil = false;

	// CURSOR TARGET IS FIRE
	if (inflamed _cursorTarget) then {
		
		//Fireplace Actions check
		if (_hasRawMeat) then {
			_player_cook = true;	
		};
		
		// Boil water
		if (_hasbottleitem && _hastinitem) then {
			_player_boil = true;
		};
	};

	if (_player_SurrenderedGear) then {
		if (s_player_SurrenderedGear < 0) then {
			s_player_SurrenderedGear = player addAction [localize "STR_EPOCH_ACTIONS_GEAR", "\z\addons\dayz_code\actions\surrender_gear.sqf",_cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_SurrenderedGear;
		s_player_SurrenderedGear = -1;
	};

	//Fireplace Actions check
	if (_player_cook) then {
		if (s_player_cook < 0) then {
			s_player_cook = player addAction [localize "str_actions_self_05", "\z\addons\dayz_code\actions\cook.sqf",_cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_cook;
		s_player_cook = -1;
	};
	
	// Boil water
	if (_player_boil) then {
		if (s_player_boil < 0) then {
			s_player_boil = player addAction [localize "str_actions_boilwater", "\z\addons\dayz_code\actions\boil.sqf",_cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_boil;
		s_player_boil = -1;
	};
	
	if(_cursorTarget == dayz_hasFire) then {
		if ((s_player_fireout < 0) && !(inflamed _cursorTarget) && (player distance _cursorTarget < 3)) then {
			s_player_fireout = player addAction [localize "str_actions_self_06", "\z\addons\dayz_code\actions\fire_pack.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_fireout;
		s_player_fireout = -1;
	};
    //Garage
   	if(_typeOfCursorTarget in DZE_Garage && (player distance _cursorTarget < 5)) then {
		if (s_garage_dialog2 < 0) then {
			s_garage_dialog2 = player addAction ["Vehicle Garage", "Scripts\garage\vehicle_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};
		if (s_garage_dialog < 0) then {
			s_garage_dialog = player addAction ["Store Vehicle in Garage", "Scripts\garage\vehicle_store_list.sqf",_cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_garage_dialog2;
		s_garage_dialog2 = -1;
		player removeAction s_garage_dialog;
		s_garage_dialog = -1;
	};
	//Packing my tent
	if(_isTent && (player distance _cursorTarget < 3)) then {
		if (_ownerID == dayz_characterID) then {
			if (s_player_packtent < 0) then {
				s_player_packtent = player addAction [localize "str_actions_self_07", "\z\addons\dayz_code\actions\tent_pack.sqf",_cursorTarget, 0, false, true, "",""];
			};
		} else {
			if(("ItemJerrycan" in _magazinesPlayer) && ("ItemMatchbox_DZE" in weapons player)) then {
				if (s_player_packtent < 0) then {
					s_player_packtent = player addAction [localize "STR_EPOCH_ACTIONS_DESTROYTENT", "\z\addons\dayz_code\actions\remove.sqf",_cursorTarget, 1, true, true, "", ""];
				};
			};
		};
	} else {
		player removeAction s_player_packtent;
		s_player_packtent = -1;
	};

	//Allow owner to unlock vault
	if((_typeOfCursorTarget in DZE_LockableStorage) && _ownerID != "0" && (player distance _cursorTarget < 3)) then {
		if (s_player_unlockvault < 0) then {
			if(_typeOfCursorTarget in DZE_LockedStorage) then {
				if(_ownerID == dayz_combination || _ownerID == dayz_playerUID) then {
					_combi = player addAction [format[localize "STR_EPOCH_ACTIONS_OPEN",_text], "\z\addons\dayz_code\actions\vault_unlock.sqf",_cursorTarget, 0, false, true, "",""];
					s_player_combi set [count s_player_combi,_combi];
				} else {
					_combi = player addAction [format[localize "STR_EPOCH_ACTIONS_UNLOCK",_text], "\z\addons\dayz_code\actions\vault_combination_1.sqf",_cursorTarget, 0, false, true, "",""];
					s_player_combi set [count s_player_combi,_combi];
				};
				s_player_unlockvault = 1;
			} else {
				if(_ownerID != dayz_combination && _ownerID != dayz_playerUID) then {
					_combi = player addAction [localize "STR_EPOCH_ACTIONS_RECOMBO", "\z\addons\dayz_code\actions\vault_combination_1.sqf",_cursorTarget, 0, false, true, "",""];
					s_player_combi set [count s_player_combi,_combi];
					s_player_unlockvault = 1;
				};
			};
		};
	} else {
		{player removeAction _x} count s_player_combi;s_player_combi = [];
		s_player_unlockvault = -1;
	};
	//Online Banking
	if(_typeOfCursorTarget in DZE_UnLockedStorage and (player distance _cursorTarget < 3)) then {
		if (s_bank_dialog < 0) then {
				s_bank_dialog = player addAction ["Online Banking", "Scripts\Gold_Coin_system\Bank_Dialog\bank_dialog.sqf",_cursorTarget, 3, true, true, "", ""];	
		};
	} else {
     	player removeAction s_bank_dialog;
		s_bank_dialog = -1;
	};

	if(_typeOfCursorTarget in Bank_Object and (player distance _cursorTarget < 3)) then {		
		if (s_bank_dialog2 < 0) then {
			s_bank_dialog2 = player addAction ["Bank ATM", "Scripts\Gold_Coin_system\Bank_Dialog\bank_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};
		if (s_bank_dialog3 < 0) then {
			s_bank_dialog3 = player addAction ["Transfer Money", "Scripts\transfer\transfer_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};		
	} else {		
		player removeAction s_bank_dialog2;
		s_bank_dialog2 = -1;
		player removeAction s_bank_dialog3;
		s_bank_dialog3 = -1;
	};
	
	//Allow owner to pack vault
	if(_typeOfCursorTarget in DZE_UnLockedStorage && _ownerID != "0" && (player distance _cursorTarget < 3)) then {

		if (s_player_lockvault < 0) then {
			if(_ownerID == dayz_combination || _ownerID == dayz_playerUID) then {
				s_player_lockvault = player addAction [format[localize "STR_EPOCH_ACTIONS_LOCK",_text], "\z\addons\dayz_code\actions\vault_lock.sqf",_cursorTarget, 0, false, true, "",""];
			};
		};
		if (s_player_packvault < 0 && (_ownerID == dayz_combination || _ownerID == dayz_playerUID)) then {
			s_player_packvault = player addAction [format["<t color='#ff0000'>%1</t>",(format[localize "STR_EPOCH_ACTIONS_PACK",_text])], "\z\addons\dayz_code\actions\vault_pack.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_packvault;
		s_player_packvault = -1;
		player removeAction s_player_lockvault;
		s_player_lockvault = -1;
	};

	

    //Player Deaths
	if(_typeOfCursorTarget == "Info_Board_EP1") then {
		if (s_player_information < 0) then {
			s_player_information = player addAction [localize "STR_EPOCH_ACTIONS_MURDERS", "\z\addons\dayz_code\actions\list_playerDeaths.sqf",[], 7, false, true, "",""];
		};
	} else {
		player removeAction s_player_information;
		s_player_information = -1;
	};
	//Give Money
	if (_isMan and _isAlive and !_isZombie and !_isAnimal and !(_traderType in serverTraders)) then {
		if (s_givemoney_dialog < 0) then {
			s_givemoney_dialog = player addAction [format["Give Money to %1", (name _cursorTarget)], "Scripts\Gold_Coin_system\Give_Money\give_player_dialog.sqf",_cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_givemoney_dialog;
		s_givemoney_dialog = -1;
	};
	
	//Fuel Pump
	if(_typeOfCursorTarget in dayz_fuelpumparray) then {	
		if (s_player_fuelauto < 0) then {
			
			// check if Generator_DZ is running within 30 meters
			_findNearestGens = nearestObjects [player, ["Generator_DZ"], 30];
			_findNearestGen = [];
			{
				if (alive _x && (_x getVariable ["GeneratorRunning", false])) then {
					_findNearestGen set [(count _findNearestGen),_x];
				};
			} count _findNearestGens;
			_IsNearRunningGen = count (_findNearestGen);
			
			// show that pump needs power if no generator nearby.
			if(_IsNearRunningGen > 0) then {
				s_player_fuelauto = player addAction [localize "STR_EPOCH_ACTIONS_FILLVEH", "\z\addons\dayz_code\actions\fill_nearestVehicle.sqf",objNull, 0, false, true, "",""];
			} else {
				s_player_fuelauto = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_NEEDPOWER"], "",[], 0, false, true, "",""];
			};
		};
	} else {
		player removeAction s_player_fuelauto;
		s_player_fuelauto = -1;
	};

	//Fuel Pump on truck
	if(_typeOfCursorTarget in DZE_fueltruckarray && alive _cursorTarget) then {	
		if (s_player_fuelauto2 < 0) then {
			// show that fuel truck pump needs power.
			if(isEngineOn _cursorTarget) then {
				s_player_fuelauto2 = player addAction [localize "STR_EPOCH_ACTIONS_FILLVEH", "\z\addons\dayz_code\actions\fill_nearestVehicle.sqf",_cursorTarget, 0, false, true, "",""];
			} else {
				s_player_fuelauto2 = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_NEEDPOWER"], "",[], 0, false, true, "",""];
			};
		};
	} else {
		player removeAction s_player_fuelauto2;
		s_player_fuelauto2 = -1;
	};

	// inplace upgrade tool
	if ((_cursorTarget isKindOf "ModularItems") || (_cursorTarget isKindOf "Land_DZE_WoodDoor_Base") || (_cursorTarget isKindOf "CinderWallDoor_DZ_Base")) then {
		if ((s_player_lastTarget select 0) != _cursorTarget) then {
			if (s_player_upgrade_build > 0) then {
				player removeAction s_player_upgrade_build;
				s_player_upgrade_build = -1;
			};
		};
		if (s_player_upgrade_build < 0) then {
			// s_player_lastTarget = _cursorTarget;
			s_player_lastTarget set [0,_cursorTarget];
			s_player_upgrade_build = player addAction [format[localize "STR_EPOCH_ACTIONS_UPGRADE",_text], "dayz_code\actions\player_upgrade.sqf",_cursorTarget, -1, false, true, "",""];
		};
	} else {
		player removeAction s_player_upgrade_build;
		s_player_upgrade_build = -1;
	};
	
	// downgrade system
	if((_isDestructable || _cursorTarget isKindOf "Land_DZE_WoodDoorLocked_Base" || _cursorTarget isKindOf "CinderWallDoorLocked_DZ_Base") && (DZE_Lock_Door == _ownerID)) then {
		if ((s_player_lastTarget select 1) != _cursorTarget) then {
			if (s_player_downgrade_build > 0) then {	
				player removeAction s_player_downgrade_build;
				s_player_downgrade_build = -1;
			};
		};

		if (s_player_downgrade_build < 0) then {
			s_player_lastTarget set [1,_cursorTarget];
			s_player_downgrade_build = player addAction [format[localize "STR_EPOCH_ACTIONS_REMLOCK",_text], "\z\addons\dayz_code\actions\player_buildingDowngrade.sqf",_cursorTarget, -2, false, true, "",""];
		};
	} else {
		player removeAction s_player_downgrade_build;
		s_player_downgrade_build = -1;
	};

	// inplace maintenance tool
	if((_cursorTarget isKindOf "ModularItems" || _cursorTarget isKindOf "DZE_Housebase" || _typeOfCursorTarget == "LightPole_DZ") && (damage _cursorTarget >= DZE_DamageBeforeMaint)) then {
		if ((s_player_lastTarget select 2) != _cursorTarget) then {
			if (s_player_maint_build > 0) then {	
				player removeAction s_player_maint_build;
				s_player_maint_build = -1;
			};
		};

		if (s_player_maint_build < 0) then {
			s_player_lastTarget set [2,_cursorTarget];
			s_player_maint_build = player addAction [format[localize "STR_EPOCH_ACTIONS_MAINTAIN",_text], "\z\addons\dayz_code\actions\player_buildingMaint.sqf",_cursorTarget, -2, false, true, "",""];
		};
	} else {
		player removeAction s_player_maint_build;
		s_player_maint_build = -1;
	};


	//Start Generator
	if(_cursorTarget isKindOf "Generator_DZ") then {
		if (s_player_fillgen < 0) then {
			
			// check if not running 
			if((_cursorTarget getVariable ["GeneratorRunning", false])) then {
				s_player_fillgen = player addAction [localize "STR_EPOCH_ACTIONS_GENERATOR1", "\z\addons\dayz_code\actions\stopGenerator.sqf",_cursorTarget, 0, false, true, "",""];				
			} else {
			// check if not filled && player has jerry.
				if((_cursorTarget getVariable ["GeneratorFilled", false])) then {
					s_player_fillgen = player addAction [localize "STR_EPOCH_ACTIONS_GENERATOR2", "\z\addons\dayz_code\actions\fill_startGenerator.sqf",_cursorTarget, 0, false, true, "",""];
				} else {
					if("ItemJerrycan" in _magazinesPlayer) then {
						s_player_fillgen = player addAction [localize "STR_EPOCH_ACTIONS_GENERATOR3", "\z\addons\dayz_code\actions\fill_startGenerator.sqf",_cursorTarget, 0, false, true, "",""];
					};
				};
			};
		};
	} else {
		player removeAction s_player_fillgen;
		s_player_fillgen = -1;
	};

	//Towing with tow truck
	/*
	if(_typeOfCursorTarget == "TOW_DZE") then {
		if (s_player_towing < 0) then {
			if(!(_cursorTarget getVariable ["DZEinTow", false])) then {
				s_player_towing = player addAction [localize "STR_EPOCH_ACTIONS_ATTACH" "\z\addons\dayz_code\actions\tow_AttachStraps.sqf",_cursorTarget, 0, false, true, "",""];				
			} else {
				s_player_towing = player addAction [localize "STR_EPOCH_ACTIONS_DETACH", "\z\addons\dayz_code\actions\tow_DetachStraps.sqf",_cursorTarget, 0, false, true, "",""];				
			};
		};
	} else {
		player removeAction s_player_towing;
		s_player_towing = -1;
	};
	*/
	// MF-Tow Script by Matt Fairbrass (matt_d_rat)
	call compile preprocessFileLineNumbers 'mf-tow\init.sqf';

    //Sleep
	if(_isTent && _ownerID == dayz_characterID) then {
		if ((s_player_sleep < 0) && (player distance _cursorTarget < 3)) then {
			s_player_sleep = player addAction [localize "str_actions_self_sleep", "\z\addons\dayz_code\actions\player_sleep.sqf",_cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_sleep;
		s_player_sleep = -1;
	};
	
	//Repairing Vehicles
	if ((dayz_myCursorTarget != _cursorTarget) && _isVehicle && !_isMan && _hasToolbox && (damage _cursorTarget < 1) && !_isDisallowRepair) then {
		if (s_player_repair_crtl < 0) then {
			dayz_myCursorTarget = _cursorTarget;
			_menu = dayz_myCursorTarget addAction [localize "STR_EPOCH_PLAYER_REPAIRV", "\z\addons\dayz_code\actions\repair_vehicle.sqf",_cursorTarget, 0, true, false, "",""];
			_menu1 = dayz_myCursorTarget addAction [localize "STR_EPOCH_PLAYER_SALVAGEV", "\z\addons\dayz_code\actions\salvage_vehicle.sqf",_cursorTarget, 0, true, false, "",""];
			s_player_repairActions set [count s_player_repairActions,_menu];
			s_player_repairActions set [count s_player_repairActions,_menu1];
			s_player_repair_crtl = 1;
		} else {
			{dayz_myCursorTarget removeAction _x} count s_player_repairActions;s_player_repairActions = [];
			s_player_repair_crtl = -1;
		};
	};

	// All Traders
	if (_isMan && !_isPZombie && _traderType in serverTraders) then {
		
		if (s_player_parts_crtl < 0) then {

			// get humanity
			_humanity = player getVariable ["humanity",0];
			_traderMenu = call compile format["menu_%1;",_traderType];

			// diag_log ("TRADER = " + str(_traderMenu));
			
			_low_high = "low";
			_humanity_logic = false;
			if((_traderMenu select 2) == "friendly") then {
				_humanity_logic = (_humanity < -5000);
			};
			if((_traderMenu select 2) == "hostile") then {
				_low_high = "high";
				_humanity_logic = (_humanity > -5000);
			};
			if((_traderMenu select 2) == "hero") then {
				_humanity_logic = (_humanity < 5000);
			};
			if(_humanity_logic) then {
				_cancel = player addAction [format[localize "STR_EPOCH_ACTIONS_HUMANITY",_low_high], "\z\addons\dayz_code\actions\trade_cancel.sqf",["na"], 0, true, false, "",""];
				s_player_parts set [count s_player_parts,_cancel];
			} else {
				
				// Static Menu
				{
					//diag_log format["DEBUG TRADER: %1", _x];
					_buy = player addAction [format["Trade %1 %2 for %3 %4",(_x select 3),(_x select 5),(_x select 2),(_x select 6)], "\z\addons\dayz_code\actions\trade_items_wo_db.sqf",[(_x select 0),(_x select 1),(_x select 2),(_x select 3),(_x select 4),(_x select 5),(_x select 6)], (_x select 7), true, true, "",""];
					s_player_parts set [count s_player_parts,_buy];
				
				} count (_traderMenu select 1);
				//Advanced Trading
				_buyV = player addAction ["<t color='#0059FF'>Advanced Trading</t>", "zupa\advancedTrading\init.sqf",(_traderMenu select 0), 999, true, false, "",""];
				s_player_parts set [count s_player_parts,_buyV];
				// Database menu
				_buy = player addAction [localize "STR_EPOCH_PLAYER_289", "\z\addons\dayz_code\actions\show_dialog.sqf",(_traderMenu select 0), 999, true, false, "",""];
				s_player_parts set [count s_player_parts,_buy];

			};
			s_player_parts_crtl = 1;
			
		};
	} else {
		{player removeAction _x} count s_player_parts;s_player_parts = [];
		s_player_parts_crtl = -1;
	};

	
	if(dayz_tameDogs) then {
		
		//Dog
		if (_isDog && _isAlive && (_hasRawMeat) && _ownerID == "0" && player getVariable ["dogID", 0] == 0) then {
			if (s_player_tamedog < 0) then {
				s_player_tamedog = player addAction [localize "str_actions_tamedog", "\z\addons\dayz_code\actions\tame_dog.sqf", _cursorTarget, 1, false, true, "", ""];
			};
		} else {
			player removeAction s_player_tamedog;
			s_player_tamedog = -1;
		};
		if (_isDog && _ownerID == dayz_characterID && _isAlive) then {
			_dogHandle = player getVariable ["dogID", 0];
			if (s_player_feeddog < 0 && _hasRawMeat) then {
				s_player_feeddog = player addAction [localize "str_actions_feeddog","\z\addons\dayz_code\actions\dog\feed.sqf",[_dogHandle,0], 0, false, true,"",""];
			};
			if (s_player_waterdog < 0 && "ItemWaterbottle" in _magazinesPlayer) then {
				s_player_waterdog = player addAction [localize "str_actions_waterdog","\z\addons\dayz_code\actions\dog\feed.sqf",[_dogHandle,1], 0, false, true,"",""];
			};
			if (s_player_staydog < 0) then {
				_lieDown = _dogHandle getFSMVariable "_actionLieDown";
				if (_lieDown) then { _text = "str_actions_liedog"; } else { _text = "str_actions_sitdog"; };
				s_player_staydog = player addAction [localize _text,"\z\addons\dayz_code\actions\dog\stay.sqf", _dogHandle, 5, false, true,"",""];
			};
			if (s_player_trackdog < 0) then {
				s_player_trackdog = player addAction [localize "str_actions_trackdog","\z\addons\dayz_code\actions\dog\track.sqf", _dogHandle, 4, false, true,"",""];
			};
			if (s_player_barkdog < 0) then {
				s_player_barkdog = player addAction [localize "str_actions_barkdog","\z\addons\dayz_code\actions\dog\speak.sqf", _cursorTarget, 3, false, true,"",""];
			};
			if (s_player_warndog < 0) then {
				_warn = _dogHandle getFSMVariable "_watchDog";
				if (_warn) then { _text = (localize "str_epoch_player_247"); _warn = false; } else { _text = (localize "str_epoch_player_248"); _warn = true; };
				s_player_warndog = player addAction [format[localize "str_actions_warndog",_text],"\z\addons\dayz_code\actions\dog\warn.sqf",[_dogHandle, _warn], 2, false, true,"",""];		
			};
			if (s_player_followdog < 0) then {
				s_player_followdog = player addAction [localize "str_actions_followdog","\z\addons\dayz_code\actions\dog\follow.sqf",[_dogHandle,true], 6, false, true,"",""];
			};
		} else {
			player removeAction s_player_feeddog;
			s_player_feeddog = -1;
			player removeAction s_player_waterdog;
			s_player_waterdog = -1;
			player removeAction s_player_staydog;
			s_player_staydog = -1;
			player removeAction s_player_trackdog;
			s_player_trackdog = -1;
			player removeAction s_player_barkdog;
			s_player_barkdog = -1;
			player removeAction s_player_warndog;
			s_player_warndog = -1;
			player removeAction s_player_followdog;
			s_player_followdog = -1;
		};
	};
/////////////////////////////
// CCTV Custom self actions
_isLaptop = _cursorTarget isKindOf "Notebook";
if (_isLaptop && _canDo) then {
    if (s_player_laptop < 0) then {
        s_player_laptop = player addAction ["Activate Laptop", "custom\cctv\init.sqf",_cursorTarget, 1, true, true, "", ""];
    }
} else {
    player removeAction s_player_laptop;
    s_player_laptop = -1;
};
/////////////////////////////
} else {
	//Engineering
	{dayz_myCursorTarget removeAction _x} count s_player_repairActions;s_player_repairActions = [];
	s_player_repair_crtl = -1;

	{player removeAction _x} count s_player_combi;s_player_combi = [];
		
	dayz_myCursorTarget = objNull;
	s_player_lastTarget = [objNull,objNull,objNull,objNull,objNull];

	{player removeAction _x} count s_player_parts;s_player_parts = [];
	s_player_parts_crtl = -1;

	{player removeAction _x} count s_player_lockunlock;s_player_lockunlock = [];
	s_player_lockUnlock_crtl = -1;

	player removeAction s_player_checkGear;
	s_player_checkGear = -1;

	player removeAction s_player_SurrenderedGear;
	s_player_SurrenderedGear = -1;

	//Others
	player removeAction s_player_forceSave;
	s_player_forceSave = -1;
	player removeAction s_player_flipveh;
	s_player_flipveh = -1;
	player removeAction s_player_sleep;
	s_player_sleep = -1;
	player removeAction s_player_deleteBuild;
	s_player_deleteBuild = -1;
	player removeAction s_player_butcher;
	s_player_butcher = -1;
	player removeAction s_player_cook;
	s_player_cook = -1;
	player removeAction s_player_boil;
	s_player_boil = -1;
	player removeAction s_player_fireout;
	s_player_fireout = -1;
	player removeAction s_player_packtent;
	s_player_packtent = -1;
	player removeAction s_player_fillfuel;
	s_player_fillfuel = -1;
	player removeAction s_player_studybody;
	s_player_studybody = -1;
	//Dog
	player removeAction s_player_tamedog;
	s_player_tamedog = -1;
	player removeAction s_player_feeddog;
	s_player_feeddog = -1;
	player removeAction s_player_waterdog;
	s_player_waterdog = -1;
	player removeAction s_player_staydog;
	s_player_staydog = -1;
	player removeAction s_player_trackdog;
	s_player_trackdog = -1;
	player removeAction s_player_barkdog;
	s_player_barkdog = -1;
	player removeAction s_player_warndog;
	s_player_warndog = -1;
	player removeAction s_player_followdog;
	s_player_followdog = -1;
    
    // vault
	player removeAction s_player_unlockvault;
	s_player_unlockvault = -1;
	player removeAction s_player_packvault;
	s_player_packvault = -1;
	player removeAction s_player_lockvault;
	s_player_lockvault = -1;

	player removeAction s_player_information;
	s_player_information = -1;
	player removeAction s_player_fillgen;
	s_player_fillgen = -1;
	player removeAction s_player_upgrade_build;
	s_player_upgrade_build = -1;
	player removeAction s_player_maint_build;
	s_player_maint_build = -1;
	player removeAction s_player_downgrade_build;
	s_player_downgrade_build = -1;
	player removeAction s_player_towing;
	s_player_towing = -1;
	player removeAction s_player_fuelauto;
	s_player_fuelauto = -1;
	/////////////////////////////
	// CCTV Custom self actions
	player removeAction s_player_laptop;
	s_player_laptop = -1;
	/////////////////////////////
	player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	player removeAction s_givemoney_dialog;
	s_givemoney_dialog = -1;
	player removeAction s_bank_dialog;
	s_bank_dialog = -1;
	player removeAction s_bank_dialog2;
	s_bank_dialog2 = -1;
	player removeAction s_bank_dialog3;
	s_bank_dialog3 = -1;
	//Garage
	player removeAction s_garage_dialog2;
	s_garage_dialog2 = -1;
	player removeAction s_garage_dialog;
	s_garage_dialog = -1;
	player removeAction s_player_packOBJ;
	s_player_packOBJ = -1;
};



//Dog actions on player self
_dogHandle = player getVariable ["dogID", 0];
if (_dogHandle > 0) then {
	_dog = _dogHandle getFSMVariable "_dog";
	_ownerID = "0";
	if (!isNull cursorTarget) then { _ownerID = cursorTarget getVariable ["CharacterID","0"]; };
	if (_canDo && !_inVehicle && alive _dog && _ownerID != dayz_characterID) then {
		if (s_player_movedog < 0) then {
			s_player_movedog = player addAction [localize "str_actions_movedog", "\z\addons\dayz_code\actions\dog\move.sqf", player getVariable ["dogID", 0], 1, false, true, "", ""];
		};
		if (s_player_speeddog < 0) then {
			_text = (localize "str_epoch_player_249");
			_speed = 0;
			if (_dog getVariable ["currentSpeed",1] == 0) then { _speed = 1; _text = (localize "str_epoch_player_250"); };
			s_player_speeddog = player addAction [format[localize "str_actions_speeddog", _text], "\z\addons\dayz_code\actions\dog\speed.sqf",[player getVariable ["dogID", 0],_speed], 0, false, true, "", ""];
		};
		if (s_player_calldog < 0) then {
			s_player_calldog = player addAction [localize "str_actions_calldog", "\z\addons\dayz_code\actions\dog\follow.sqf", [player getVariable ["dogID", 0], true], 2, false, true, "", ""];
		};
	};
} else {
	player removeAction s_player_movedog;		
	s_player_movedog =		-1;
	player removeAction s_player_speeddog;
	s_player_speeddog =		-1;
	player removeAction s_player_calldog;
	s_player_calldog = 		-1;
};
//--------------------------------------Deploy Bike----------------------------------
//-----------------------------------------Start--------------------------------------
_isBike = typeOf cursorTarget in ["Old_bike_TK_INS_EP1"];

//PACK BIKE
if((_isBike && (player distance cursorTarget < 10)) and _canDo) then {
if (s_player_deploybike2 < 0) then {
s_player_deploybike2 = player addaction[("<t color=""#4eff00"">" + ("Re-Pack Bike") +"</t>"),"custom\Bike\pack.sqf","",5,false,true,"", ""];
};
} else {
player removeAction s_player_deploybike2;
s_player_deploybike2 = -1;
};
//--------------------------------------Deploy Bike----------------------------------
//------------------------------------------End--------------------------------------
//--------------------------------------Deploy Laptop----------------------------------
//-----------------------------------------Start--------------------------------------
_weapons = [currentWeapon player] + (weapons player);
_isNotebook = typeOf cursorTarget in ["Notebook"];
/*
//Laptop DEPLOY
if ("ItemGPS" in _weapons) then {
hasBikeItem = true;
} else { hasBikeItem = false;};
if((speed player <= 1) && hasBikeItem && _canDo) then {
if (s_player_deploybike < 0) then {
s_player_deploybike = player addaction[("<t color=""#4eff00"">" + ("Deploy Laptop") +"</t>"),"Scripts\laptop\deploy.sqf","",5,false,true,"", ""];
};
} else {
player removeAction s_player_deploybike;
s_player_deploybike = -1;
};
*/
//PACK Laptop
if((_isNotebook) and _canDo) then {
if (s_player_packlaptop < 0) then {
        s_player_packlaptop = player addaction[("<t color=""#4eff00"">" + ("Re-Pack Laptop") +"</t>"),"Scripts\laptop\pack.sqf","",5,false,true,"", ""];
    };
} else {
    player removeAction s_player_packlaptop;
    s_player_packlaptop = -1;
};
//--------------------------------------Deploy Laptop----------------------------------
//------------------------------------------End----------------------------------------
//DANCE
    if (inflamed cursorTarget and _canDo) then {
            if (s_player_dance < 0) then {
            s_player_dance = player addAction ["Dance!","Scripts\dance\dance.sqf",cursorTarget, 0, false, true, "",""];
        };
    } else {
        player removeAction s_player_dance;
        s_player_dance = -1;
    };
//End