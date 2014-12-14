//don't touch this
Confirmed_Drop_veh=
[
	["",true],
	["Confirm drop!", [-1], "", -5, [["expression", ""]], "1", "0"],
	["Are you sure you want to drop the vehicle now?", [-1], "", -5, [["expression", ""]], "1", "0"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["No", [2], "", -3, [["expression", "HALV_DROPcontrol_HALVveh=false;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["Yes", [3], "", -5, [["expression","HALV_DROPcontrol_HALVveh=true;"]], "1", "1"],
	["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["Exit", [-1], "", -3, [["expression", "HALV_DROPcontrol_HALVveh=false;"]], "1", "1"]
];
showCommandingMenu "#USER:Confirmed_Drop_veh";
WaitUntil{HALV_DROPcontrol_HALVveh};
HALV_says_DROPNOW_veh=true;