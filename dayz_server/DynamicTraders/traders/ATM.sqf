private ["_camp"];

_x = _this select 0;
_y = _this select 1;

_camp = [
	["MAP_Stan",[1.22424, 2.27466],118.722,1,0,{}],
	["Land_fort_bagfence_long",[-3.85132, 1.37549],294.692,1,0,{}],
	["Land_fort_bagfence_long",[-4.18225, -2.40015],247.759,1,0,{}],
	["Land_fort_bagfence_long",[-1.40881, -5.00037],204.942,1,0,{}],
	["Land_fort_bagfence_long",[-2.05664, 4.82141],297.231,1,0,{}],
	["Land_fort_bagfence_long",[2.36511, -5.49988],349.043,1,0,{}],
	["Land_Barrel_water",[5.19116, 3.53699],359.906,1,0,{}],
	["Land_fort_bagfence_long",[0.583496, 7.08423],171.749,1,0,{}],
	["Land_fort_bagfence_long",[3.99854, 6.14856],206.912,1,0,{}],
	["Land_fort_bagfence_long",[6.66577, 3.43762],241.441,1,0,{}]
];

[[_x, _y], 0, _camp] call DT_fnc_ObjectsMapper;

["Functionary1_EP1", [_x + 0.855347,_y + 2.52014], (296.783-180)] call DT_fnc_CreateTrader;
