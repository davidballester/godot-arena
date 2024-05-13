extends Node
class_name CombatantsTemplatesData

var _database: SQLite
var _type_to_ids: Dictionary
var _combatants_names_data: CombatantsNamesData

func _init(
	database: SQLite,
	combatants_names_data: CombatantsNamesData
) -> void:
	_database = database
	_combatants_names_data = combatants_names_data
	var query_result = _database.select_rows("combatants_types", "", ["type", "id"])
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
	weapon: Weapon,
	create_traits: bool = true
) -> Combatant:
	var type_id = _type_to_ids.get(type)
	var type_record = _database.select_rows(
		"combatants_types", 
		"id = %s" % type_id, 
		[
			"speed",
			"min_health",
			"max_health",
			"min_price",
			"max_price",
			"min_traits",
			"max_traits"
		]
	)[0]
	var sprites_records = _database.select_rows(
		"combatants_sprites",
		"type = %s" % type_id,
		[
			"animated_sprite",
			"dust_animated_sprite"
		]
	)
	var sprite_record = sprites_records.pick_random()
	var brain = StockBrain.new()
	var perception = CombatantStockPerceptionComponent.new()
	var max_health = randi_range(type_record.min_health, type_record.max_health)
	var health = Gauge.create(0, max_health)
	var price = randi_range(type_record.min_price, type_record.max_price)
	var id = _combatants_names_data.get_random_name(type)
	var animated_sprite = load(sprite_record.animated_sprite)
	var dust_animated_sprite = load(sprite_record.dust_animated_sprite)
	var traits_count = randi_range(type_record.min_traits, type_record.max_traits + 1)
	var traits = GameGlobals.get_traits_data().get_random_traits(traits_count) if create_traits else []
	return Combatant.new(
		id,
		type,
		battle,
		team.id,
		type_record.speed,
		weapon,
		brain,
		perception,
		health,
		price,
		animated_sprite,
		dust_animated_sprite,
		traits
	)
