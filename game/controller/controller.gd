extends Node
class_name GameController

const INITIAL_COMBATANTS = 3

@onready var _state_machine: GameStateMachine = %StateMachine
@onready var _random_battle: RandomBattle = %RandomBattle

var player_team: Team
var enemy_team: Team
var _current_menu: Node

func _ready() -> void:
	_state_machine.id = "Game"
	_state_machine.initialize()
	start_random_battle()
			
func _exit_tree() -> void:
	GameGlobals.exit()

func display_menu(menu: Node) -> void:
	if _current_menu:
		hide_current_menu()
	_current_menu = menu
	add_child(_current_menu)

func hide_current_menu() -> void:
	if not _current_menu:
		return
	_current_menu.queue_free()
	_current_menu = null

func start_random_battle() -> void:
	_random_battle.start()
	
func stop_random_battle() -> void:
	_random_battle.stop()
	
func start_new_game() -> void:
	_create_enemy_team()
	_create_player_team()

func _create_player_team() -> void:
	var team_name = GameGlobals.get_teams_data().get_random_team_name()
	var team_icon_path = GameGlobals.get_teams_data().get_random_icon_path()
	var team_icon = load(team_icon_path)
	player_team = Team.new(
		"player_team",
		team_name,
		Color.from_string("#f77622", Color.DARK_RED),
		team_icon
	)
	for i in range(INITIAL_COMBATANTS):
		_add_random_combatant(player_team)

# TODO
func _create_enemy_team() -> void:
	var team_name = GameGlobals.get_teams_data().get_random_team_name()
	GameGlobals.get_teams_data().mark_team_name_as_used(team_name)
	var team_icon_path = GameGlobals.get_teams_data().get_random_icon_path()
	GameGlobals.get_teams_data().mark_team_icon_path_as_used(team_icon_path)
	var team_icon = load(team_icon_path)
	enemy_team = Team.new(
		team_name,
		team_name,
		Color.hex(0xff0044),
		team_icon
	)
	for i in range(7):
		_add_random_combatant(enemy_team)

func _add_random_combatant(team: Team) -> void:
		var combatant_type = GameGlobals.get_combatants_templates_data().get_random_type()
		var weapon = GameGlobals.get_weapons_data().get_random_weapon()
		var combatant = GameGlobals.get_combatants_templates_data().create_random_combatant(
			team,
			combatant_type,
			null,
			weapon.model,
		)
		team.add_combatant(combatant)
	
