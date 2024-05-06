extends Control
class_name BattleScreenTeamPanel

signal combatant_selected(Combatant)

@onready var _team_icon: TextureRect = %TeamIcon
@onready var _team_name: Label = %TeamName
@onready var _close_button: StyledButton = %CloseButton
@onready var _combatants_container: Control = %CombatantsContainer
@onready var _combatant_thumbnail_template: BattleScreenCombatantThumbnail = %CombatantThumbnailTemplate

func initialize(team: Team) -> void:
	_combatants_container.remove_child(_combatant_thumbnail_template)
	_team_name.text = team.team_name
	_team_icon.texture = team.icon
	_close_button.pressed.connect(hide)
	team.combatants.map(add_combatant)
	
func add_combatant(combatant: Combatant) -> void:
	var combatant_thumbnail: BattleScreenCombatantThumbnail = _combatant_thumbnail_template.duplicate()
	combatant_thumbnail.ready.connect(func():
		combatant_thumbnail.initialize(combatant)
		combatant_thumbnail.selected.connect(func(): combatant_selected.emit(combatant))
	)
	_combatants_container.add_child(combatant_thumbnail)
