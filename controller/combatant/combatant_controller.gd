extends CharacterBody2D
class_name CombatantController

@export var id: String = "ignotus1234"
@export var team: Team
@export var speed: float = 40.0
@export var battle: Battle
@export var sprite_frames: SpriteFrames
@onready var view: CombatantView = %CombatantView
@onready var model: Combatant = %CombatantModel
@onready var navigation_agent: NavigationAgent2D = %NavigationAgent2D
@onready var approach_timer: Timer = %ApproachTimer

func _ready() -> void:
	view.sprite_frames = sprite_frames
	view.initialize()
	model.id = id
	model.team_id = team.id
	model.speed = speed
	model.battle = battle
	model.initialize()
	battle.add_combatant(model)
	model.state_machine.state_changed.connect(_on_state_changed)
	
func _physics_process(_delta: float) -> void:
	_navigate()

func _on_state_changed(state: State) -> void:
	if state is CombatantApproachEnemyState:
		view.start_running()
		var combatant = battle.get_combatant(state.combatant_id)
		approach_timer.timeout.connect(func(): _approach(combatant))
		_approach(combatant)
		return
	SignalUtils.disconnect_everything(approach_timer.timeout)
	view.stop_running()

func _navigate() -> void:
	if navigation_agent.is_navigation_finished():
		return
	await get_tree().physics_frame
	var next_path_position = navigation_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_position)
	velocity = direction * speed
	move_and_slide()
	
func _approach(node: Node2D) -> void:
	navigation_agent.target_position = node.global_position
