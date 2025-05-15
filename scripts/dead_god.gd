extends AnimatedSprite2D

@export var move_distance := 100
@export var move_time := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_movement()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_movement():
	var tween = create_tween()
	tween.set_loops()
	
	tween.tween_property(self, "position:y", position.y + move_distance, move_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y - move_distance, move_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

#TODO
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pass
