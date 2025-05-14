extends Node

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var music_first_zone: AudioStreamPlayer = $"../MusicFirstZone"
@onready var music_second_zone: AudioStreamPlayer = $"../MusicSecondZone"
@onready var music_third_zone: AudioStreamPlayer = $"../MusicThirdZone"

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
		animation_player.play("outro_first_zone")
		in_second_zone = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "outro_first_zone":
		music_first_zone.stop()
		music_second_zone.play()
		animation_player.play("intro_second_zone")
