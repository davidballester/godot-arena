extends DamageTakenModificationTrait
class_name ThickSkinned

func get_trait_name() -> String:
	return "Thick skinned"
	
func get_incompatibilities() -> Array:
	return ["Bruises like a peach"]
	
func get_description() -> String:
	return "Words and smacks do not hurt much an oblivious mind."
	
func modify_damage_taken(damage: int) -> int:
	return max(0, damage - 1)
