extends Object
class_name WeaponController

enum WeaponType {
	SWORD
}

static func load_weapon_model(type: WeaponType) -> Weapon:
	var weapon_node = Node.new()
	var script: Variant
	match type:
		WeaponType.SWORD:
			script = load("res://model/weapon/sword.gd")
	weapon_node.set_script(script)
	return weapon_node
	
static func load_weapon_view(type: WeaponType) -> WeaponView:
	var weapon_view_node: WeaponView
	match type:
		WeaponType.SWORD:
			weapon_view_node = load("res://view/weapon/sword/sword_view.tscn").instantiate()
	return weapon_view_node
