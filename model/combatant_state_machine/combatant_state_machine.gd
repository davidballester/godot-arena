extends StateMachine
class_name CombatantStateMachine

var combatant: Combatant
var battle: Battle
var last_oponent: Combatant
var engaged_by_oponents: Dictionary

func _init(
	combatant: Combatant,
	battle: Battle
) -> void:
	self.combatant = combatant
	self.battle = battle

func engaged_by(oponent: Combatant) -> void:
	engaged_by_oponents[oponent.id] = oponent
	combatant.brain.react_to_being_engaged(get_engaged_by())
	
func no_longer_engaged_by(oponent: Combatant) -> void:
	engaged_by_oponents.erase(oponent.id)

func get_engaged_by() -> Array:
	return engaged_by_oponents.values()
