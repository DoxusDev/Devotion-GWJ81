extends AnimatableBody2D

@export var move_distance := 100
@export var move_time := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_movement():
	var tween = create_tween()
	
	tween.tween_property(self, "position:x", position.x + move_distance, move_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:x", position.x - move_distance, move_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.can_flag = false
		start_movement()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.can_flag = true
