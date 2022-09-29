@tool
extends CharacterBody2D

@export var refresh: bool = false:
	set(_value):
		_changed()

@export var width: float = 20.0
@export var height: float = 100.0
@export var col: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_changed()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _changed() -> void:
	var point0 = Vector2(-width / 2, 0)
	var point1 = Vector2(width / 2, 0)
	var point2 = Vector2(0, height)
	
	var points_array := PackedVector2Array()
	points_array.append(point0)
	points_array.append(point1)
	points_array.append(point2)
	points_array.append(point0)

	$CollisionPolygon2d.polygon = points_array
	$Polygon2d.polygon = points_array
	$Polygon2d.color = col
	pass
