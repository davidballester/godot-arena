extends StateMachine
class_name CombatantStateMachine

var combatant: Combatant
var battle: Battle
var last_oponent: Combatant

func _init(
	combatant: Combatant,
	battle: Battle
) -> void:
	self.combatant = combatant
	self.battle = battle
