extends CombatantControllerState
class_name CombatantControllerApproachEnemyState

@export var navigation_agent: NavigationAgent2D
@export var approach_timer: Timer

var _combatant: Combatant

static func get_state_name() -> String:
	return "CombatantControllerApproachEnemyState"

func enter(args: Array) -> void:
	state_machine.controller.view.start_running()
	_combatant = args[0]
	approach_timer.timeout.connect(func(): _approach(_combatant))
	_approach(_combatant)
	
func process(_delta: float) -> void:
	state_machine.controller.face(_combatant.global_position)
	
func exit() -> void:
	state_machine.controller.view.stop_running()
	SignalUtils.disconnect_everything(approach_timer.timeout)
	
func physics_process(_delta: float) -> void:
	await get_tree().physics_frame
	var next_path_position = navigation_agent.get_next_path_position()
	var direction = state_machine.controller.global_position.direction_to(next_path_position)
	state_machine.controller.velocity = direction * state_machine.controller.model.speed
	state_machine.controller.move_and_slide()
	
func _approach(node: Node2D) -> void:
	navigation_agent.target_position = node.global_position
	
