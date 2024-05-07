extends Node2D
class_name RandomBattle

const TEAMS = 3
const INITIAL_COMBATANTS = 20
const COMBATANTS_CAP = 80
const COMBATANT_CONTROLLER_SCENE = preload(
	"res://controllers/combatant/combatant_controller.tscn"
)

@onready var _combatant_spawn_timer: Timer = %CombatantSpawnTimer
@onready var _combatants_container: Node = %CombatantsContainer

var _team_index: int = 0
var _battle: Battle

func start() -> void:
	_battle = Battle.new()
	for i in range(0, TEAMS):
		var team = _create_team()
		_battle.add_team(team)
	for _i in range(0, INITIAL_COMBATANTS):
		_spawn_combatant_for_current_team()
	_combatant_spawn_timer.timeout.connect(_spawn_combatant_for_current_team)
	
func _spawn_combatant_for_current_team() -> void:
	if _count_alive_combatants() >= COMBATANTS_CAP:
		return
	var team: Team = _battle.teams[_team_index]
	var combatant_controller = _create_combatant_controller(team)
	_combatants_container.add_child(combatant_controller)
	team.add_combatant(combatant_controller.model)
	_battle.add_combatant(combatant_controller.model)
	combatant_controller.position = _get_current_team_spawn_position()
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

func _count_alive_combatants() -> int:
	return _battle.teams.reduce(
		func(alive_combatants: int, team: Team) -> int:
			var alive_combatants_in_team = team.combatants.filter(func(c: Combatant): c.is_alive()).size()
			return alive_combatants + alive_combatants_in_team,
		0
	)
	
func _create_combatant_controller(team: Team) -> CombatantController:
	var combatant_type = GameGlobals.get_combatants_templates_data().get_random_type()
	var weapon = GameGlobals.get_weapons_data().get_random_weapon()
	var combatant = GameGlobals.get_combatants_templates_data().create_random_combatant(
		team,
		combatant_type,
		_battle,
		weapon
	)
	var combatant_controller: CombatantController = COMBATANT_CONTROLLER_SCENE.instantiate()
	combatant_controller.ready.connect(func():
		combatant_controller.initialize(combatant, team, false)
	)
	return combatant_controller
