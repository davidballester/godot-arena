extends Control
class_name PreparationScreenEnemyTeam

@onready var _team_icon: TextureRect = %TeamIcon
@onready var _team_name: Label = %TeamName
@onready var _reveal_button: PriceButton = %RevealButton
@onready var _reveal_button_container: Control = %RevealButtonContainer
@onready var _combatants_container: Control = %CombatantsContainer
@onready var _combatant_type_template: Label = %CombatantTypeTemplate

func initialize(team: Team) -> void:
	_team_icon.texture = team.icon
	_team_name.text = team.team_name.capitalize()
	_reveal_button.initialize(2)
	_reveal_button.pressed.connect(func():
		_reveal_button_container.hide()
		_combatants_container.show()
	)
	var combatant_types_to_count: Dictionary = team.combatants.reduce(
		func(acc: Dictionary, combatant: Combatant) -> Dictionary:
			var combatant_type = combatant.type
			if not acc.has(combatant_type):
				acc[combatant_type] = 0
			acc[combatant_type] += 1
			return acc,
		{}
	)
	for combatant_type in combatant_types_to_count.keys():
		var combatant_count = combatant_types_to_count[combatant_type]
		var label = _combatant_type_template.duplicate()
		label.text = "{count} {type}{plural}".format({
			"count": str(combatant_count),
			"type": combatant_type.capitalize(),
			"plural": "s" if combatant_count > 1 else ""
		})
		_combatants_container.add_child(label)
	_combatant_type_template.hide()
