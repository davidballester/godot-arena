extends Node
class_name BezierNavigator

signal navigation_finished()

var _node: Node2D
var _source_position: Vector2
var _target_position: Vector2
var _peak: Vector2
var _time: float = 0.0
var _time_factor: float

func _init(
	node: Node2D,
	target_position: Vector2,
	peak: Vector2,
	speed: float
) -> void:
	_node = node
	_source_position = _node.global_position
	_target_position = target_position
	_peak = peak
	var straight_length = _source_position.distance_to(_peak) + _peak.distance_to(target_position)
	_time_factor = straight_length * 0.6 / speed
	
func physics_process(delta: float) -> void:
	_time = min(1.0, _time + (delta * _time_factor))
	var q0 = _source_position.lerp(_peak, _time)
	var q1 = _peak.lerp(_target_position, _time)
	_node.global_position = q0.lerp(q1, _time)
	if _time >= 1:
		navigation_finished.emit()
