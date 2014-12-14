private ["_isIsland","_pos","_findSpot","_mkr","_position","_isNear","_isZero","_counter","_DRNLocs","_DRNloc"];
_DRNLocs = [
 //Byelov
    [[17523.328, 9091.4248, 0], [17076.732, 5968.8247, 0], [17413.566, 5698.9531, 0], [15922.013, 7711.0337, 0], [18436.338, 7400.833, 0]],
//Sabina
    [[16065.567, 9707.8213, 0], [16186.637, 9896.748, 0], [14211.828, 9392.2061, 0], [14737.595, 10706.348, 0], [15859.695, 10548.901, 0]],
//Etanovsk
    [[12989.63, 12111.428, 0], [12468.518, 12221.747, 0], [12183.625, 11923.739, 0], [12670.377, 11496.789, 0], [13124.203, 11691.64, 0]],
//Lyepestok
    [[11001.797, 16166.805, 0], [11904.369, 16051.938, 0], [12874.765, 15924.021, 0], [10965.275, 14545.628, 0], [10764.415, 15576.812, 0]],
//Martin
    [[17106.078, 13886.403, 0], [16700.227, 13106.866, 0], [15653.755, 13267.145, 0], [15681.057, 13755.266, 0], [16287.099, 14370.88, 0]],
//Dalnogorsk
    [[15583.163, 17857.9, 0], [14616.287, 17819.131, 0], [14614.673, 18838.443, 0], [14451.644, 18667.211, 0], [14193.382, 18319.9, 0]],
//Yaroslav
    [[10618.926, 19516.426, 0], [9558.0479, 19493.838, 0], [9531.3721, 18690.895, 0], [10089.513, 18245.27, 0], [9791.9746, 18206.254, 0]],
//Kameni
    [[8162.9868, 19608.584, 0], [8384.126, 19031.889, 0], [9546.3154, 19681.273, 0], [8674.6729, 18972.119, 0], [9279.9795, 19195.043, 0]],
//Seven
    [[10931.09, 1247.8394, 0], [11212.338, 546.28143, 0], [11650.999, 565.18555, 0], [10469.341, 897.06116, 0], [11501.98, 1041.9922, 0]],
//Branibor
    [[8238.5771, 4887.6709, 0], [8259.9219, 3651.3596, 0], [6755.0713, 5013.1714, 0], [7515.5015, 5029.1934, 0], [7827.6777, 3507.1685, 0]],
//Shtangrad
    [[2836.4338, 7784.7856, 0], [3004.8311, 7115.0757, 0], [3581.7754, 7204.4663, 0], [3786.781, 7671.9453, 0], [3135.1558, 7878.5723, 0]],
//Vedich
    [[7002.519, 10329.759, 0], [7322.0103, 9960.6338, 0], [6353.1494, 9659.0957, 0], [6376.5269, 10262.174, 0], [7089.5347, 9565.5166, 0]],
//Krazno
    [[6544.3008, 7690.4844, 0], [8081.1699, 8216.5176, 0], [8147.8745, 7022.9292, 0], [8342.6514, 7909.4424, 0], [6352.1929, 8857.3682, 0]]
    ];
drnspawn = -1;
cutText ["","BLACK OUT"];
_ok = createDialog "DRN_DIALOG";
waitUntil { drnspawn != -1};
if (drnspawn == 13) then {drnspawn = floor (random 12)};
_DRNloc = _DRNLocs select drnspawn;
	//Spawn modify via mission init.sqf
	if(isnil "spawnArea") then {
		spawnArea = 1500;
	};
	if(isnil "spawnShoremode") then {
		spawnShoremode = 1;
	};
	//spawn into random
	_findSpot = true;
	_mkr = "";
	while {_findSpot} do {
		_counter = 0;
		while {_counter < 20 and _findSpot} do {
			// switched to floor
			_mkr = _DRNLoc select(floor(random (count _DRNLoc)));
			_position = ([(_mkr),0,spawnArea,10,0,2000,spawnShoremode] call BIS_fnc_findSafePos);
			_isNear = count (_position nearEntities ["Man",100]) == 0;
			_isZero = ((_position select 0) == 0) and ((_position select 1) == 0);
			//Island Check
			_pos 		= _position;
			_isIsland	= false;		//Can be set to true during the Check
			for [{_w=0},{_w<=150},{_w=_w+2}] do {
				_pos = [(_pos select 0),((_pos select 1) + _w),(_pos select 2)];
				if(surfaceisWater _pos) exitWith {
					_isIsland = true;
				};
			};
			
			if ((_isNear and !_isZero) || _isIsland) then {_findSpot = false};
			_counter = _counter + 1;
		};
	};
	_isZero = ((_position select 0) == 0) and ((_position select 1) == 0);
	_position = [_position select 0,_position select 1,0];
	diag_log("DEBUG: spawning new player at" + str(_position));
	if (!_isZero) then {
		player setPosATL _position;
	};
cutText ["","BLACK IN"];
