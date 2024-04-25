extends Node
class_name GameGlobals

const VIEWPORT_WIDTH: float = 960
const VIEWPORT_HEIGHT: float = 540

static var _database: SQLite
static var _weapons_data: WeaponsData
static var _combatants_names_data: CombatantsNamesData
static var _combatants_templates_data: CombatantsTemplatesData
static var _teams_data: TeamsData

static func exit() -> void:
	_database.close_db()

static func get_weapons_data() -> WeaponsData:
	if not _weapons_data:
		_initialize()
	return _weapons_data

static func get_combatants_names_data() -> CombatantsNamesData:
	if not _combatants_names_data:
		_initialize()
	return _combatants_names_data

static func get_combatants_templates_data() -> CombatantsTemplatesData:
	if not _combatants_templates_data:
		_initialize()
	return _combatants_templates_data

static func get_teams_data() -> TeamsData:
	if not _teams_data:
		_initialize()
	return _teams_data

static func _initialize() -> void:
	_database = SQLController.get_database()
	_database.open_db()
	_weapons_data = WeaponsData.new(_database)
	_combatants_names_data = CombatantsNamesData.new(_database)
	_combatants_templates_data = CombatantsTemplatesData.new(
		_database,
		_combatants_names_data,
	)
	_teams_data = TeamsData.new(_database)