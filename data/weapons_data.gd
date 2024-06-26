extends Node
class_name WeaponsData

const TABLE_NAME = "weapons"

var _database: SQLite
var _weapons_ids: Array

func _init(database: SQLite) -> void:
	_database = database
	var query_result = _database.select_rows(TABLE_NAME, "", ["id"])
	_weapons_ids = query_result.map(func(row): return row.id)
	
func get_random_weapon() -> Weapon:
	var id = _weapons_ids.pick_random()
	var query_result = _database.select_rows(
		TABLE_NAME, 
		"id = " + str(id), 
		[
			"name",
			"min_damage",
			"max_damage",
			"attack_duration_s",
			"reach",
			"speed",
			"effect_radius",
			"view_path",
			"animated_sprite_path"
		]
	)
	var weapon_name = query_result[0].name
	var min_damage = query_result[0].min_damage
	var max_damage = query_result[0].max_damage
	var attack_duration_s = query_result[0].attack_duration_s
	var reach = query_result[0].reach
	var speed = query_result[0].speed
	var effect_radius = query_result[0].effect_radius
	var damage = MinMax.create(min_damage, max_damage)
	var animated_sprite_path = query_result[0].animated_sprite_path
	var animated_sprite = load(animated_sprite_path)
	var view_path = query_result[0].view_path
	return Weapon.new(
		weapon_name, 
		damage, 
		attack_duration_s, 
		reach, 
		speed,
		effect_radius,
		animated_sprite,
		view_path
	)
