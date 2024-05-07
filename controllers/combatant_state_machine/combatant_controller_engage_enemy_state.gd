extends CombatantControllerState
class_name CombatantControllerEngageEnemyState

static func get_state_name() -> String:
	return "CombatantControllerEngageEnemyState"
	
const MOVING_CHANCE = 0.1
const MIN_MOVING_TIME_S = 0.1
const MAX_MOVING_TIME_S = 0.3
	
var _combatant: Combatant
var _navigator: OrbitNavigator = null

func enter(args: Array) -> void:
	_combatant = args[0]
	_attack_loop()
	
func exit() -> void:
	_combatant = null
	controller.view.stop_running()
	
func process(_delta: float) -> void:
	if not _combatant:
		return
	controller.face(_combatant.global_position)
	
func physics_process(delta: float) -> void:
	if not _navigator or not _combatant:
		return
	_navigator.physics_process(delta)
	
func _attack_loop() -> void:
	while _combatant:
		await controller.attack(_combatant)
		if not _navigator and _combatant and randf() < MOVING_CHANCE:
			_move()
			
func _move() -> void:
	_navigator = OrbitNavigator.new(
		controller,
		controller.model.weapon.reach,
		controller.model.speed,
		_combatant.global_position
	)
	var orbit_time = randf_range(MIN_MOVING_TIME_S, MAX_MOVING_TIME_S)
	await get_tree().create_timer(orbit_time).timeout
	_navigator = null
