extends Control
class_name BattleScreenCombatantForSale

signal combatant_bought(Combatant)

const APPEAR_EVERY_SECONDS = 10.0
const APPEAR_FOR_SECONDS = 5.0

@onready var _combatant_sprite_thumbnail: CombatantSpriteThumbnail = %CombatantSpriteThumbnail
@onready var _combatant_type: Label = %CombatantType
@onready var _buy_button: PriceButton = %BuyButton
@onready var _progress_bar: ProgressBar = %ProgressBar

var _combatant: Combatant

func _ready():
	_progress_bar.max_value = APPEAR_FOR_SECONDS
	_buy_button.pressed.connect(func():
		combatant_bought.emit(_combatant)
		_hide_with_timer()
	)
	_hide_with_timer()
	
func _initialize() -> void:
	var combatant_type = GameGlobals.get_combatants_templates_data().get_random_type()
	var weapon = GameGlobals.get_weapons_data().get_random_weapon()
	_combatant = GameGlobals.get_combatants_templates_data().create_random_combatant(
		GameGlobals.player_team,
		combatant_type,
		GameGlobals.battle,
		weapon
	)
	_combatant_sprite_thumbnail.initialize(_combatant, true)
	_combatant_type.text = combatant_type.capitalize()
	_buy_button.initialize(
		PriceButton.Type.BUY, 
		ceil(_combatant.price * Prices.battle_screen_combatant_for_sale_multiplier)
	)
	show()
	_progress_bar.value = APPEAR_FOR_SECONDS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not visible:
		return
	_progress_bar.value = max(0, _progress_bar.value - delta)
	if _progress_bar.value == 0:
		_hide_with_timer()
	
func _hide_with_timer() -> void:
	hide()
	get_tree().create_timer(APPEAR_EVERY_SECONDS).timeout.connect(_initialize)
