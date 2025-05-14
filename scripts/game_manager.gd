extends Node

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var music_sound: AudioStreamPlayer = $"../MusicSound"

var in_second_zone = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animation_player.play("fade_in")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not in_second_zone:
		animation_player.play("intro_second_zone")
		in_second_zone = true
