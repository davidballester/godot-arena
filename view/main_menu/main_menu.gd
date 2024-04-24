extends CanvasLayer
class_name MainMenu

@onready var random_battle: RandomBattle = %RandomBattle

func start() -> void:
	random_battle.start()
	
func stop() -> void:
	random_battle.stop()
