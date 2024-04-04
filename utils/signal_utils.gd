extends Node
class_name SignalUtils

static func disconnect_everything(s: Signal) -> void:
	for connection in s.get_connections():
		s.disconnect(connection.callable)
