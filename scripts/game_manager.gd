extends Node

@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var collision_shape_2d: CollisionShape2D = $"../Area2D/CollisionShape2D"

var camera_pos_y_increment = 650.0
var player_next_stage = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("he entrado en el area")
	if body.name == "Player":
		if player_next_stage:
			camera_2d.global_position.y += camera_pos_y_increment
			player_next_stage = false
		else:
			camera_2d.global_position.y -= camera_pos_y_increment
			player_next_stage = true
		
		
		
