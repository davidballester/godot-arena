extends Node
class_name StateMachine

signal state_changed(State)

var id: String = ""
var class_to_state: Dictionary = {}
var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_machine = self
			class_to_state[child.get_state_name()] = child
			
func _process(delta: float) -> void:
	if not current_state:
		return
	current_state.process(delta)
			
func _physics_process(delta: float) -> void:
	if not current_state:
		return
	current_state.physics_process(delta)

func transition_to_state(state_name: String, args: Array = []) -> void:
	print("StateMachine[" + id + "].transition_to_state " + state_name + " " + str(args))
	var state = class_to_state.get(state_name)
	if current_state:
		current_state.exit()
	current_state = state
	current_state.enter(args)
	state_changed.emit(current_state)
