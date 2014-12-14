class ExtraRc {
	class ItemRadio {
		class GroupManagement {
			text = "Group Management";
			script = "[] execVM 'dzgm\loadGroupManagement.sqf'";
		};
	};
	class ItemGPS {
		class DeployLaptop {
			text = "Deploy Laptop";
			script = "[] execVM 'Scripts\laptop\deploy.sqf'";
		};
	};
	class ItemLightBulb {
		class menuItem1 {
			text = "Camera";
			script = "[""Loudspeaker"",[""ItemToolbox"",""ItemHatchet_DZE""],[[""ItemLightBulb"", 1]],[0,6.5,2.5]] execVM ""custom\snap_pro\player_build.sqf"";";
		};
	};
	class ItemToolbox {
		class BIKE {
            text = "Deploy Bike";
            script = "[] execVM ""custom\Bike\deploy.sqf"";";
		};
	};
};
