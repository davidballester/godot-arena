extends Node
class_name State

var state_machine: StateMachine

# virtual
static func get_state_name() -> String:
	return ""

# virtual
func enter(_args: Array) -> void:
	pass
	
# virtual
func exit() -> void:
	pass

# virtual
func process(_delta: float) -> void:
	pass
