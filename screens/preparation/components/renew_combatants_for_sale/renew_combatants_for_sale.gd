extends Control
class_name PreparationScreenRenewCombatantsForSale

signal renewed_clicked()

@onready var _animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var _renew_button: PriceButton = %RenewButton

func _ready():
	_animated_sprite.play("idle")
	_renew_button.initialize(
		PriceButton.Type.BUY, 
		Prices.preparation_screen_renew_roster_cost
	)
	_renew_button.pressed.connect(func(): renewed_clicked.emit())
