class ExtraRc {
	class ItemRadio {
		class radiocommand1 {
			text = "Group Management";
			script = "[] execVM 'dzgm\loadGroupManagement.sqf'";
		};
		class radiocommand2 {
			text = "Transfer Coins";
			script = "[] execVM 'Scripts\transfer\transfer_dialog.sqf'";
		};
	};
	class ItemGPS {
		class DeployLaptop1 {
			text = "Deploy Laptop";
			script = "[] execVM 'Scripts\laptop\deploy.sqf'";
		};
		class DeployLaptop2 {
			text = "Permanent Laptop";
			script = "[""Notebook"",[""ItemToolbox""],[[""ItemLightBulb"", 1],[""PartGeneric"", 2],[""PartGlass"", 1]],[0,3.5,1.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class ItemLightBulb {
		class menuItem1 {
			text = "Camera";
			script = "[""Loudspeaker"",[""ItemToolbox""],[[""ItemLightBulb"", 1],[""PartGeneric"", 2]],[0,3.5,1.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
		class menuItem2 {
			text = "Wall Light";
			script = "[""LAND_ASC_Wall_Lamp_New"",[""ItemToolbox""],[[""ItemLightBulb"", 1],[""PartGeneric"", 1]],[0,3.5,1.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class HandRoadFlare {
		class Helipad {
			text = "Helicopter Pad";
			script = "[""HeliH"",[""ItemToolbox""],[[""HandRoadFlare"", 4]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class cinder_garage_kit {
		class Garage {
			text = "Virtual Garage";
			script = "[""Land_MBG_Garage_Single_A"",[""ItemToolbox""],[[""CinderBlocks"", 3],[""cinder_garage_kit"", 1]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class ItemEtool {
		class Well {
			text = "Water Well";
			script = "[""Land_pumpa"",[""ItemToolbox"",""ItemEtool"",""ItemSledge""],[[""PartGeneric"", 2],[""MortarBucket"", 3],[""ItemPole"", 6]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class PartWoodPlywood {
		class table {
			text = "Small Table";
			script = "[""SmallTable"",[""ItemToolbox"",""ItemHatchet_DZE""],[[""PartWoodPlywood"", 1],[""PartGeneric"", 3]],[0,3.5,1.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class ItemToolbox {
		class BIKE {
            text = "Deploy Bike";
            script = "[] execVM ""custom\Bike\deploy.sqf"";";
		};
	};
};
