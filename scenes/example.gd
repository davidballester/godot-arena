extends Node2D
class_name Example

@onready var battle: BattleController = %BattleController

func _ready() -> void:
	battle.initialize()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn_adventurer"):
		_add_aventurer()
	if Input.is_action_just_pressed("spawn_barbarian"):
		_add_barbarian()

func _on_add_aventurer_pressed() -> void:
	_add_aventurer()
	
func _on_add_barbarian_pressed() -> void:
	_add_barbarian()
	
func _add_aventurer() -> void:
	var combatant = battle.add_combatant("adventurers")
	var x = 25
	var y = randf_range(50, 150) + 50
	combatant.position = Vector2(x, y)
	
func _add_barbarian() -> void:
	var combatant = battle.add_combatant("barbarians")
	var x = 468
	var y = randf_range(50, 150) + 50
	combatant.position = Vector2(x, y)
