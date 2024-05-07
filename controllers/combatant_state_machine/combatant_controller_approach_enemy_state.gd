extends CombatantControllerState
class_name CombatantControllerApproachEnemyState

@export var navigation_agent: NavigationAgent2D
@export var approach_timer: Timer

var _combatant: Combatant

static func get_state_name() -> String:
	return "CombatantControllerApproachEnemyState"

func enter(args: Array) -> void:
	controller.view.start_running()
	var combatant_id = args[0]
	_combatant = controller.model.battle.get_combatant(combatant_id)
	approach_timer.timeout.connect(func(): _approach(_combatant))
	_approach(_combatant)
	
func process(_delta: float) -> void:
	controller.face(_combatant.global_position)
	
func exit() -> void:
	controller.view.stop_running()
	SignalUtils.disconnect_everything(approach_timer.timeout)
	
func physics_process(_delta: float) -> void:
	await get_tree().physics_frame
	var next_path_position = navigation_agent.get_next_path_position()
	var direction = controller.global_position.direction_to(next_path_position)
	controller.velocity = direction * controller.model.speed
	controller.move_and_slide()
	
func _approach(node: Node2D) -> void:
	navigation_agent.target_position = node.global_position
	
