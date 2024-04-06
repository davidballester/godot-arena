extends CombatantControllerState
class_name CombatantControllerEngageEnemyState

static func get_state_name() -> String:
	return "CombatantControllerEngageEnemyState"
	
var combatant: Combatant

func enter(args: Array) -> void:
	combatant = args[0]
	_attack_loop()
	
func exit() -> void:
	combatant = null
	
func _attack_loop() -> void:
	while combatant:
		await controller.attack(combatant)
