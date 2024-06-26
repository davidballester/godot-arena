extends Node2D
class_name WeaponController

var model: Weapon
var view: WeaponView

func _init(model: Weapon, view: WeaponView) -> void:
	self.model = model
	self.view = view
	add_child(model)
	add_child(view)
	view.position.x = 6
	
func attack(attack: Attack) -> void:
	await view.attack(attack)

func turn() -> void:
	view.position.x *= -1
	view.scale.x *= -1
