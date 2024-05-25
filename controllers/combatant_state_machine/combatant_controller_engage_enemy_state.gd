extends CombatantControllerState
class_name CombatantControllerEngageEnemyState

static func get_state_name() -> String:
	return "CombatantControllerEngageEnemyState"
	
const MOVING_CHANCE = 0.3
const MIN_MOVING_TIME_S = 0.1
const MAX_MOVING_TIME_S = 0.3

@export var navigation_agent: NavigationAgent2D
	
var _combatant: Combatant
var _moving: bool = false

func enter(args: Array) -> void:
	_combatant = args[0]
	_attack_loop()
	
func exit() -> void:
	_combatant = null
	state_machine.controller.view.stop_running()
	
func process(_delta: float) -> void:
	if not _combatant:
		return
	state_machine.controller.face(_combatant.global_position)
	
func physics_process(_delta: float) -> void:
	if not _moving:
		return
	await get_tree().physics_frame
	var next_path_position = navigation_agent.get_next_path_position()
	var direction = state_machine.controller.global_position.direction_to(next_path_position)
	state_machine.controller.velocity = direction * state_machine.controller.model.speed
	state_machine.controller.move_and_slide()
	_moving = not navigation_agent.is_target_reached()
	
func _attack_loop() -> void:
	while _combatant:
		await state_machine.controller.attack(_combatant)
		if not _moving and _combatant and randf() < MOVING_CHANCE:
			_move()
			
func _move() -> void:
	_moving = true
	var random_angle = randf_range(PI / 3, PI)
	if randf() < 0.5:
		random_angle *= -1
	var angle_to_oponent = state_machine.controller.global_position.angle_to_point(
		_combatant.global_position
	)
	var angle_away_from_oponent = angle_to_oponent + random_angle
	var magnitude = randi_range(5, 15)
	var point_in_that_direction = Vector2(
		state_machine.controller.global_position.x + magnitude * cos(angle_away_from_oponent),
		state_machine.controller.global_position.y + magnitude * sin(angle_away_from_oponent),
	)
	navigation_agent.target_position = point_in_that_direction
