extends Control
class_name PreparationScreenCombatantsForSale

const COMBATANTS_COUNT = 3
const COMBATANT_FOR_SALE_SCENE = preload(
	"res://screens/preparation/views/combatant_for_sale/combatant_for_sale.tscn"
)

@onready var _combatants_container: Control = %CombatantsContainer
@onready var _renew_combatants: PreparationScreenRenewCombatantsForSale = %RenewCombatantsForSale

var _team: Team

func _ready() -> void:
	_renew_combatants.renewed_clicked.connect(func():
		_remove_combatants_for_sale()
		_add_combatants_for_sale()
	)

func initialize(team: Team) -> void:
	_team = team
	_add_combatants_for_sale()
		
func _add_combatants_for_sale() -> void:
	for i in range(COMBATANTS_COUNT):
		_add_combatant_for_sale()
		
func _remove_combatants_for_sale() -> void:
	for child in _combatants_container.get_children():
		if not child is PreparationScreenCombatantForSale:
			continue
		child.queue_free()
		
func _add_combatant_for_sale() -> void:
	var combatant_type = GameGlobals.get_combatants_templates_data().get_random_type()
	var weapon = GameGlobals.get_weapons_data().get_random_weapon()
	var combatant = GameGlobals.get_combatants_templates_data().create_random_combatant(
		_team,
		combatant_type,
		null,
		weapon.model
	)
	var combatant_for_sale: PreparationScreenCombatantForSale = COMBATANT_FOR_SALE_SCENE.instantiate()
	_combatants_container.add_child(combatant_for_sale)
	_combatants_container.move_child(combatant_for_sale, 0)
	combatant_for_sale.initialize(combatant)
