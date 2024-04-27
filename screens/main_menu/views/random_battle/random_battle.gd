extends Node2D
class_name RandomBattle

const TEAMS = 3
const INITIAL_COMBATANTS = 20
const COMBATANTS_CAP = 80

@onready var _battle: BattleController = %BattleController
@onready var _combatant_spawn_timer: Timer = %CombatantSpawnTimer

var _team_index: int = 0

func start() -> void:
	_battle.initialize()
	for i in range(0, TEAMS):
		var team = _create_team()
		_battle.add_team(team)
	for _i in range(0, INITIAL_COMBATANTS):
		await _spawn_combatant_for_current_team()
	_combatant_spawn_timer.timeout.connect(_spawn_combatant_for_current_team)
	
func stop() -> void:
	_combatant_spawn_timer.timeout.disconnect(_spawn_combatant_for_current_team)
	
func _spawn_combatant_for_current_team() -> void:
	if _battle.count_alive_combatants() >= COMBATANTS_CAP:
		return
	var team_id = _battle.get_teams_ids()[_team_index]
	var combatant = await _battle.add_combatant(team_id)
	combatant.position = _get_current_team_spawn_position()
	_team_index = (_team_index + 1) % TEAMS
	
func _create_team() -> Team:
	return Team.new(
		str(randi()), 
		str(randi()), 
		Color.BLACK, 
		load("res://assets/teams_icons/Arrow.png")
	)
	
func _get_current_team_spawn_position() -> Vector2:
	var random_x_wiggle = randf_range(
		-GameGlobals.VIEWPORT_WIDTH / 8,
		GameGlobals.VIEWPORT_WIDTH / 8
	)
	var random_y_wiggle = randf_range(
		-GameGlobals.VIEWPORT_HEIGHT / 8,
		GameGlobals.VIEWPORT_HEIGHT / 8
	)
	match _team_index:
		0: return Vector2(
			-20, 
			GameGlobals.VIEWPORT_HEIGHT / 2 + random_y_wiggle
		)
		1: return Vector2(
			GameGlobals.VIEWPORT_WIDTH + 20, 
			GameGlobals.VIEWPORT_HEIGHT / 2 + random_y_wiggle
		)
	return Vector2(
		GameGlobals.VIEWPORT_WIDTH / 2 + random_x_wiggle, 
		GameGlobals.VIEWPORT_HEIGHT + 20
	)
