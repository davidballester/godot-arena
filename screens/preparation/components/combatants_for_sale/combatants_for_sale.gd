extends Control
class_name PreparationScreenCombatantsForSale

signal combatant_bought(Combatant)

const COMBATANTS_COUNT = 3
const COMBATANT_FOR_SALE_SCENE = preload(
	"res://screens/preparation/components/combatant_for_sale/combatant_for_sale.tscn"
)

@onready var _combatants_container: Control = %CombatantsContainer
@onready var _renew_combatants: PreparationScreenRenewCombatantsForSale = %RenewCombatantsForSale

var _combatants_bought: int = 0

func _ready() -> void:
	_renew_combatants.renewed_clicked.connect(_reset_roster)

func initialize() -> void:
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
		GameGlobals.player_team,
		combatant_type,
		GameGlobals.battle,
		weapon
	)
	var combatant_for_sale: PreparationScreenCombatantForSale = COMBATANT_FOR_SALE_SCENE.instantiate()
	_combatants_container.add_child(combatant_for_sale)
	_combatants_container.move_child(combatant_for_sale, 0)
	combatant_for_sale.initialize(combatant)
	combatant_for_sale.bought.connect(func(): 
		combatant_bought.emit(combatant)
		_combatants_bought += 1
		if _combatants_bought == COMBATANTS_COUNT:
			_reset_roster()
	)

func _reset_roster() -> void:
	_combatants_bought = 0
	_remove_combatants_for_sale()
	_add_combatants_for_sale()
