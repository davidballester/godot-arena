extends CanvasLayer
class_name MainMenuController

signal new_game_started()

@onready var _new_game_button: StyledButton = %NewGameButton
@onready var _quit_game_button: StyledButton = %QuitGameButton

func _ready() -> void:
	_quit_game_button.pressed.connect(func():
		get_tree().quit()
	)
	_new_game_button.pressed.connect(func():
		new_game_started.emit()
	)
