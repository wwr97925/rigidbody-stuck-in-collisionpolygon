@tool
extends StaticBody2D

@export var refresh: bool = false:
	set(_value):
		_set_changed()

@export var outer_radius: float = 100.0
@export var width: float = 10.0
@export var inner_arc_points: int = 128
@export var outer_arc_points: int = 128
@export var degree: float = 90.0
@export var col: Color

var center := Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_changed() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rangef(start: float, end: float, step: float):
	var res = Array()
	var i = start
	while i < end:
		res.push_back(i)
		i += step
	return res

#創建PackedVector2Array, 紀錄弧上的每一點後return
func _create_arc_points_array(radius: float, points_number: int = 64) -> PackedVector2Array:
	var arc_points_array = PackedVector2Array()
	var per_step_degree: float = degree / points_number
	var p := Vector2()
	for t in rangef(0, degree + per_step_degree, per_step_degree):
		p.x = cos(deg_to_rad(t)) * radius
		p.y = sin(deg_to_rad(t)) * radius
		arc_points_array.append(center + p)
	return arc_points_array

#將內弧與外弧組合, 形成一個頭尾相同的PackedVector2Array後return
func _combine_arc_points_array(
	arc_points_array_1: PackedVector2Array,
	arc_points_array_2: PackedVector2Array) -> PackedVector2Array:
	arc_points_array_2.reverse()
	arc_points_array_1.append_array(arc_points_array_2)
	arc_points_array_1.append(arc_points_array_1[0])
	return arc_points_array_1

#用外弧長與弧寬建立一個首尾相同的PackedVector2Array, 即建立一個封閉空間, 用來當做polygon
func _create_arc(outer_arc_radius: float, width: float) ->PackedVector2Array:
	var inner_arc_radius: float = outer_arc_radius - width
	var inner_arc: PackedVector2Array = _create_arc_points_array(inner_arc_radius, inner_arc_points)
	var outer_arc: PackedVector2Array = _create_arc_points_array(outer_arc_radius, outer_arc_points)
	var combined_arc: PackedVector2Array = _combine_arc_points_array(inner_arc, outer_arc)
	return combined_arc

func _set_changed() -> void:
	var arc = _create_arc(outer_radius, width)
	$CollisionPolygon2d.polygon = arc
	$Polygon2d.polygon = arc
	$Polygon2d.color = col
	pass
