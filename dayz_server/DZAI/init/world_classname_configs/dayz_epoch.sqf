/*
	DayZ Epoch configuration
	
	Description: Adds DayZ Epoch-specific items to DZAI loot tables if Epoch mode is on.
	
	Last updated: 5:10 PM 9/8/2013
	
*/

DZAI_metalBars = [["ItemSilverBar",0.15],["ItemSilverBar10oz",0.10],["ItemGoldBar",0.075],["ItemGoldBar10oz",0.035]]; //Format: [["Bar1Classname",Bar1Chance],["Bar2Classname",Bar2Chance],["Bar2Classname",Bar2Chance]]
DZAI_metalBarNum = 2;		//Maximum number of metal bars to generate

DZAI_banditTypesNew = 
[
 "SBH_Alpha_Soldier1"
,"SBH_Alpha_Soldier2"
,"SBH_Alpha_Soldier3"
,"SBH_Alpha_Soldier4"
,"SBH_Alpha_Soldier5"
,"SBH_Alpha_Soldier6"
,"SBH_Alpha_Soldier7"
,"SBH_Alpha_Soldier8"
,"SBH_Alpha_Soldier9"
,"SBH_Alpha_Soldier10"
,"SBH_Alpha_Soldier11"
,"SBH_Alpha_Soldier12"
];
DZAI_ediblesNew = ["ItemSodaRabbit","ItemSodaMtngreen","ItemSodaClays","ItemSodaSmasht","ItemSodaDrwaste","ItemSodaLemonade","ItemSodaLvg","ItemSodaMzly","FoodBioMeat","FoodCanGriff","FoodCanBadguy","FoodCanBoneboy","FoodCanCorn","FoodCanCurgon","FoodCanDemon","FoodCanFraggleos","FoodCanHerpy","FoodCanOrlok","FoodCanPowell","FoodCanTylers","FoodPumpkin","FoodSunFlowerSeed"];
DZAI_MiscItemSNew = ["ItemZombieParts"];

DZAI_Backpacks0New = ["DZ_TerminalPack_EP1"]; //Added: DZ_TerminalPack_EP1
DZAI_Backpacks1New = ["DZ_TerminalPack_EP1", "DZ_CompactPack_EP1"]; //Added: DZ_TerminalPack_EP1, DZ_CompactPack_EP1
DZAI_Backpacks2New = ["DZ_CompactPack_EP1","DZ_GunBag_EP1"]; //Added: DZ_CompactPack_EP1, DZ_GunBag_EP1
DZAI_Backpacks3New = ["DZ_GunBag_EP1","DZ_LargeGunBag_EP1"]; //Added: DZ_GunBag_EP1, DZ_LargeGunBag_EP1

//Do not edit below lines. Replaces standard hatchet and matchbox classnames with Epoch versions.
(DZAI_tools0 select 3) set [0,"ItemHatchet_DZE"];
(DZAI_tools0 select 7) set [0,"ItemMatchbox_DZE"];
(DZAI_tools1 select 3) set [0,"ItemHatchet_DZE"];
(DZAI_tools1 select 7) set [0,"ItemMatchbox_DZE"];

diag_log "[DZAI] Epoch classnames loaded.";
