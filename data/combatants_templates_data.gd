extends Node
class_name CombatantsTemplatesData

const TABLE_NAME = "combatants_templates"
const CONTROLLER_RESOURCE = preload(
	"res://controller/combatant/combatant_controller.tscn"
)

var _database: SQLite
var _type_to_ids: Dictionary

func _init(database: SQLite) -> void:
	_database = database
	var query_result = _database.select_rows(TABLE_NAME, "", ["type", "id"])
	_type_to_ids = query_result.reduce(
		func(type_to_ids, row):
			if not type_to_ids.get(row.type):
				type_to_ids[row.type] = []
			type_to_ids[row.type].append(row.id)
			return type_to_ids,
		{}
	)
	
func get_random_type() -> String:
	var types = _type_to_ids.keys()
	return types.pick_random()
	
func create_random_combatant(
	team: Team,
	type: String, 
	battle: Battle,
	weapon: WeaponController
) -> CombatantController:
	var type_templates = _database.select_rows(
		TABLE_NAME, 
		"type = '%s'" % type, 
		[
			"animated_sprite_path",
			"dust_animated_sprite_path",
			"speed",
			"health"
		]
	)
	var type_template = type_templates.pick_random()
	var brain = StockBrain.new()
	var perception = CombatantStockPerceptionComponent.new()
	var health = Gauge.create(0, type_template.health)
	var combatant = Combatant.new(
		str(randi()),
		battle,
		team.id,
		type_template.speed,
		weapon.model,
		brain,
		perception,
		health
	)
	battle.add_combatant(combatant)
	var controller: CombatantController = CONTROLLER_RESOURCE.instantiate()
	var animated_sprite = load(type_template.animated_sprite_path)
	var dust_animated_sprite = load(type_template.dust_animated_sprite_path)
	team.add_child(controller)
	controller.initialize(combatant, weapon, animated_sprite, dust_animated_sprite)
	return controller
