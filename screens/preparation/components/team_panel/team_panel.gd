extends Control
class_name PreparationScreenTeamPanel

signal combatant_selected(Combatant)

@onready var _team_name: PreparationScreenTeamName = %TeamName
@onready var _combatants_container: Control = %CombatantsContainer
@onready var _combatant_thumbnail_template: PreparationScreenCombatantThumbnail = %CombatantThumbnail
@onready var _scroll_container: ScrollContainer = %ScrollContainer
var _selected_combatant: PreparationScreenCombatantThumbnail

func _ready() -> void:
	_combatants_container.remove_child(_combatant_thumbnail_template)
	var max_scroll_length: int = 0
	var scrollbar = _scroll_container.get_v_scroll_bar()
	scrollbar.changed.connect(func():
		if max_scroll_length == scrollbar.max_value: 
			return
		max_scroll_length = scrollbar.max_value 
		_scroll_container.scroll_vertical = max_scroll_length
	)

func initialize(team: Team) -> void:
	_team_name.initialize(team)
	_team_name.team_changed.connect(func(team_name, team_icon):
		team.team_name = team_name
		team.icon = team_icon
	)
	team.combatants.map(func(combatant): add_combatant(combatant, false))
	_select_first_combatant()
	
func add_combatant(combatant: Combatant, select: bool = true) -> void:
	var combatant_thumbnail: PreparationScreenCombatantThumbnail = _combatant_thumbnail_template.duplicate()
	combatant_thumbnail.ready.connect(func():
		combatant_thumbnail.initialize(combatant)
		if select: 
			_select_combatant_thumbnail(combatant, combatant_thumbnail)
	)
	_combatants_container.add_child(combatant_thumbnail)
	combatant_thumbnail.pressed.connect(func(): 
		_select_combatant_thumbnail(combatant, combatant_thumbnail)
	)
	
func remove_combatant(combatant: Combatant) -> void:
	for combatant_thumbnail in _combatants_container.get_children():
		if not combatant_thumbnail is PreparationScreenCombatantThumbnail:
			continue
		if combatant_thumbnail.combatant != combatant:
			continue
		combatant_thumbnail.queue_free()
		break
	if _selected_combatant.combatant == combatant:
		await get_tree().process_frame
		_selected_combatant = null
		_select_first_combatant()

func _select_combatant_thumbnail(
	combatant: Combatant,
	combatant_thumbnail: PreparationScreenCombatantThumbnail
) -> void:	
	if _selected_combatant:
		_selected_combatant.set_selected(false)
	combatant_selected.emit(combatant)
	combatant_thumbnail.set_selected(true)
	_selected_combatant = combatant_thumbnail

func _select_first_combatant() -> void:
	var first_thumbnail = _combatants_container.get_children().filter(
		func(node): return node is PreparationScreenCombatantThumbnail
	)[0]
	_select_combatant_thumbnail(
		first_thumbnail.combatant, 
		first_thumbnail
	)
