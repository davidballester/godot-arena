extends DamageAppliedModificationTrait
class_name Weakling

func get_trait_name() -> String:
	return "Weakling"
	
func get_incompatibilities() -> Array:
	return ["Herculean"]
	
func get_description() -> String:
	return "Cutting cheese with a sharp knife is a struggle."
	
func modify_damage_applied(damage: int) -> int:
	return max(0, damage - 1)
