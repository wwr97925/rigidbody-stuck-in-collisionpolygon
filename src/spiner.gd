@tool
extends Node2D
@export var refresh: bool = false:
	set(_value):
		_changed()

enum DIRECTION {CLOCKWISE, COUNTERCLOCKWISE}
@export var direction: DIRECTION
@export var period: float = 4.0
@export var adds_scene: PackedScene
@export var adds_number: int = 4

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
	for child in get_children():
		child.queue_free()

	for i in range(adds_number):
		var adds: Node = adds_scene.instantiate()
		_set_adds(adds)
		var rotate_degree: float = 360.0/adds_number
		adds.rotation = deg_to_rad(rotate_degree * i)
		call_deferred('add_child', adds)
	
	var TW = create_tween().set_loops()
	TW.tween_property(self, 'rotation',
	2*PI if direction == DIRECTION.CLOCKWISE else -2*PI, period).from(0.0)


func _set_adds(adds: Node) -> void:
	adds.width = width
	adds.height = height
	adds.col = col
	pass
