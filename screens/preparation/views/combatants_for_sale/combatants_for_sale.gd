extends Control
class_name PreparationScreenCombatantsForSale

const COMBATANTS_COUNT = 3
const COMBATANT_FOR_SALE_SCENE = preload(
	"res://screens/preparation/views/combatant_for_sale/combatant_for_sale.tscn"
)

@onready var _combatants_container: Control = %CombatantsContainer

var _team: Team

func initialize(team: Team) -> void:
	_team = team
	for i in range(COMBATANTS_COUNT):
		_add_combatant_for_sale()
		
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
