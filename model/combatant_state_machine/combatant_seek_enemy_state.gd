extends CombatantState
class_name CombatantSeekEnemyState

static func get_state_name() -> String:
	return "CombatantSeekEnemyState"
	
func process(_delta: float) -> void:
	var last_oponent_id = datastore.last_oponent_id
	datastore.last_oponent_id = ""
	if last_oponent_id != "" and _should_fight_oponent(last_oponent_id):
		state_machine.transition_to_state(
			CombatantApproachEnemyState.get_state_name(), 
			[last_oponent_id]
		)
		return
	_choose_new_oponent()

func _choose_new_oponent() -> void:
	var oponents: Array = datastore.battle.get_oponents(datastore.combatant_id)
	if oponents.is_empty():
		state_machine.transition_to_state(CombatantVictoryState.get_state_name())
		return
	var perceived_oponents = oponents.map(func(o: Combatant):
		return datastore.perception_component.perceive_combatant(o)
	)
	var perceived_oponents_typed: Array[PerceivedCombatant] = []
	perceived_oponents_typed.assign(perceived_oponents)
	var combatant = datastore.battle.get_combatant(datastore.combatant_id)
	var perceived_combatant = datastore.perception_component.perceive_combatant(combatant)
	var chosen_oponent = datastore.brain.choose_oponent(
		perceived_combatant, 
		perceived_oponents_typed
	)
	if chosen_oponent:
		state_machine.transition_to_state(
			CombatantApproachEnemyState.get_state_name(), 
			[chosen_oponent.id]
		)
	elif oponents.size():
		state_machine.transition_to_state(CombatantEscapeState.get_state_name())
	else:
		state_machine.transition_to_state(CombatantVictoryState.get_state_name())

func _should_fight_oponent(oponent_id: String) -> bool:
	var combatant = datastore.battle.get_combatant(datastore.combatant_id)
	var last_oponent = datastore.battle.get_combatant(oponent_id)
	if not last_oponent or not last_oponent.is_alive() or not combatant.can_attack(last_oponent.global_position):
		return false
	var perceived_last_oponent = datastore.perception_component.perceive_combatant(last_oponent)
	return datastore.brain.should_keep_fighting(perceived_last_oponent)
