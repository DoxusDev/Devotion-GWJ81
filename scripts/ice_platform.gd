extends AnimatableBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.friction = 80
		body.acceleration = 500
		body.speed = 230
		body.can_flag = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.friction = 2000
		body.acceleration = 2000
		body.speed = 300
		body.can_flag = true
