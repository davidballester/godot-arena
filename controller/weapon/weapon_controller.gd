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
	
func attack() -> void:
	await view.attack()

func face(pos: Vector2) -> void:
	view.face_position(pos)
	
func turn() -> void:
	view.position.x *= -1
	view.scale.y *= -1
