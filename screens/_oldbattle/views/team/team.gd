extends Control
class_name TeamView

const COMBATANT_THUMBNAIl_RESOURCE = preload(
	"res://screens/battle/views/combatant_thumbnail/combatant_thumbnail.tscn"
)

@onready var _team_label: TeamLabel = %TeamLabel
@onready var _combatants_container: Control = %CombatantsContainer
@onready var _combatant_details: PreparationCombatantDetails = %PreparationCombatantDetails

var _team: Team

func _ready() -> void:
	_combatant_details.hide()
	_combatant_details.closed.connect(func():
		_combatant_details.hide()
	)

func initialize(team: Team) -> void:
	_team = team
	_team_label.show_team(team)
	team.combatants.map(_add_combatant_thumbnail)

func _add_combatant_thumbnail(combatant: Combatant) -> void:
	var combatant_thumbnail = COMBATANT_THUMBNAIl_RESOURCE.instantiate()
	_combatants_container.add_child(combatant_thumbnail)
	combatant_thumbnail.initialize(combatant)
	combatant_thumbnail.pressed.connect(func():
		_show_combatant_details(combatant)
	)
	
func _show_combatant_details(combatant: Combatant) -> void:
	_combatant_details.show_details(combatant, _team)
	_combatant_details.show()
