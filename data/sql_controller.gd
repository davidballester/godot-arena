extends Node
class_name SQLController

const DB_PATH = "res://data/data.db"

var _database: SQLite

func _init() -> void:
	_database = SQLite.new()
	_database.path = DB_PATH
	_database.open_db()
