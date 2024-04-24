extends Node
class_name MainMenuInitialView

signal new_game_clicked()

@onready var _quit_game_button: BaseButton = %QuitGameButton
@onready var _new_game_button: BaseButton = %NewGameButton

func _ready() -> void:
	_quit_game_button.pressed.connect(_on_quit_clicked)
	_new_game_button.pressed.connect(_on_new_game_clicked)
	
func _on_quit_clicked() -> void:
	get_tree().quit()

func _on_new_game_clicked() -> void:
	new_game_clicked.emit()
