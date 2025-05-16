extends Node

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var music_first_zone: AudioStreamPlayer = $"../MusicFirstZone"
@onready var music_second_zone: AudioStreamPlayer = $"../MusicSecondZone"
@onready var music_third_zone: AudioStreamPlayer = $"../MusicThirdZone"

var in_second_zone = false
var in_third_zone = false
var in_final_zone = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animation_player.play("fade_in")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_intro_second_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not in_second_zone:
		animation_player.play("outro_first_zone")
		in_second_zone = true

func _on_area_2d_intro_third_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not in_third_zone:
		animation_player.play("outro_second_zone")
		in_third_zone = true

func _on_area_2d_intro_final_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not in_final_zone:
		animation_player.play("outro_third_zone")
		in_third_zone = true

func _on_dead_god_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Engine.time_scale = 0.3
		animation_player.play("ending")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "outro_first_zone":
		music_first_zone.stop()
		music_second_zone.play()
		animation_player.play("intro_second_zone")
	
	if anim_name == "outro_second_zone":
		music_first_zone.stop()
		music_second_zone.stop()
		music_third_zone.play()
		animation_player.play("intro_third_zone")
	
	if anim_name == "outro_third_zone":
		music_first_zone.stop()
		music_second_zone.stop()
		music_third_zone.stop()
		animation_player.play("intro_final_zone")
	
	if anim_name == "ending":
		get_tree().change_scene_to_file("res://scenes/outro.tscn")
