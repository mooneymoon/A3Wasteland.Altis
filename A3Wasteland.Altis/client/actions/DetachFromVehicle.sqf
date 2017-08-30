/*
Author: BIB_Monkey
FileName: DetachFromVehicle.sqf
Purpose: Detach Static Objects from attached Vehicle
*/

//Setup Variables
_vehicle = cursorTarget;  
_attached = attachedObjects _vehicle;
_vehLocation = getPosATL _vehicle

{
	if (_x getVariable ["Towed", false]) then {} else
	{
		detach _x;
		_detachpos = [_vehLocation,5,15,3,1,0,0];
		_x setPosATL _detachpos;
		{_x setVariable ["Attached", false, true]} foreach _attached;
		_vehicle setVariable ["Attached", false, true];
	};
} foreach _attached;

