extends Node

@onready var camera_2d: Camera2D = $"../Camera2D"
var camera_pos_y_increment = 650.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("he entrado en el area")
	if body.name == "Player":
		camera_2d.global_position.y -= camera_pos_y_increment
