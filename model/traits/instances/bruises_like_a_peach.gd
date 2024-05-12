extends DamageTakenModificationTrait
class_name BruisesLikeAPeach

func get_trait_name() -> String:
	return "Bruises like a peach"
	
func get_incompatibilities() -> Array:
	return ["Thick skinned"]
	
func get_description() -> String:
	return "The slightest wound is a matter of life or death"
	
func modify_damage_taken(damage: int) -> int:
	return max(0, damage + 1)
