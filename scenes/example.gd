extends Node2D
class_name Example

@onready var battle: BattleController = %BattleController

func _ready() -> void:
	battle.initialize()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn_bone_beater"):
		_add_bone_beater()
	if Input.is_action_just_pressed("spawn_black_swan"):
		_add_black_swan()

func _on_add_bone_beater_pressed() -> void:
	_add_bone_beater()
	
func _on_add_black_swan_pressed() -> void:
	_add_black_swan()
	
func _add_bone_beater() -> void:
	var combatant = battle.add_combatant("Bone Beaters")
	var x = 25
	var y = randf_range(50, 150) + 50
	combatant.position = Vector2(x, y)
	
func _add_black_swan() -> void:
	var combatant = battle.add_combatant("Black Swans")
	var x = 468
	var y = randf_range(50, 150) + 50
	combatant.position = Vector2(x, y)
