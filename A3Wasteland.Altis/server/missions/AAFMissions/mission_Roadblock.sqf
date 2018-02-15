// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Roadblock.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "AAFMissionDefines.sqf";

private [ "_box1", "_barGate", "_bunker1","_bunker2","_obj1","_obj2"];

_setupVars =
{
	_missionType = "AAF Roadblock";
	_locationsArray = RoadblockMissionmarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;

	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete;

	_bargate = createVehicle ["Land_BarGate_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	_bunker1 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj1 = createVehicle ["I_GMG_01_high_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj1 setVariable ["moveable", true, true];
	_bunker1 setDir _markerDir;
	_bunker2 = createVehicle ["Land_BagBunker_Small_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["I_GMG_01_high_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	_obj2 setVariable ["moveable", true, true];
	_bunker2 setDir _markerDir;

		// NPC Randomizer
	_aiGroup  = createGroup CIVILIAN;
	for "_i" from 1 to 7 do
	{
		private _soldierType = selectrandom ["Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","Rifleman","AT","AA","SAW","SAW","SAW","Engineer","Medic","Grenedier","Engineer","Medic","Grenedier","Marksman","Marksman","Marksman"];
		switch (_soldierType) do
		{
			case "Rifleman": {[_aiGroup, _missionPos] call createAAFRegularRifleman};
			case "AT": {[_aiGroup, _missionPos] call createAAFRegularAT};
			case "AA": {[_aiGroup, _missionPos] call createAAFRegularAA};
			case "SAW": {[_aiGroup, _missionPos] call createAAFRegularSAW};
			case "Engineer": {[_aiGroup, _missionPos] call createAAFRegularEngineer};
			case "Medic": {[_aiGroup, _missionPos] call createAAFRegularMedic};
			case "Grenedier": {[_aiGroup, _missionPos] call createAAFRegularGrenedier};
			case "Marksman": {[_aiGroup, _missionPos] call createAAFRegularMarksman};
		};
		_aiGroup setCombatMode "RED";
	_missionHintText = format ["Enemies have set up an illegal roadblock and are searching vehicles! They need to be stopped!", AAFMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed

	{ deleteVehicle _x } forEach [_barGate, _bunker1, _bunker2, _obj1, _obj2];

};

_successExec =
{
	// Mission completed
	_randomBox = selectrandom ["mission_USLaunchers","mission_USSpecial","mission_snipers","Ammo_Drop","mission_RPG","mission_PCML", "mission_Pistols", "mission_AssRifles", "mission_SMGs", "Medical"];
	_randomCase = selectrandom ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F","Box_NATO_Wps_F","Box_East_WpsSpecial_F","Box_IND_WpsSpecial_F"];
	_box1 = createVehicle [_randomCase, _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	_box1 setVariable ["moveable", true, true];
	[_box1, _randomBox] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", false, true]} forEach [_box1];
	{_x setVariable ["Moveable", true, true]} forEach [_barGate, _bunker1, _bunker2];
	{ _x setVariable ["allowDamage", true, true]} forEach [_obj1, _obj2];
	_successHintMessage = format ["The roadblock has been dismantled."];
};
_this call AAFMissionProcessor;
