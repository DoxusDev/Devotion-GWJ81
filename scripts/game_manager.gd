extends Node

@onready var camera_2d: Camera2D = $"../Camera2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if body.name == "Player":  # o verifica con grupos
		var cam = get_viewport().get_camera_2d()
		if cam:
			cam.global_position = target_camera_position


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
