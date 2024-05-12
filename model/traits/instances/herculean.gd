extends DamageAppliedModificationTrait
class_name Herculean

func get_trait_name() -> String:
	return "Herculean"
	
func get_incompatibilities() -> Array:
	return ["Weakling"]
	
func get_description() -> String:
	return "Arms so strong they can crack a coconut."
	
func modify_damage_applied(damage: int) -> int:
	return damage + 1
