extends Node
class_name WeaponsData

const TABLE_NAME = "weapons"

var _database: SQLite
var _weapons_ids: Array

func _init(database: SQLite) -> void:
	_database = database
	var query_result = _database.select_rows(TABLE_NAME, "", ["id"])
	_weapons_ids = query_result.map(func(row): return row.id)
	
func get_random_weapon() -> WeaponController:
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
			"view_path",
			"animated_sprite_path"
		]
	)
	var weapon_name = query_result[0].name
	var min_damage = query_result[0].min_damage
	var max_damage = query_result[0].max_damage
	var attack_duration_s = query_result[0].attack_duration_s
	var reach = query_result[0].reach
	var damage = MinMax.create(min_damage, max_damage)
	var animated_sprite_path = query_result[0].animated_sprite_path
	var animated_sprite = load(animated_sprite_path)
	var weapon_model = Weapon.new(
		weapon_name, 
		damage, 
		attack_duration_s, 
		reach, 
		animated_sprite
	)
	var view_path = query_result[0].view_path
	var weapon_view: WeaponView = load(view_path).instantiate()
	weapon_view.animated_sprite = animated_sprite
	return WeaponController.new(weapon_model, weapon_view)
