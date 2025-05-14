extends AnimatedSprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var corpse_sprite: AnimatedSprite2D = $"."
@onready var vanish_sound: AudioStreamPlayer2D = $VanishSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#vanish_sound.play()
		animation_player.stop()
		corpse_sprite.play("vanish")

func _on_animation_finished() -> void:
	queue_free()
