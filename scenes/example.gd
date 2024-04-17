extends Node2D
class_name Example

@onready var battle: BattleController = %BattleController

func _ready() -> void:
	battle.initialize()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn_team_a"):
		_add_combatant_to_team_a()
	if Input.is_action_just_pressed("spawn_team_b"):
		_add_combatant_to_team_b()

func _on_add_combatant_to_team_a_pressed() -> void:
	_add_combatant_to_team_a()
	
func _on_add_combatant_to_team_b_pressed() -> void:
	_add_combatant_to_team_b()
	
func _add_combatant_to_team_a() -> void:
	var team_a_id = battle.get_teams_ids()[0]
	var combatant = battle.add_combatant(team_a_id)
	var x = -25
	var y = randf_range(50, 385)
	combatant.position = Vector2(x, y)
	
func _add_combatant_to_team_b() -> void:
	var team_b_id = battle.get_teams_ids()[1]
	var combatant = battle.add_combatant(team_b_id)
	var x = 720
	var y = randf_range(50, 385)
	combatant.position = Vector2(x, y)
