/**
 * MAIN CONFIGURATION FILE
 *
 * English and French comments
 * Commentaires anglais et français
 *
 * (EN)
 * This file contains the configuration variables of the logistics system.
 * For the configuration of the creation factory, see the file "config_creation_factory.sqf".
 * IMPORTANT NOTE : when a logistics feature is given to an object/vehicle class name, all the classes which inherit
 *                  of the parent/generic class (according to the CfgVehicles) will also have this feature.
 *                  CfgVehicles tree view example : http://madbull.arma.free.fr/A3_stable_1.20.124746_CfgVehicles_tree.html
 *
 * (FR)
 * Fichier contenant les variables de configuration du système de logistique.
 * Pour la configuration de l'usine de création, voir le fichier "config_creation_factory.sqf".
 * NOTE IMPORTANTE : lorsqu'une fonctionnalité logistique est accordée à un nom de classe d'objet/véhicule, les classes
 *                   héritant de cette classe mère/générique (selon le CfgVehicles) se verront également dotées de cette fonctionnalité.
 *                   Exemple d'arborescence du CfgVehicles : http://madbull.arma.free.fr/A3_stable_1.20.124746_CfgVehicles_tree.html
 */

/**
 * DISABLE LOGISTICS ON OBJECTS BY DEFAULT
 *
 * (EN)
 * Define if objects and vehicles have logistics features by default,
 * or if it must be allowed explicitely on specific objects/vehicles.
 *
 * If false : all objects are enabled according to the class names listed in this configuration file
 *            You can disable some objects with : object setVariable ["R3F_LOG_disabled", true];
 * If true :  all objects are disabled by default
 *            You can enable some objects with : object setVariable ["R3F_LOG_disabled", false];
 *
 *
 * (FR)
 * Défini si les objets et véhicules disposent des fonctionnalités logistiques par défaut,
 * ou si elles doivent être autorisés explicitement sur des objets/véhicules spécifiques.
 *
 * Si false : tous les objets sont actifs en accord avec les noms de classes listés dans ce fichier
 *            Vous pouvez désactiver certains objets avec : objet setVariable ["R3F_LOG_disabled", true];
 * Si true :  tous les objets sont inactifs par défaut
 *            Vous pouvez activer quelques objets avec : objet setVariable ["R3F_LOG_disabled", false];
 */
R3F_LOG_CFG_disabled_by_default = false;

/**
 * LOCK THE LOGISTICS FEATURES TO SIDE, FACTION OR PLAYER
 *
 * (EN)
 * Define the lock mode of the logistics features for an object.
 * An object can be locked to the a side, faction, a player (respawn) or a unit (life).
 * If the object is locked, the player can unlock it according to the
 * value of the config variable R3F_LOG_CFG_unlock_objects_timer.
 *
 * If "none" : no lock features, everyone can used the logistics features.
 * If "side" : the object is locked to the last side which interacts with it.
 * If "faction" : the object is locked to the last faction which interacts with it.
 * If "player" : the object is locked to the last player which interacts with it. The lock is transmitted after respawn.
 * If "unit" : the object is locked to the last player which interacts with it. The lock is lost when the unit dies.
 *
 * Note : for military objects (not civilian), the lock is initialized to the object's side.
 *
 * See also the config variable R3F_LOG_CFG_unlock_objects_timer.
 *
 * (FR)
 * Défini le mode de verrouillage des fonctionnalités logistics pour un objet donné.
 * Un objet peut être verrouillé pour une side, une faction, un joueur (respawn) ou une unité (vie).
 * Si l'objet est verrouillé, le joueur peut le déverrouiller en fonction de la
 * valeur de la variable de configiration R3F_LOG_CFG_unlock_objects_timer.
 *
 * Si "none" : pas de verrouillage, tout le monde peut utiliser les fonctionnalités logistiques.
 * Si "side" : l'objet est verrouillé pour la dernière side ayant interagit avec lui.
 * Si "faction" : l'objet est verrouillé pour la dernière faction ayant interagit avec lui.
 * Si "player" : l'objet est verrouillé pour le dernier joueur ayant interagit avec lui. Le verrou est transmis après respawn.
 * Si "unit" : l'objet est verrouillé pour le dernier joueur ayant interagit avec lui. Le verrou est perdu quand l'unité meurt.
 *
 * Note : pour les objets militaires (non civils), le verrou est initialisé à la side de l'objet.
 *
 * Voir aussi la variable de configiration R3F_LOG_CFG_unlock_objects_timer.
 */
R3F_LOG_CFG_lock_objects_mode = "none";

/**
 * COUNTDOWN TO UNLOCK AN OBJECT
 *
 * Define the countdown duration (in seconds) to unlock a locked object.
 * Set to -1 to deny the unlock of objects.
 * See also the config variable R3F_LOG_CFG_lock_objects_mode.
 *
 * Défini la durée (en secondes) du compte-à-rebours pour déverrouiller un objet.
 * Mettre à -1 pour qu'on ne puisse pas déverrouiller les objets.
 * Voir aussi la variable de configiration R3F_LOG_CFG_lock_objects_mode.
 */
R3F_LOG_CFG_unlock_objects_timer = 1;

/**
 * ALLOW NO GRAVITY OVER GROUND
 *
 * Define if movable objects with no gravity simulation can be set in height over the ground (no ground contact).
 * The no gravity objects corresponds to most of decoration and constructions items.
 *
 * Défini si les objets déplaçable sans simulation de gravité peuvent être position en hauteur sans être contact avec le sol.
 * Les objets sans gravité correspondent à la plupart des objets de décors et de construction.
 */
R3F_LOG_CFG_no_gravity_objects_can_be_set_in_height_over_ground = true;

/**
 * LANGUAGE
 *
 * Automatic language selection according to the game language.
 * New languages can be easily added (read below).
 *
 * Sélection automatique de la langue en fonction de la langue du jeu.
 * De nouveaux langages peuvent facilement être ajoutés (voir ci-dessous).
 */
R3F_LOG_CFG_language = switch (language) do
{
	case "English":{"en"};
	case "French":{"fr"};

	// Feel free to create you own language file named "XX_strings_lang.sqf", where "XX" is the language code.
	// Make a copy of an existing language file (e.g. en_strings_lang.sqf) and translate it.
	// Then add a line with this syntax : case "YOUR_GAME_LANGUAGE":{"LANGUAGE_CODE"};
	// For example :

	//case "Czech":{"cz"}; // Not supported. Need your own "cz_strings_lang.sqf"
	//case "Polish":{"pl"}; // Not supported. Need your own "pl_strings_lang.sqf"
	//case "Portuguese":{"pt"}; // Not supported. Need your own "pt_strings_lang.sqf"
	//case "YOUR_GAME_LANGUAGE":{"LANGUAGE_CODE"};  // Need your own "LANGUAGE_CODE_strings_lang.sqf"

	default {"en"}; // If language is not supported, use English
};

/**
 * CONDITION TO ALLOW LOGISTICS
 *
 * (EN)
 * This variable allow to set a dynamic SQF condition to allow/deny all logistics features only on specific clients.
 * The variable must be a STRING delimited by quotes and containing a valid SQF condition to evaluate during the game.
 * For example you can allow logistics only on few clients having a known game ID by setting the variable to :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Or based on the profile name : "profileName in [""john"", ""jack"", ""james""]"
 * Or only for the server admin : "serverCommandAvailable "#kick"""
 * The condition is evaluted in real time, so it can use condition depending on the mission progress : "alive officer && taskState task1 == ""Succeeded"""
 * Or to deny logistics in a circular area defined by a marker : "player distance getMarkerPos ""markerName"" > getMarkerSize ""markerName"" select 0"
 * Note that quotes of the strings inside the string condition must be doubled.
 * Note : if the condition depends of the aimed objects/vehicle, you can use the command cursorTarget
 * To allow the logistics to everyone, just set the condition to "true".
 *
 * (FR)
 * Cette variable permet d'utiliser une condition SQF dynamique pour autoriser ou non les fonctions logistiques sur des clients spécifiques.
 * La variable doit être une CHAINE de caractères délimitée par des guillemets et doit contenir une condition SQF valide qui sera évaluée durant la mission.
 * Par exemple pour autoriser la logistique sur seulement quelques joueurs ayant un ID de jeu connu, la variable peut être défini comme suit :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Ou elle peut se baser sur le nom de profil : "profileName in [""maxime"", ""martin"", ""marc""]"
 * Ou pour n'autoriser que l'admin de serveur : "serverCommandAvailable "#kick"""
 * Les condition sont évaluées en temps réel, et peuvent donc dépendre du déroulement de la mission : "alive officier && taskState tache1 == ""Succeeded"""
 * Ou pour interdire la logistique dans la zone défini par un marqueur circulaire : "player distance getMarkerPos ""markerName"" > getMarkerSize ""markerName"" select 0"
 * Notez que les guillemets des chaînes de caractères dans la chaîne de condition doivent être doublés.
 * Note : si la condition dépend de l'objet/véhicule pointé, vous pouvez utiliser la commande cursorTarget
 * Pour autoriser la logistique chez tout le monde, il suffit de définir la condition à "true".
 */
R3F_LOG_CFG_string_condition_allow_logistics_on_this_client = "true";

/**
 * CONDITION TO ALLOW CREATION FACTORY
 *
 * (EN)
 * This variable allow to set a dynamic SQF condition to allow/deny the access to the creation factory only on specific clients.
 * The variable must be a STRING delimited by quotes and containing a valid SQF condition to evaluate during the game.
 * For example you can allow the creation factory only on few clients having a known game ID by setting the variable to :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Or based on the profile name : "profileName in [""john"", ""jack"", ""james""]"
 * Or only for the server admin : "serverCommandAvailable "#kick"""
 * Note that quotes of the strings inside the string condition must be doubled.
 * Note : if the condition depends of the aimed objects/véhicule, you can use the command cursorTarget
 * Note also that the condition is evaluted in real time, so it can use condition depending on the mission progress :
 * "alive officer && taskState task1 == ""Succeeded"""
 * To allow the creation factory to everyone, just set the condition to "true".
 *
 * (FR)
 * Cette variable permet d'utiliser une condition SQF dynamique pour rendre accessible ou non l'usine de création sur des clients spécifiques.
 * La variable doit être une CHAINE de caractères délimitée par des guillemets et doit contenir une condition SQF valide qui sera évaluée durant la mission.
 * Par exemple pour autoriser l'usine de création sur seulement quelques joueurs ayant un ID de jeu connu, la variable peut être défini comme suit :
 * "getPlayerUID player in [""76xxxxxxxxxxxxxxx"", ""76yyyyyyyyyyyyyyy"", ""76zzzzzzzzzzzzzzz""]"
 * Ou elle peut se baser sur le nom de profil : "profileName in [""maxime"", ""martin"", ""marc""]"
 * Ou pour n'autoriser que l'admin de serveur : "serverCommandAvailable "#kick"""
 * Notez que les guillemets des chaînes de caractères dans la chaîne de condition doivent être doublés.
 * Note : si la condition dépend de l'objet/véhicule pointé, vous pouvez utiliser la commande cursorTarget
 * Notez aussi que les condition sont évaluées en temps réel, et peuvent donc dépendre du déroulement de la mission :
 * "alive officier && taskState tache1 == ""Succeeded"""
 * Pour autoriser l'usine de création chez tout le monde, il suffit de définir la condition à "true".
 */
R3F_LOG_CFG_string_condition_allow_creation_factory_on_this_client = "false";

/*
 ********************************************************************************************
 * BELOW IS THE CLASS NAMES CONFIGURATION / CI-DESSOUS LA CONFIGURATION DES NOMS DE CLASSES *
 ********************************************************************************************
 *
 * (EN)
 * There are two ways to manage new objects with the logistics system. The first one is to add these objects in the
 * following appropriate lists. The second one is to create a new external file in the /addons_config/ directory,
 * based on /addons_config/TEMPLATE.sqf, and to add a #include below to.
 * The first method is better to add/fix only some various class names.
 * The second method is better to take into account an additional addon.
 *
 * These variables are based on the inheritance principle according to the CfgVehicles tree.
 * It means that a features accorded to a class name, is also accorded to all child classes.
 * Inheritance tree view : http://madbull.arma.free.fr/A3_1.32_CfgVehicles_tree.html
 *
 * (FR)
 * Deux moyens existent pour gérer de nouveaux objets avec le système logistique. Le premier consiste à ajouter
 * ces objets dans les listes appropriées ci-dessous. Le deuxième est de créer un fichier externe dans le répertoire
 * /addons_config/ basé sur /addons_config/TEMPLATE.sqf, et d'ajouter un #include ci-dessous.
 * La première méthode est préférable lorsqu'il s'agit d'ajouter ou corriger quelques classes diverses.
 * La deuxième méthode est préférable s'il s'agit de prendre en compte le contenu d'un addon supplémentaire.
 *
 * Ces variables sont basées sur le principe d'héritage utilisés dans l'arborescence du CfgVehicles.
 * Cela signifie qu'une fonctionnalité accordée à une classe, le sera aussi pour toutes ses classes filles.
 * Vue de l'arborescence d'héritage : http://madbull.arma.free.fr/A3_1.32_CfgVehicles_tree.html
 */

/****** LIST OF ADDONS CONFIG TO INCLUDE / LISTE DES CONFIG D'ADDONS A INCLURE ******/
//#include "addons_config\A3_vanilla.sqf"
//#include "addons_config\All_in_Arma.sqf"
//#include "addons_config\R3F_addons.sqf"
//#include "addons_config\YOUR_ADDITIONAL_ADDON.sqf"

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of ground vehicles which can tow objects.
 * Liste des noms de classes des véhicules terrestres pouvant remorquer des objets.
 */
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
	// e.g. : "MyTowingVehicleClassName1", "MyTowingVehicleClassName2"
	"Offroad_01_base_F",
	"I_C_Offroad_02_unarmed_F",
	"C_Offroad_02_unarmed_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"O_T_LSV_02_unarmed_F",
	"O_T_LSV_02_armed_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"Wheeled_APC_F",
	"Tank",
	"Boat_Armed_01_base_F",
	"Ship_F"
];

/**
 * List of class names of objects which can be towed.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	// e.g. : "MyTowableObjectClassName1", "MyTowableObjectClassName2"
	"B_Heli_Attack_01_F",
	"Heli_Attack_02_base_F",
	"Heli_Light_01_base_F",
	"Heli_Light_02_base_F",
	"Heli_Transport_01_base_F",
	"Heli_Transport_02_base_F",
	"O_Heli_Transport_04_box_F",
	"O_Heli_Transport_04_fuel_F",
	"O_Heli_Transport_04_bench_F",
	"O_Heli_Transport_04_covered_F",
	"B_Heli_Transport_03_unarmed_F",
	"O_Heli_Transport_04_medevac_F",
	"O_Heli_Transport_04_repair_F",
	"B_Heli_Transport_03_F",
	"I_Heli_light_03_unarmed_F",
	"I_Heli_light_03_F",
	"Car_F",
	"B_APC_Tracked_01_AA_F",
	"B_APC_Tracked_01_rcws_F",
	"I_APC_tracked_03_cannon_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_TUSK_F",
	"O_MBT_02_cannon_F",
	"I_MBT_03_cannon_F",
	"B_MBT_01_arty_F",
	"B_MBT_01_mlrs_F",
	"B_Heli_Transport_03_F",
	"Ship_F",
	"Plane"
];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of helicopters which can lift objects.
 * Liste des noms de classes des hélicoptères pouvant héliporter des objets.
 */
R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
	// e.g. : "MyLifterVehicleClassName1", "MyLifterVehicleClassName2"
	];

/**
 * List of class names of objects which can be lifted.
 * Liste des noms de classes des objets héliportables.
 */
R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	// e.g. : "MyLiftableObjectClassName1", "MyLiftableObjectClassName2"
	];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
* (EN)
 * This section uses a numeric quantification of capacity and cost of the objets.
 * For example, in a vehicle has a capacity of 100, we will be able to load in 5 objects costing 20 capacity units.
 * The capacity doesn't represent a real volume or weight, but a choice made for gameplay.
 *
 * (FR)
 * Cette section utilise une quantification numérique de la capacité et du coût des objets.
 * Par exemple, dans un véhicule d'une capacité de 100, nous pouvons charger 5 objets coûtant 20 unités de capacité.
 * La capacité ne représente ni un poids, ni un volume, mais un choix fait pour la jouabilité.
 */

/**
 * List of class names of vehicles or cargo objects which can transport objects.
 * The second element of the nested arrays is the load capacity (in relation with the capacity cost of the objects).
 *
 * Liste des noms de classes des véhicules ou "objets contenant" pouvant transporter des objets.
 * Le deuxième élément des sous-tableaux est la capacité de chargement (en relation avec le coût de capacité des objets).
 */
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	// e.g. : ["MyTransporterClassName1", itsCapacity], ["MyTransporterClassName2", itsCapacity]
	["Quadbike_01_base_F", 5],
	["UGV_01_base_F", 10],
	["Hatchback_01_base_F", 10],
	["SUV_01_base_F", 20],
	["Offroad_01_base_F", 60],
	["Offroad_01_armed_base_F", 20],
	["Offroad_01_repair_base_F", 20],
	["I_C_Offroad_02_unarmed_F", 30],
	["C_Offroad_02_unarmed_F", 30],
	["B_T_LSV_01_unarmed_F", 40],
	["B_T_LSV_01_armed_F", 30],
	["O_T_LSV_02_unarmed_F", 40],
	["O_T_LSV_02_armed_F", 30],
	["B_T_UAV_03_F", 10],
	["Van_01_base_F", 70],
	["MRAP_01_base_F", 30],
	["MRAP_02_base_F", 30],
	["MRAP_03_base_F", 30],
	["Truck_01_base_F", 200],
	["B_Truck_01_ammo_F", 0],
	["B_Truck_01_Repair_F", 100],
	["B_Truck_01_fuel_F", 100],
	["Truck_02_base_F", 150],
	["I_Truck_02_ammo_F", 0],
	["O_Truck_02_Ammo_F", 0],
	["O_Truck_02_fuel_F", 70],
	["I_Truck_02_fuel_F", 70],
	["Truck_03_base_F", 175],
	["O_Truck_03_ammo_F", 0],
	["O_Truck_03_fuel_F", 100],
	["O_Truck_03_repair_F", 100],
	["Wheeled_APC_F", 40],
	["Tank_F", 15],
	["Rubber_duck_base_F", 10],
	["Boat_Civil_01_base_F", 10],
	["Boat_Armed_01_base_F", 20],
	["Heli_Light_01_base_F", 10],
	["Heli_Light_02_base_F", 20],
	["Heli_light_03_base_F", 20],
	["Heli_Transport_01_base_F", 25],
	["Heli_Transport_02_base_F", 200],
	["Heli_Transport_03_base_F", 250],
	["Heli_Transport_04_base_F", 175],
	["O_Heli_Transport_04_ammo_F", 0],
	["Heli_Attack_01_base_F", 0],
	["Heli_Attack_02_base_F", 50],
	["Land_Pod_Heli_Transport_04_box_F", 175],
	["B_Slingload_01_Cargo_F", 1000],
	["C_Plane_Civil_01_F", 10],
	["C_Plane_Civil_01_Racing_F", 10],
	["B_T_VTOL_01_infantry_F", 250],
	["B_T_VTOL_01_vehicle_F", 500],
	["B_T_VTOL_01_armed_F", 100],
	["O_T_VTOL_02_infantry_F", 50],
	["O_T_VTOL_02_vehicle_F", 100]
	
];

/**
 * List of class names of objects which can be loaded in transport vehicle/cargo.
 * The second element of the nested arrays is the cost capacity (in relation with the capacity of the vehicles).
 *
 * Liste des noms de classes des objets transportables.
 * Le deuxième élément des sous-tableaux est le coût de capacité (en relation avec la capacité des véhicules).
 */
R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	// e.g. : ["MyTransportableObjectClassName1", itsCost], ["MyTransportableObjectClassName2", itsCost]
	["Static_Designator_01_base_F", 2],
	["Static_Designator_02_base_F", 2],
	["Land_Canal_Wall_10m_F", 10], // Base door
	["Land_InfoStand_V2_F", 3], // Base door key	
	["Land_Device_assembled_F", 10], // Base Locker
	["StaticWeapon", 5],
	["Box_NATO_AmmoVeh_F", 10],
	["B_supplyCrate_F", 2],
	["Box_Ammo_F", 1],
	["EAST_Box_Base", 1],
	["FIA_Box_Base_F", 1],
	["IND_Box_Base", 1],
	["NATO_Box_Base", 1],
	["Kart_01_Base_F", 10],
	["Quadbike_01_base_F", 10],
	["Rubber_duck_base_F", 10],
	["SDV_01_base_F", 15],
	["C_Scooter_Transport_01_F", 15],
	["UAV_01_base_F", 2],
	["Land_BagBunker_Large_F", 10],
	["Land_BagBunker_Small_F", 5],
	["Land_BagBunker_Tower_F", 7],
	["Land_BagFence_Corner_F", 2],
	["Land_BagFence_End_F", 2],
	["Land_BagFence_Long_F", 3],
	["Land_BagFence_Round_F", 2],
	["Land_BagFence_Short_F", 2],
	["Land_BarGate_F", 3],
	["Land_Canal_WallSmall_10m_F", 4],
	["Land_Canal_Wall_Stairs_F", 3],
	["Land_CargoBox_V1_F", 5],
	["Land_Cargo_Patrol_V1_F", 7],
	["Land_Cargo_Tower_V1_F", 30],
	["Land_Cargo_HQ_V1_F", 30],
	["Land_CncBarrier_F", 4],
	["Land_CncBarrierMedium_F", 4],
	["Land_CncBarrierMedium4_F", 4],
	["Land_CncShelter_F", 2],
	["Land_CncWall1_F", 3],
	["Land_CncWall4_F", 5],
	["Land_Crash_barrier_F", 5],
	["Land_HBarrierBig_F", 5],
	["Land_HBarrierTower_F", 8],
	["Land_HBarrierWall4_F", 4],
	["Land_HBarrierWall6_F", 6],
	["Land_HBarrier_1_F", 3],
	["Land_HBarrier_3_F", 4],
	["Land_HBarrier_5_F", 5],
	["Land_LampHarbour_F", 2],
	["Land_LampShabby_F", 2],
	["Land_MetalBarrel_F", 2],
	["Land_Mil_ConcreteWall_F", 5],
	["Land_Mil_WallBig_4m_F", 5],
	["Land_Obstacle_Ramp_F", 5],
	["Land_Pipes_large_F", 5],
	["Land_RampConcreteHigh_F", 6],
	["Land_RampConcrete_F", 6],
	["Land_RampConcrete_F", 5],
	["BlockConcrete_F", 25],
	["Land_Razorwire_F", 5],
	["Land_Sacks_goods_F", 2],
	["Land_Scaffolding_F", 5],
	["Land_Shoot_House_Wall_F", 3],
	["Land_Stone_8m_F", 5],
	["Land_ToiletBox_F", 2],
	["Land_BarrelWater_F", 2],
	["Land_Pier_F", 150],
	["Land_FuelStation_Feed_F", 75],
	["UGV_01_base_F", 10],
	["Hatchback_01_base_F", 20],
	["SUV_01_base_F", 30],
	["Offroad_01_base_F", 50],
	["I_C_Offroad_02_unarmed_F", 40],
	["C_Offroad_02_unarmed_F", 40],
	["B_T_LSV_01_unarmed_F", 50],
	["B_T_LSV_01_armed_F", 50],
	["O_T_LSV_02_unarmed_F", 50],
	["O_T_LSV_02_armed_F", 50],
	["Van_01_base_F", 55],
	["MRAP_01_base_F", 70],
	["MRAP_02_base_F", 70],
	["MRAP_03_base_F", 70],
	["Truck_03_base_F", 175],
	["O_Truck_03_ammo_F", 400],
	["Truck_02_base_F", 150],
	["O_Truck_02_Ammo_F", 400],
	["I_Truck_02_ammo_F", 400],
	["Wheeled_APC_F", 100],
	["Tank_F", 250],
	["APC_Tracked_01_base_F", 200],
	["APC_Tracked_02_base_F", 200],
	["APC_Tracked_03_base_F", 200],
	["Rubber_duck_base_F", 10],
	["Boat_Civil_01_base_F", 50],
	["Boat_Armed_01_base_F", 60],
	["B_CargoNet_01_ammo_F", 4],
	["CargoNet_01_box_F", 2],
	["Land_MobilLandingPlatform_01_F", 50],
	["Land_PierLadder_F", 2],
	["ContainmentArea_1_sand_F", 10],
	["ContainmentAera_2_sand_F", 8],
	["Land_Laptop_unfolded_F", 1],
	["Land_Hangar_F", 100],
	["CamoNet_BLUFOR_big_F", 10],
	["CamoNet_INDP_big_F", 10],
	["CamoNet_OPFOR_big_F", 10],
	["ContainmentArea_01_sand_F", 10],
	["Land_Medevac_HQ_V1_F", 50],
	["Box_NATO_Uniforms_F", 2],
	["Box_CSAT_Uniforms_F", 2],
	["Box_AAF_Uniforms_F", 2],
	["Box_AAF_Equip_F", 2],
	["Box_CSAT_Equip_F", 2],
	["Box_NATO_Equip_F", 2],
	["Land_Shed_Big_F", 50],
	["Land_LightHouse_F", 100],
	["Land_Castle_01_tower_F", 75],
	["Land_i_Shed_Ind_F", 100],
	["Land_Cargo_House_V3_F", 75],
	["StorageBladder_01_fuel_sand_F", 150],
	["FlexibleTank_01_sand_F", 30],
	["ContainmentArea_02_sand_F", 10],
	["Box_Syndicate_Wps_F", 1],
	"Box_Syndicate_WpsLaunch_F", 1]
];

/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects which can be carried and moved by a player.
 * Liste des noms de classes des objets qui peuvent être portés et déplacés par le joueur.
 */
R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	// e.g. : "MyMovableObjectClassName1", "MyMovableObjectClassName2"
	"Static_Designator_01_base_F",
	"Static_Designator_02_base_F",
	"Land_Canal_Wall_10m_F", // Base door
	"Land_InfoStand_V2_F", // Base door key
	"Land_Device_assembled_F", //relocker
	"StaticWeapon",
	"ReammoBox_F",
	"Kart_01_Base_F",
	"Quadbike_01_base_F",
	"Rubber_duck_base_F",
	"SDV_01_base_F",
	"UAV_01_base_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"Land_BagFence_Corner_F",
	"Land_BagFence_End_F",
	"Land_BagFence_Long_F",
	"Land_BagFence_Round_F",
	"Land_BagFence_Short_F",
	"Land_BarGate_F",
	"Land_Canal_WallSmall_10m_F",
	"Land_Canal_Wall_Stairs_F",
	"Land_CargoBox_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_HQ_V1_F",
	"Land_CncBarrier_F",
	"Land_CncBarrierMedium_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncShelter_F",
	"Land_CncWall1_F",
	"Land_CncWall4_F",
	"Land_Crash_barrier_F",
	"Land_HBarrierBig_F",
	"Land_HBarrierTower_F",
	"Land_HBarrierWall4_F",
	"Land_HBarrierWall6_F",
	"Land_HBarrier_1_F",
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",
	"Land_LampHarbour_F",
	"Land_LampShabby_F",
	"Land_MetalBarrel_F",
	"Land_Mil_ConcreteWall_F",
	"Land_Mil_WallBig_4m_F",
	"Land_Obstacle_Ramp_F",
	"Land_Pipes_large_F",
	"Land_RampConcreteHigh_F",
	"Land_RampConcrete_F",
	"BlockConcrete_F",
	"Land_Razorwire_F",
	"Land_Sacks_goods_F",
	"Land_Scaffolding_F",
	"Land_Shoot_House_Wall_F",
	"Land_Stone_8m_F",
	"Land_ToiletBox_F",
	"Land_BarrelWater_F",
	"Land_HandyCam_F",
	"Land_Laptop_F",
	"Land_Pod_Heli_Transport_04_box_F",
	"Land_Pier_F",
	"Land_FuelStation_Feed_F",
	"Land_PierLadder_F",
	"Land_MobilLandingPlatform_01_F",
	"CargoNet_01_box_F",
	"B_CargoNet_01_ammo_F",
	"B_Slingload_01_Medevac_F",
	"B_Slingload_01_Repair_F",
	"B_Slingload_01_Fuel_F",
	"B_Slingload_01_Cargo_F",
	"Land_Hangar_F",
	"B_Slingload_01_Ammo_F",
	"Land_Laptop_unfolded_F",
	"ContainmentArea_01_sand_F",
	"ContainmentAera_02_sand_F",
	"Land_RampConcrete_F",
	"Land_Pier_Box_F",
	"CamoNet_BLUFOR_big_F",
	"CamoNet_INDP_big_F",
	"Land_Medevac_HQ_V1_F",
	"Land_Shed_Big_F",
	"Land_LightHouse_F",
	"Land_Castle_01_tower_F",
	"Land_i_Shed_Ind_F",
	"CamoNet_OPFOR_big_F",
	"Land_Cargo_House_V3_F",
	"B_Slingload_01_Ammo_F",
	"FlexibleTank_01_sand_F",
	"StorageBladder_01_fuel_sand_F",
	"Land_HBarrier_01_tower_green_F",
	"Land_BagBunker_01_small_green_F",
	"Land_BagBunker_01_large_green_F",
	"Land_HBarrier_01_line_1_green_F",
	"Land_HBarrier_01_line_3_green_F",
	"Land_HBarrier_01_line_5_green_F",
	"Land_HBarrier_01_wall_corridor_green_F",
	"Land_HBarrier_01_big_4_green_F",
	"Land_HBarrier_01_wall_4_green_F",
	"Land_HBarrier_01_wall_6_green_F",
	"Land_HBarrier_01_wall_corner_green_F",
	"Land_HBarrier_01_big_tower_green_F"
	
];
