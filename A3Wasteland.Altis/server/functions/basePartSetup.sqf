// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: basePartSetup.sqf
//	@file Author: AgentRev, BIB_Monkey

if (!isServer) exitWith {};

private "_obj";
_obj = _this select 0;
_obj setVariable [call vChecksum, true];

//Make base objects much harder to kill
if (_obj isKindOf "Static") then
{
_obj addEventHandler ["HandleDamage", {0.00001}];
_obj addEventHandler ["Hit", {_obj setDamage 0.0001}];
};