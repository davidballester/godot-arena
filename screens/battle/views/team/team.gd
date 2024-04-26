extends Control
class_name TeamView

const COMBATANT_THUMBNAIl_RESOURCE = preload(
	"res://screens/battle/views/combatant_thumbnail/combatant_thumbnail.tscn"
)

@onready var _team_label: TeamLabel = %TeamLabel
@onready var _combatants_container: Control = %CombatantsContainer

var _team: Team

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
	print("TeamView._show_combatant_details ", combatant)
