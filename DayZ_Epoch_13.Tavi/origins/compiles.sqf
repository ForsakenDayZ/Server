if (!isDedicated) then {
	//fnc_usec_selfActions = compile preprocessFileLineNumbers "Scripts\Fn_SelfActions\fn_selfActions.sqf";		//Checks which actions for self
	origins_checkNeededMaterial = compile preprocessFileLineNumbers "origins\origins_checkNeededMaterial.sqf";
	origins_removeActions = compile preprocessFileLineNumbers "origins\origins_removeActions.sqf";
};