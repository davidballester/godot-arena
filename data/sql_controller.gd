extends Node
class_name SQLController

const DB_PATH = "res://data/data.db"

static func get_database() -> SQLite:
	var database = SQLite.new()
	database.path = DB_PATH
	return database
