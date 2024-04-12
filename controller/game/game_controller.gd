extends Node
class_name GameController

var _sql_controller: SQLController

func _ready() -> void:
	_sql_controller = SQLController.new()
