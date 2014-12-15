class ExtraRc {
	class ItemRadio {
		class GroupManagement {
			text = "Group Management";
			script = "[] execVM 'dzgm\loadGroupManagement.sqf'";
		};
	};
	class ItemGPS {
		class DeployLaptop1 {
			text = "Deploy Laptop";
			script = "[] execVM 'Scripts\laptop\deploy.sqf'";
		};
		class DeployLaptop2 {
			text = "Permanent Laptop";
			script = "[""Notebook"",[""ItemToolbox"",""ItemHatchet_DZE""],[[""ItemLightBulb"", 1]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class ItemLightBulb {
		class menuItem1 {
			text = "Camera";
			script = "[""Loudspeaker"",[""ItemToolbox"",""ItemHatchet_DZE""],[[""ItemLightBulb"", 1]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class HandRoadFlare {
		class Helipad {
			text = "Helicopter Pad";
			script = "[""HeliH"",[""ItemToolbox""],[[""HandRoadFlare"", 4]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class cinder_garage_kit {
		class Helipad {
			text = "Virtual Garage";
			script = "[""Land_MBG_Garage_Single_A"",[""ItemToolbox""],[[""CinderBlocks"", 3],[""cinder_garage_kit"", 1]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class ItemToolbox {
		class BIKE {
            text = "Deploy Bike";
            script = "[] execVM ""custom\Bike\deploy.sqf"";";
		};
	};
};
