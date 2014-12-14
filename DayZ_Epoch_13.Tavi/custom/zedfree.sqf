		while {isSector} do 
		{
			{
				if (!isNull _x) then {
					if !(isPlayer _x) then {
						deletevehicle _x;
					};
				};
			} forEach (vehicle player nearEntities ["zZombie_Base",1500]); //Adjust radius again
			uiSleep 1;
		};