// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//  @file Name: fn_AmmoTruck.sqf
//  @file Author: Wiking, AgentRev, micovery

#define RESUPPLY_TRUCK_DISTANCE 20
#define REARM_TIME_SLICE 5
#define REPAIR_TIME_SLICE 1
#define REFUEL_TIME_SLICE 1
#define PRICE_RELATIONSHIP 10 // resupply price = brand-new store price divided by PRICE_RELATIONSHIP
#define RESUPPLY_TIMEOUT 30

// Check if mutex lock is active.
if (mutexScriptInProgress) exitWith {
	titleText ["You are already performing another action.", "PLAIN DOWN", 0.5];
};

mutexScriptInProgress = true;
doCancelAction = false;

params ["", ["_unit",objNull,[objNull]]];

_vehicle = vehicle _unit;
_pylonsequiped = GetPylonMagazines _vehicle;

_pylons =
  [
    ["PylonRack_1Rnd_LG_scalpel",             1000],   	//SCALPEL X1
    ["PylonRack_3Rnd_LG_scalpel",             3000],  	//SCALPEL X3
    ["PylonRack_4Rnd_LG_scalpel",             4000],		//SCALPEL X4
    ["PylonRack_1Rnd_Missile_AGM_02_F",       4000], 		//MACER AGM X1
    ["PylonRack_Missile_AGM_02_x1",           5000],		//MACER II AGM X1
    ["PylonMissile_Missile_AGM_02_x2",        8000], 		//MACER AGM X2
    ["PylonRack_Missile_AGM_02_x2",           10000],		//MACER II X2
    ["PylonRack_3Rnd_Missile_AGM_02_F",       12000], 	//MACER AGM X3
    ["PylonRack_12Rnd_PG_missiles",           10000], 	//DAGR X12
    ["PylonRack_1Rnd_Missile_AGM_01_F",       4000],		//SHARUR X1
    ["PylonMissile_Missile_AGM_KH25_x1",      5000],		//KH-25 X1
    ["PylonRack_1Rnd_Missile_AA_04_F",        5000], 		//FALCHION 22 X1
    ["PylonRack_1Rnd_AAA_missiles",           2500], 		//ASRAAM X1
    ["PylonRack_Missile_AMRAAM_C_x1",         4000],		//AMRAAM C X1
    ["PylonRack_Missile_AMRAAM_C_x2",         8000],		//AMRAAM C X2
    ["PylonMissile_Missile_AMRAAM_D_INT_x1",  5000], 		//AMRAAM D X1
    ["PylonRack_Missile_AMRAAM_D_x2",         10000], 	//AMRAAM D X2
    ["PylonRack_Missile_BIM9X_x2",            14000], 	//BIM9X X2
    ["PylonMissile_Missile_BIM9X_x1",         7000],		//BIM8X X1
    ["PylonRack_1Rnd_Missile_AA_03_F",        8000], 		//SAHR-3
    ["PylonMissile_Missile_AA_R73_x1",        9000],		//R-73 X1
    ["PylonMissile_Missile_AA_R77_x1",        10000],		//R-77 X1
    ["PylonRack_1Rnd_GAA_missiles",           15000],		//ZYPHER X1
    ["PylonRack_12Rnd_missiles",              3000], 		//DAR ROCKETS X12
    ["PylonRack_7Rnd_Rocket_04_HE_F",          8000],   //SHRIEKER HE ROCKETS X7
    ["PylonRack_7Rnd_Rocket_04_AP_F",          7000], 	//SHRIEKER AP ROCKETS X7
    ["PylonRack_20Rnd_Rocket_03_HE_F",         10000],	//TRATNYR HE ROCKETS X20
    ["PylonRack_20Rnd_Rocket_03_AP_F",         12000],	//TRATNYR AP ROCKETS X20
    ["PylonRack_19Rnd_Rocket_Skyfire",         9000],		//SKYFIRE X19
    ["PylonMissile_1Rnd_Bomb_04_F",            2500], 	//GBU-12 GUIDED BOMB NATO X1
    ["PylonMissile_1Rnd_Bomb_03_F",            2500],		//LOM-250G GUIDED BOMB CSAT X1
    ["PylonMissile_Bomb_GBU12_x1",             2500], 	//GBU-12 LASER GUIDIED BOMB X1
    ["PylonRack_Bomb_GBU12_x2",                5000],		//GBU-12 LASER GUIDED BOMB X2
    ["PylonMissile_Bomb_KAB250_x1",            2500],		//KAB250 GUIDED BOMB X1
    ["PylonMissile_1Rnd_Mk82_F",               500], 		//MK-82 DUMB BOMB X1
    ["PylonWeapon_300Rnd_20mm_shells",         700],		//20mm TWIN CANNON
    ["PylonWeapon_2000Rnd_65x39_belt",         100]			//6.5mm GATTLING GUN (RIGHT SIDE)
  ];

//check if caller is in vehicle
if (_vehicle == _unit) exitWith {};

_resupplyThread = [_vehicle, _unit] spawn
{
	params ["_vehicle", "_unit"];

	_vehClass = typeOf _vehicle;
	_vehCfg = configFile >> "CfgVehicles" >> _vehClass;
	_vehName = getText (_vehCfg >> "displayName");
	_isUAV = (round getNumber (_vehCfg >> "isUav") >= 1);
	_isStaticWep = _vehClass isKindOf "StaticWeapon";

	scopeName "AmmoTruckThread";

	_baseprice = 1000; // price = 1000 for vehicles not found in vehicle store
	{
		if (_vehClass == _x select 1) exitWith
		{
			_baseprice = _x select 2;
			_baseprice = round (_baseprice / PRICE_RELATIONSHIP);
		};
	} forEach (call allVehStoreVehicles + call staticGunsArray);

 _pylonprice = 0;
	{
    _pylonweapon = _x foreach _pylonsequiped;
    if (_pylonweapon == _x select 0) exitWith
    {
      _pylonprice = _x select 1;
    } forEach _pylons;
  };
  _price = (_baseprice + _pylonprice);

  _titleText = { titleText [_this, "PLAIN DOWN", ((REARM_TIME_SLICE max 1) / 10) max 0.3] };

	_checkAbortConditions =
	{
		private _abortText = "";
		private _pauseText = "";
		private "_checkCondition";

		call
		{
			if (doCancelAction) exitWith
			{
				doCancelAction = false;
				_abortText = "Cancelled by player.";
			};

			if (!alive player) exitWith
			{
				_abortText = "You have been killed.";
			};

			// Abort if vehicle is no longer local, otherwise commands won't do anything
			_checkCondition = {!local _vehicle};
			if (call _checkCondition) exitWith
			{
				_pauseText = "Take back control of the vehicle.";
				_abortText = "Another player took control of the vehicle.";
			};

			// Abort if vehicle is destroyed
			_checkCondition = {!alive _vehicle};
			if (call _checkCondition) exitWith
			{
				_abortText = "The vehicle has been destroyed.";
			};

			/*// Abort if no resupply vehicle in proximity
			_checkCondition = {{alive _x && {_x getVariable ["A3W_AmmoTruck", false]}} count (_vehicle nearEntities ["AllVehicles", RESUPPLY_TRUCK_DISTANCE]) == 0};
			if (call _checkCondition) exitWith
			{
				_pauseText = "Move closer to a resupply vehicle.";
				_abortText = "Too far from resupply vehicle.";
			};*/

			// Abort if player gets out of vehicle
			_checkCondition = {vehicle _unit != _vehicle};
			if (!_isUAV && !_isStaticWep && _checkCondition) exitWith
			{
				_pauseText = "Get back in the vehicle.";
				_abortText = "You are not in the vehicle.";
			};

			// Abort if someone gets in the gunner seat
			_checkCondition = {alive gunner _vehicle};
			if (!_isUAV && _checkCondition) exitWith
			{
				_pauseText = "The gunner seat must be empty.";
				_abortText = "Someone is in the gunner seat.";
			};
		};

		if (_pauseText != "") then
		{
			private "_i";

			for [{_i = RESUPPLY_TIMEOUT}, {_i > 0 && _checkCondition && !doCancelAction}, {_i = _i - 1}] do
			{
				_vehicle setVariable ["A3W_AmmoTruckTimeout", true];
				titleText [format ["%1\n%2", _pauseText, format ["Resupply sequence timeout in %1", _i]], "PLAIN DOWN", 0.5];
				sleep 1;
			};

			_vehicle setVariable ["A3W_AmmoTruckTimeout", nil];

			if !(call _checkCondition) then
			{
				_abortText = "";
				titleText ["", "PLAIN DOWN", 0.5];
			};

			if (doCancelAction) then
			{
				_abortText = "Cancelled by player.";
			};
		};

		if (_abortText != "") then
		{
			titleText [format ["%1\n%2", _abortText, "Resupply sequence aborted"], "PLAIN DOWN", 0.5];
			breakTo "AmmoTruckThread";
		};
	};


	// Check if player has enough money
	_checkPlayerMoney =
	{
		if (player getVariable ["cmoney",0] < _price) then
		{
			_text = format ["%1\n%2", format ["Not enough money, you need $%1 to resupply %2", _price, _vehName], "Resupply sequence aborted"];
			[_text, 10] call mf_notify_client;
			breakTo "AmmoTruckThread";
		};
	};

	call
	{
		if (_isStaticWep) then
		{
			_text = format ["%1\n%2", "Resupply sequence started", "Please get out of the static weapon."];
			titleText [_text, "PLAIN DOWN", 0.5];
			sleep 10;

			call _checkAbortConditions;
		};

		call _checkPlayerMoney;
		call _checkAbortConditions;

		_vehicle setVariable ["A3W_truckResupplyEngineEH", _vehicle addEventHandler ["Engine",
		{
			params ["_vehicle", "_started"];

			(_vehicle getVariable "A3W_truckResupplyThread") params [["_resupplyThread", scriptNull, [scriptNull]]];

			if (_started && !scriptDone _resupplyThread && !(_vehicle getVariable ["A3W_AmmoTruckTimeout", false])) then
			{
				_vehicle engineOn false;
			};
		}]];

		_vehicle engineOn false;

		if (player getVariable ["cmoney",0] >= _price) then
		{
			_msg = format ["%1<br/><br/>%2", format ["It will cost you $%1 to resupply %2.", _price, _vehName], "Do you want to proceed?"];

			if !([_msg, "Resupply Vehicle", true, true] call BIS_fnc_guiMessage) then
			{
				breakTo "AmmoTruckThread";
			};

		};

		call _checkAbortConditions;
		call _checkPlayerMoney;

		//start resupply here
		player setVariable ["cmoney", (player getVariable ["cmoney",0]) - _price, true];
		_text = format ["%1\n%2", format ["You paid $%1 to resupply %2.", _price, _vehName], "Please stand by..."];
		[_text, 10] call mf_notify_client;
		[] spawn fn_savePlayerData;

		call _checkAbortConditions;


		_text = format ["Reloading %1...", [_vehName]];
		sleep (REARM_TIME_SLICE / 2);
		_vehicle setvehicleammo 1;
		sleep (REARM_TIME_SLICE / 2);
		_checkDone = true;

		(getAllHitPointsDamage _vehicle) params ["_hitPoints", "_selections", "_dmgValues"];
		_repairSlice = if (count _hitPoints > 0) then { REPAIR_TIME_SLICE min (10 / (count _hitPoints)) } else { 0 }; // no longer than 10 seconds

		{

			if (_dmgValues select _forEachIndex > 0.001) then
			{
				if (_checkDone) then
				{
					_checkDone = false;
					sleep 3;
				};

				call _checkAbortConditions;

				"Repairing..." call _titleText;
				sleep (_repairSlice / 2);
				call _checkAbortConditions;

				if (_x != "") then
				{
					_vehicle setHitpointDamage [_x, 0];
				}
				else
				{
					_selName = _selections select _forEachIndex;

					if (_selName != "") then
					{
						_vehicle setHit [_selName, 0];
					};
				};

				sleep (_repairSlice / 2);
				_repaired = true;
			};
		} forEach _hitPoints;

		if (damage _vehicle > 0.001) then
		{
			call _checkAbortConditions;

			"Repairing..." call _titleText;
			sleep 1;

			call _checkAbortConditions;
			_vehicle setDamage 0;
			_repaired = true;
		};

		_checkDone = true;

		if (fuel _vehicle < 0.999 && !_isStaticWep) then
		{
			while {fuel _vehicle < 0.999} do
			{
				if (_checkDone) then
				{
					_checkDone = false;
					sleep 3;
				};

				call _checkAbortConditions;

				"Refueling..." call _titleText;
				sleep (REFUEL_TIME_SLICE / 2);
				call _checkAbortConditions;

				_vehicle setFuel ((fuel _vehicle) + 0.1);
				 sleep (REFUEL_TIME_SLICE / 2);
			};
		};

		titleText ["Your vehicle is ready.", "PLAIN DOWN", 0.5];
	};
};

_vehicle setVariable ["A3W_truckResupplyThread", _resupplyThread];


// Secondary thread for cleanup in case of error in resupply thread
[_vehicle, _resupplyThread] spawn
{
	params ["_vehicle", "_resupplyThread"];

	waitUntil {scriptDone _resupplyThread};

	_ehID = _vehicle getVariable ["A3W_truckResupplyEngineEH", -1];

	if (_ehID isEqualType 0) then
	{
		_vehicle removeEventHandler ["Engine", _ehID];
	};

	_vehicle setVariable ["A3W_truckResupplyEngineEH", nil];
	mutexScriptInProgress = false;
};
