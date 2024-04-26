extends Node
class_name GameController

const INITIAL_COMBATANTS = 3

@onready var _state_machine: GameStateMachine = %StateMachine
@onready var _random_battle: RandomBattle = %RandomBattle

var player_team: Team
var _current_menu: Node
var _current_battle_screen: Node

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
	
func display_battle_screen(battle: BattleScreenController) -> void:
	if _current_battle_screen:
		hide_current_battle_screen()
	_current_battle_screen = battle
	add_child(_current_battle_screen)
	
func hide_current_menu() -> void:
	if not _current_menu:
		return
	_current_menu.queue_free()
	_current_menu = null
	
func hide_current_battle_screen() -> void:
	_current_battle_screen.queue_free()
	_current_battle_screen = null

func start_random_battle() -> void:
	_random_battle.start()
	
func stop_random_battle() -> void:
	_random_battle.stop()

func set_player_team(player_team: Team) -> void:
	self.player_team = player_team
	for i in range(INITIAL_COMBATANTS):
		var combatant_type = GameGlobals.get_combatants_templates_data().get_random_type()
		var weapon = GameGlobals.get_weapons_data().get_random_weapon()
		var combatant = GameGlobals.get_combatants_templates_data().create_random_combatant(
			player_team,
			combatant_type,
			null,
			weapon.model,
		)
		player_team.add_combatant(combatant)
