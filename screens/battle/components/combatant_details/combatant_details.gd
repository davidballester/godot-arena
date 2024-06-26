extends Control
class_name BattleScreenCombatantDetails

@export var flip_h: bool = false
@export var show_actions: bool = true

@onready var _combatant_name: Label = %CombatantName
@onready var _combatant_sprite: AnimatedSprite2D = %CombatantSprite
@onready var _weapon_sprite: AnimatedSprite2D = %WeaponSprite
@onready var _close_button: StyledButton = %CloseButton
@onready var _health_bar: ProgressBar = %HealthBar
@onready var _health_label: Label = %HealthLabel
@onready var _actions_container: Control = %ActionsContainer
@onready var _heal_button: PriceButton = %HealButton
@onready var _revive_button: PriceButton = %ReviveButton
@onready var _traits: TraitsView = %Traits

var _combatant: Combatant

func _ready() -> void:
	_close_button.pressed.connect(hide)
	_combatant_sprite.flip_h = flip_h
	_weapon_sprite.flip_h = flip_h
	if flip_h:
		# Magic!
		_combatant_sprite.offset.x = 20
		_weapon_sprite.offset.x = 10
	_heal_button.initialize(
		PriceButton.Type.BUY, 
		Prices.battle_screen_heal_cost
	)
	_heal_button.pressed.connect(func():
		_combatant.health.current_value = _combatant.health.max_value
	)
	_revive_button.pressed.connect(func():
		_combatant.health.current_value = _combatant.health.max_value
	)
	_actions_container.visible = show_actions

func initialize(combatant: Combatant) -> void:
	if _combatant:
		_combatant.state_machine.state_changed.disconnect(_update_animation_based_on_state)
	_combatant = combatant
	_combatant_name.text = combatant.id
	_combatant_sprite.sprite_frames = combatant.sprite_frames
	if combatant.is_alive():
		_combatant_sprite.speed_scale = 1.0
		_update_animation_based_on_state(combatant.state_machine.current_state)
	else:
		_combatant_sprite.speed_scale = 0
		_combatant_sprite.play("death", -1.0, true)
	_weapon_sprite.sprite_frames = combatant.weapon.sprite_frames
	combatant.state_machine.state_changed.connect(_update_animation_based_on_state)
	%TypeDd.text = combatant.type.capitalize()
	%TypeDd.add_theme_color_override("font_color", ColorsData.get_color(combatant.type))
	%WeaponDd.text = combatant.weapon.weapon_name.capitalize()
	%WeaponDd.add_theme_color_override(
		"font_color", 
		ColorsData.get_color(combatant.weapon.weapon_name)
	)
	%DamageDd.text =  "{min}-{max}".format({
		"min": str(combatant.weapon.damage.min_value),
		"max": str(combatant.weapon.damage.max_value)
	})
	_revive_button.initialize(
		PriceButton.Type.BUY, 
		floor(_combatant.price * Prices.battle_screen_revive_multiplier)
	)
	_traits.initialize(combatant.traits)
	
func _process(_delta: float) -> void:
	if not _combatant:
		_heal_button.enabled = false
		_revive_button.enabled = false
		return
	_heal_button.enabled = _combatant.is_alive() and _combatant.health.get_ratio() < 1.0
	_revive_button.enabled = not _combatant.is_alive()
	_health_bar.max_value = _combatant.health.max_value
	_health_bar.min_value = _combatant.health.min_value
	_health_bar.value = _combatant.health.current_value
	_health_label.text = "{current} / {max}".format({
		"current": str(_combatant.health.current_value),
		"max": str(_combatant.health.max_value)
	})

func _update_animation_based_on_state(state: CombatantState) -> void:
	if state is CombatantSeekEnemyState:
		_combatant_sprite.play("run")
		return
	if state is CombatantDeadState:
		_combatant_sprite.play("death")
		return
	if state is CombatantHitState:
		_combatant_sprite.play("hit")
		await _combatant_sprite.animation_finished
	_combatant_sprite.play("idle")
