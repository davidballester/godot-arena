extends Node
class_name GameController

const INITIAL_COMBATANTS = 3

@onready var _state_machine: GameStateMachine = %StateMachine
@onready var _random_battle: RandomBattle = %RandomBattle

var _current_screen: Node

func _ready() -> void:
	_state_machine.id = "Game"
	_state_machine.initialize()
	start_random_battle()
			
func _exit_tree() -> void:
	GameGlobals.exit()

func display_screen(screen: Node) -> void:
	if _current_screen:
		hide_current_screen()
	_current_screen = screen
	add_child(screen)

func hide_current_screen() -> void:
	if not _current_screen:
		return
	_current_screen.queue_free()
	_current_screen = null

func start_random_battle() -> void:
	_random_battle.start()
	
func stop_random_battle() -> void:
	_random_battle.queue_free()
	
func start_new_game() -> void:
	GameGlobals.battle = Battle.new()
	GameGlobals.player_team = _create_player_team()
	GameGlobals.enemy_team = _create_enemy_team()
	var terrain_path = GameGlobals.get_battles_data().get_random_terrain_path()
	var terrain = load(terrain_path).instantiate()
	GameGlobals.battle.terrain = terrain
	GameGlobals.battle.add_team(GameGlobals.player_team)
	GameGlobals.battle.add_team(GameGlobals.enemy_team)

func _create_player_team() -> Team:
	var team_name = GameGlobals.get_teams_data().get_random_team_name()
	var team_icon_path = GameGlobals.get_teams_data().get_random_icon_path()
	var team_icon = load(team_icon_path)
	var team = Team.new(
		"player_team",
		team_name,
		Color.from_string("#f77622", Color.DARK_RED),
		team_icon
	)
	for i in range(INITIAL_COMBATANTS):
		_add_random_combatant(team)
	return team

# TODO
func _create_enemy_team() -> Team:
	var team_name = GameGlobals.get_teams_data().get_random_team_name()
	GameGlobals.get_teams_data().mark_team_name_as_used(team_name)
	var team_icon_path = GameGlobals.get_teams_data().get_random_icon_path()
	GameGlobals.get_teams_data().mark_team_icon_path_as_used(team_icon_path)
	var team_icon = load(team_icon_path)
	var team = Team.new(
		team_name,
		team_name,
		Color.hex(0xff0044),
		team_icon
	)
	for i in range(7):
		_add_random_combatant(team)
	return team

func _add_random_combatant(team: Team) -> void:
	var combatant_type = GameGlobals.get_combatants_templates_data().get_random_type()
	var weapon = GameGlobals.get_weapons_data().get_random_weapon()
	var combatant = GameGlobals.get_combatants_templates_data().create_random_combatant(
		team,
		combatant_type,
		GameGlobals.battle,
		weapon,
	)
	team.add_combatant(combatant)
	GameGlobals.battle.add_combatant(combatant)
