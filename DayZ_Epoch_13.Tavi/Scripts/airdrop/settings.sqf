////////////////////settings/////////////////////////
//admins UID goes here
_Is_Admin		= [
"76561198076431453",//R3AP3R
"76561198090037641",//Skinner
"76561198106545535"//Sweets
];
//your scripts path
_thePath		= "Scripts\airdrop\";
// Time in seconds before player can drop again, default 300=5min
_dropCooldown	= 200;
//if true disables player completly while calling in the drop
_disablePlayer	= false;
// Combat Check mode // 2= 1.8+ code // 1= before 1.8code // 0= off //note that Combat check for 1.8+ code is very annoying //
_InCombMode		= 0;
//Item (Magazine) to enable drop, besides toolbox
_kitItem		= "ItemHotwireKit";
//Broadcast "descrete" hint to all players when someone calls a drop? (false = only caller)
_BCast			=  true;
//Delete box?
_Del_Box		=  true; 
//Delete admin box?
_Del_aBox		= true; 
//Time in sec before box deletes (add 60sec for plane del)
_Del_BoxTime	= 840; 
//Countdown to autodrop if player has drop control
_ADVDroptimeOut	= 5; 
//Clear Vehicle Inventory?
_Clr_VehInv		=  true; 
//Clear Vehicle ammo? //0=no vehicle ammo //1=normal vehicle ammo //2=full vehicle ammo
_Vehammo		= 1; 
//item to activate adv. debug and drop control
_RCitem			= "ItemRadio"; 
//Only one bag! Backpack in admin drop, just change to what you want
_baGType		= "DZ_Backpack_EP1"; 
//add extra keykits to admin drop? (epoch, other mods set to false)
_akeYKits		=  true; 
_keYKits		= 5; 
// Amount of Weapons in admin box
_wepcount		= 3; 
// Amount of Magazines in admin box
_magcount		= 25; 
//Vehcle drop settings, first the list of vehicles you do want, you can also use
//"Car", "Truck" or simmular instead to only drop cars and trucks.
//i set it to drop "LandVehicle","Air", wich is all land and air vehicles as default
_TheVehList		= ["LandVehicle","Air"];
//This is a list of vehicles you dont want
//nr2 line is an example of how to exclde more vehicles !!ONLY UNCOMMENT ONE LINE!!
_TheVehNogoList	= ["BIS_Steerable_Parachute","ParachuteBase","Steerable_Parachute_EP1","StaticWeapon","MQ9PredatorB","MQ9PredatorB_US_EP1","C130J_base","Chukar","Chukar_EP1","Tank","GRAD_base","Bicycle","Bike"];
//_TheVehNogoList	= ["BIS_Steerable_Parachute","ParachuteBase","Steerable_Parachute_EP1","Tank","StaticWeapon","MQ9PredatorB","MQ9PredatorB_US_EP1","BRDM2_base","GRAD_base","BTR90_base","LAV25_base","C130J_base","Chukar","Chukar_EP1","MAZ_543_SCUD_TK_EP1","M1126_ICV_M2_EP1","M1126_ICV_mk19_EP1","M1130_CV_EP1","M1129_MC_EP1","M1135_ATGMV_EP1","M1128_MGS_EP1","M1133_MEV_EP1","AH1Z","AV8B2","AV8B","A10","Mi17_rockets_RU","Mi24_base","AH64_base_EP1","F35B","Ka52","Ka52Black","Su25_base","Mi17sh_rockets_CZ_EP1","Ka137_base","L39_TK_EP1","AW159_Lynx_BAF","Bicycle","Bike"];
//Change plane/heli here
//Note that choppers are prone to blow up randomly! 
//Also i changed the an2 to always switch to mv22 in the_box_car.sqf
_planeheli = [
"MV22_DZ",
"MV22",
"CH_47F_EP1",
"CH_47F_EP1_DZE",
"An2_TK_EP1",
"C130J",
"C130J_US_EP1",
"BAF_Merlin_HC3_D"
];
//Start positions
_start_pos = [
[186.79173,534.80164,300],
[6413.3403,536.53473,300],
[12865.014,474.09485,300],
[15893.143,4209.8242,300],
[15872.32,10162.014,300],
[9493.502,16218.27,300],
[3458.0669,16218.271,300],
[159.3903,11785.348,300],
[148.98456,5864.3755,300],
[15830.713,16249.488,300]
];
//HALV drop content, just add the name of item twice if you want more, do some math to get the amount you want
//2 of each weapon/item
_HALVw2List = ["ItemCrowbar","ItemCompass","ItemFlashlightRed","ItemGPS","ItemKnife","ItemHatchet_DZE","ItemMatchbox_DZE","ItemEtool","ItemToolbox","ItemCompass"];
//20 of each "magazines"
_HALVm20List = ["30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","ItemBandage","FoodSteakCooked","ItemSodaPepsi","ItemHeatPack","ItemWaterbottle","FoodCanPasta"];
//10 of each "magazines"
_HALVm10List = ["30Rnd_556x45_StanagSD","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","SmokeShell","SmokeShellRed","SmokeShellYellow","SmokeShellGreen","ItemTrashToiletpaper","ItemTrashRazor","HandChemGreen","HandChemBlue","HandChemRed","TrashJackDaniels","TrashTinCan","HandRoadFlare","ItemCorrugated","ItemCanvas","ItemPole","ItemKiloHemp","ItemFuelBarrel","CinderBlocks","MortarBucket"];
//5 of each "magazines"
_HALVm5List = ["ItemAntibiotic","ItemWire","PartWoodPile","ItemTankTrap","ItemSandbag","ItemBurlap","ItemLightBulb","FoodMRE"];
//2 of each "magazines"
_HALVm2List = ["30m_plot_kit","PartGlass","PartFueltank","PartWheel","PartEngine","PartGeneric","ItemJerrycan"];
//1 of each "magazines"
_HALVm1List = ["ItemVault","ItemGenerator"];
//Some extra stuff in MedBox0//Only change for "magazines" (_SesiM01 = 1 of each, _SesiM05 = 5 of each) and FoodBox0 (_SesiF06 = 6 of each)
_SesiM01 = ["ItemTentDomed2","ItemTentDomed","ItemTentOld"];
_SesiM05 = ["FoodMRE","ItemAntibiotic","ItemHeatPack"];
_SesiF06 = ["FoodMRE","FoodNutmix","FoodCanBakedBeans","FoodCanFrankBeans","ItemSodaOrangeSherbet","ItemSodaPepsi","ItemSodaCoke","ItemSodaMdew","ItemSodaRbull","ItemWaterbottle","ItemSodaRabbit","ItemTrashToiletpaper","ItemTrashRazor","ItemHeatPack"];
//Change boxes here
_THEboxes = [
"RUSpecialWeaponsBox",
"BAF_OrdnanceBox",
"USBasicWeaponsBox",
"USBasicAmmunitionBox",
"USBasicWeapons_EP1",
"USBasicAmmunitionBox_EP1",
"UNBasicWeapons_EP1",
"UNBasicAmmunitionBox_EP1",
"TKSpecialWeapons_EP1",
"TKBasicWeapons_EP1",
"TKBasicAmmunitionBox_EP1",
"FoodBox0",
"MedBox0",
"SpecialWeaponsBox",
"RUSpecialWeaponsBox",
"RUBasicWeaponsBox",
"RUBasicAmmunitionBox",
"Ammobox_PMC",
"LocalBasicWeaponsBox",
"LocalBasicAmmunitionBox",
"GuerillaCacheBox_EP1",
"GuerillaCacheBox",
"GERBasicWeapons_EP1",
"CZBasicWeapons_EP1",
"BAF_BasicAmmunitionBox",
"BAF_BasicWeapons",
"USSpecialWeaponsBox",
"USSpecialWeapons_EP1"
];
///////////////Exchange settings///////////////
//List of unwantet weapons
_NoGoWeList=[
"SCAR_L_STD_EGLM_TWS",
"M249_TWS_EP1",
"m8_tws_sd",
"m8_tws",
"SCAR_H_STD_TWS_SD",
"M110_TWS_EP1",
"m107_TWS_EP1",
"Laserdesignator",
"BAF_AS50_TWS",
"MAAWS",
"Javelin",
"Stinger",
"M136",
"SMAW",
"Igla",
"MetisLauncher",
"RPG7V",
"RPG18",
"Strela",
"M47Launcher_EP1",
"BAF_NLAW_Launcher"
]; //"ksvk","m107","m107_DZ"
//List of unwantet magazines
_NoGoMaList=[
"Mine",
"6Rnd_HE_M203",
"20Rnd_B_AA12_HE",
"M136",
"Laserbatteries",
"SMAW_HEAA",
"SMAW_HEDP",
"Igla",
"AT13",
"PG7V",
"PG7VL",
"PG7VR",
"OG7",
"RPG18",
"Strela",
"Javelin",
"MAAWS_HEAT",
"MAAWS_HEDP",
"Dragon_EP1",
"NLAW",
"Stinger",
"MineE"
]; // "5Rnd_127x108_KSVK","20Rnd_762x51_SB_SCAR","10Rnd_127x99_m107"
//List of stuff to change unwantet weapons for:
_NoGoWe_ExList=[
"FN_FAL_ANPVS4",
"FN_FAL",
"UZI_SD_EP1",
"Binocular_Vector",
"NVGoggles",
"ItemCompass",
"ItemHatchet_DZE",
"ItemKnife",
"Itemmatchbox_DZE",
"Itemetool",
"Itemtoolbox",
"ItemGPS",
"ItemRadio",
"ItemKeyKit",
"ItemShovel",
"ItemSledge"
];
//List of stuff to change unwantet magazines for:
_NoGoMa_ExList=[
"TrashJackDaniels",
"TrashTinCan",
"PartEngine",
"ItemJerrycan",
"ItemMorphine",
"ItemBloodbag",
"ItemPainkiller",
"ItemEpinephrine",
"ItemSodaLvg",
"FoodSteakCooked",
"ItemBandage",
"ItemSodaSmasht",
"ItemSodaMdew",
"ItemAntibiotic",
"ItemKiloHemp",
"PartOreGold",
"ItemFuelBarrel",
"CinderBlocks",
"MortarBucket",
"TrapBear",
"20Rnd_762x51_FNFAL",
"30Rnd_9x19_UZI_SD",
"ItemTinBar",
"HandGrenade_Stone",
"PartOreSilver",
"ItemAluminumBar",
"ItemBronzeBar",
"ItemCopperBar",
"ItemSilverBar",
"FoodMRE",
"ItemHeatPack",
"FoodNutmix",
"FoodCanBakedBeans",
"FoodCanFrankBeans",
"ItemSodaPepsi",
"ItemSodaCoke",
"ItemSodaMdew",
"ItemWaterbottle",
"ItemSodaRabbit",
"ItemTrashToiletpaper",
"HandChemGreen",
"HandChemBlue",
"HandChemRed",
"HandRoadFlare",
"ItemSledgeHandle",
"ItemSledgeHead"
];
///////////////End of settings area///////////////
//this is the box it drops initially drops, just leave these
_DROPbox = [
"Misc_cargo_cont_net1",
"USVehicleBox",
"RUVehicleBox",
"Misc_cargo_cont_tiny",
"Misc_cargo_cont_small2",
"Misc_cargo_cont_small_EP1"
];