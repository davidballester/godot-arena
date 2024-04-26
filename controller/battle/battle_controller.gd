extends Node
class_name BattleController

static var team_colors = [
	Color.from_string("#f77622", Color.DARK_RED),
	Color.from_string("#ff0044", Color.DARK_RED)
]

@onready var _hud: HUD = %HUD

@export var combatants_container: Node2D
@export var hud_enabled: bool = true

var _battle: Battle
var _id_to_team: Dictionary
var _id_to_combatant: Dictionary
	
func initialize() -> void:
	_battle = Battle.new()
	if not hud_enabled:
		_hud.queue_free()
		return
	var first_team_id = _id_to_team.keys()[0]
	var first_team = _id_to_team.get(first_team_id)
	var second_team_id = _id_to_team.keys()[1]
	var second_team = _id_to_team.get(second_team_id)
	_hud.initialize(first_team, second_team)
	
func add_team(team: Team) -> void:
	team.id = GameGlobals.get_teams_data().get_random_team_name()
	_id_to_team[team.id] = team
	var teams_count = _id_to_team.keys().size()
	team.color = team_colors[teams_count % team_colors.size()]
	var team_icon_path = GameGlobals.get_teams_data().get_random_icon_path()
	team.icon = load(team_icon_path)
	add_child(team)
	
func add_combatant(
	team_id: String,
) -> CombatantController:
	var team: Team = _id_to_team[team_id]
	var combatant_type = GameGlobals.get_combatants_templates_data().get_random_type()
	var weapon = GameGlobals.get_weapons_data().get_random_weapon()
	var combatant = await  GameGlobals.get_combatants_templates_data().create_random_combatant_controller(
		combatants_container,
		team,
		combatant_type,
		_battle,
		weapon,
		hud_enabled
	)
	_id_to_combatant[combatant.id] = combatant
	if hud_enabled:
		combatant.input_event.connect(func(_viewport, event, _shape_idx):
			if not event is InputEventMouseButton or not event.pressed:
				return
			_hud.show_combatant_details(combatant.model, team)
		)
	return combatant

func get_teams_ids() -> Array:
	return _id_to_team.keys()
	
func count_alive_combatants() -> int:
	return _id_to_combatant.values().filter(
			func(combatant: CombatantController): return combatant.model.is_alive()
	).size()
