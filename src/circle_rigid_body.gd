@tool
extends RigidBody2D
@export var refresh: bool = false:
	set(_value):
		_set_changed()

@export var radius: float = 3.0
@export var col: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_changed()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func draw_circle_custom(radius, maxerror = 0.25):
	if radius <= 0.0:
		return
	var maxpoints = 1024 # I think this is renderer limit

	var numpoints = ceil(PI / acos(1.0 - maxerror / radius))
	numpoints = clamp(numpoints, 3, maxpoints)

	var points = PackedVector2Array()

	for i in numpoints:
		var phi = i * PI * 2.0 / numpoints
		var v = Vector2(sin(phi), cos(phi))
		points.push_back(v * radius)

	draw_colored_polygon(points, col)
	
func _draw():
	pass
	draw_circle_custom(radius)

func _set_changed():
	$CollisionShape2d.shape.radius = radius
	set_mass(radius*radius)
	queue_redraw()
