/*
Name: Wihnachtsmusik in Trader city
Date: 06/11/2013
Mod: Dayz Epoch
Map: Chernarus
*/

// Trader City Lyepestok
_this = createTrigger ["EmptyDetector", [11695.65, 15210.947, 0]];
_this setTriggerArea [50, 50, 0, false];
_this setTriggerActivation ["NONE", "PRESENT", true];
_this setTriggerStatements ["(player distance trading_post1) < 50;", "music = true;", "music = false;"];
trading_post1 = _this;
_trigger_0 = _this;
