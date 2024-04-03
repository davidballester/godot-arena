extends CombatantState
class_name CombatantEscapeState

static func get_state_name() -> String:
	return "CombatantEscapeState"
	
const SEEK_AFTER_SECONDS: float = 5.0
	
var timer: SceneTreeTimer

func enter(_args: Array) -> void:
	timer = get_tree().create_timer(SEEK_AFTER_SECONDS)
	timer.timeout.connect(func():
		state_machine.transition_to_state(CombatantSeekEnemyState.get_state_name())
	)
	
func exit() -> void:
	timer.stop()
	timer.queue_free()

