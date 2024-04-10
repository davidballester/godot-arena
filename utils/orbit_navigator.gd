extends Node
class_name OrbitNavigator

var _progress: float
var _radius: float
var _orbital_speed: float
var _center: Vector2
var _initial_angle: float
var _node: Node2D

func _init(
	node: Node2D,
	radius: float,
	speed: float,
	center: Vector2,
) -> void:
	_node = node
	_progress = 0.0
	_radius = radius
	_orbital_speed = (2 * PI * _radius) / (speed * 3)
	_center = center
	_initial_angle = - _node.global_position.angle_to_point(_center) - (PI / 2)
	
func physics_process(delta: float) -> void:
	_progress += delta 
	var angle = (_progress * _orbital_speed) + _initial_angle
	_node.global_position = Vector2(
		sin(angle) * _radius,
		cos(angle) * _radius
	) + _center
