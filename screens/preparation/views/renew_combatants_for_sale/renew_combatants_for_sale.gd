extends Control
class_name PreparationScreenRenewCombatantsForSale

@onready var _animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

func _ready():
	_animated_sprite.play("idle")
