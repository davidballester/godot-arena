extends Node2D
class_name Example

const COMBATANT_SPRITES = [
	"res://assets/combatant/fPlayer_ [dwarf].tres",
	"res://assets/combatant/fPlayer_ [elf].tres",
	"res://assets/combatant/fPlayer_ [human].tres",
	"res://assets/combatant/mPlayer_ [dwarf].tres",
	"res://assets/combatant/mPlayer_ [elf].tres",
	"res://assets/combatant/mPlayer_ [human].tres",
]

@onready var battle: BattleController = %BattleController

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn_adventurer"):
		_add_aventurer()
	if Input.is_action_just_pressed("spawn_barbarian"):
		_add_barbarian()

func _on_add_aventurer_pressed() -> void:
	_add_aventurer()
	
func _on_add_barbarian_pressed() -> void:
	_add_barbarian()
	
func _add_aventurer() -> void:
	var combatant = _create_combatant()
	battle.add_combatant("adventurers", combatant)
	var x = 25
	var y = randf_range(50, 150) + 50
	combatant.position = Vector2(x, y)
	
func _add_barbarian() -> void:
	var combatant = _create_combatant()
	battle.add_combatant("barbarians", combatant)
	var x = 468
	var y = randf_range(50, 150) + 50
	combatant.position = Vector2(x, y)
	
func _create_combatant() -> CombatantController:
	var combatant: CombatantController = load(
		"res://controller/combatant/combatant_controller.tscn"
	).instantiate()
	combatant.id = str(randi_range(1, 99999))
	var sprite_frames_path = COMBATANT_SPRITES.pick_random()
	combatant.sprite_frames = load(sprite_frames_path)
	return combatant
