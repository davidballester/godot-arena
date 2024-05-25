extends Node2D
class_name Test

@onready var _combatants_container: Node2D = %CombatantsContainer
@onready var _combatant_a_engage_button: Button = %CombatantAEngage
@onready var _combatant_a_click_to_attack_button: CheckButton = %CombatantAClickToAttack

var _battle: Battle
var _team_a: Team
var _combatant_a: CombatantController
var _team_b: Team
var _combatant_b: CombatantController

func _ready() -> void:
	_battle = Battle.new()
	_team_a = _create_team_a()
	_team_b = _create_team_b()
	_combatant_a = _create_combatant_a()
	_combatant_b = _create_combatant_b()
	_combatant_a_engage_button.pressed.connect(func():
		_combatant_a.model.state_machine.transition_to_state(
			CombatantEngageEnemyState.get_state_name(),
			[_combatant_b.model]
		)
	)
	
func _input(event: InputEvent) -> void:
	if not _combatant_a_click_to_attack_button.button_pressed:
		return
	if not event is InputEventMouseButton or not event.is_released():
		return
	_attack_position(
		_combatant_a, 
		event.position + Vector2(0, GameGlobals.COMBATANT_HEIGHT / 2)
	)

func _create_team_a() -> Team:
	return Team.new(
		str(randi()), 
		str(randi()), 
		Color.BLACK, 
		load("res://assets/teams_icons/Arrow.png")
	)
	
func _create_team_b() -> Team:
	return Team.new(
		str(randi()), 
		str(randi()), 
		Color.RED, 
		load("res://assets/teams_icons/Axe.png")
	)
	
func _create_combatant_a() -> CombatantController:
	var model = Combatant.new(
		"A",
		"dwarf",
		_battle,
		_team_a.id,
		20,
		_create_bow(),
		TestBrain.new(),
		Gauge.create(0, 10),
		1,
		load("res://assets/combatant/playerSprites_ [version 1.0]/fPlayer_ [dwarf].tres"),
		load("res://assets/combatant/playerSprites_ [version 1.0]/playerDust_.tres"),
		[]
	)
	var combatant: CombatantController = load("res://controllers/combatant/combatant_controller.tscn").instantiate()
	combatant.ready.connect(func():
		combatant.initialize(model, _team_a, true)
	)
	_combatants_container.add_child(combatant)
	_team_a.add_combatant(combatant.model)
	_battle.add_combatant(combatant.model)
	combatant.position = Vector2(250, 250)
	return combatant
	
func _create_combatant_b() -> CombatantController:
	var model = Combatant.new(
		"B",
		"elf",
		_battle,
		_team_b.id,
		20,
		_create_bow(),
		TestBrain.new(),
		Gauge.create(0, 10),
		1,
		load("res://assets/combatant/playerSprites_ [version 1.0]/fPlayer_ [elf].tres"),
		load("res://assets/combatant/playerSprites_ [version 1.0]/playerDust_.tres"),
		[]
	)
	var combatant: CombatantController = load("res://controllers/combatant/combatant_controller.tscn").instantiate()
	combatant.ready.connect(func():
		combatant.initialize(model, _team_a, true)
	)
	_combatants_container.add_child(combatant)
	_team_b.add_combatant(combatant.model)
	_battle.add_combatant(combatant.model)
	combatant.position = Vector2(350, 250)
	return combatant
	
func _create_bow() -> Weapon:
	return Weapon.new(
		"bow",
		MinMax.create(1, 2),
		1.5,
		150,
		200,
		4,
		load("res://assets/weapon/bow.tres"),
		"res://view/weapon/bow/bow_view.tscn"
	)

func _attack_position(combatant: CombatantController, pos: Vector2) -> void:
	var fake_combatant = Combatant.new(
		str(randi()),
		"",
		_battle,
		"",
		0,
		null,
		TestBrain.new(),
		Gauge.create(0, 10),
		1,
		null,
		null,
		[]
	)
	fake_combatant.global_position = pos
	_combatants_container.add_child(fake_combatant)
	_battle.add_combatant(fake_combatant)
	combatant.model.state_machine.transition_to_state(
		CombatantEngageEnemyState.get_state_name(),
		[fake_combatant]
	)
	await combatant.attack(fake_combatant)
	combatant.model.state_machine.transition_to_state(
		CombatantVictoryState.get_state_name()
	)
	_battle.remove_combatant(fake_combatant)
