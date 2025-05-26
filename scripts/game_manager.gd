extends Node

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var music_first_zone: AudioStreamPlayer = $"../MusicFirstZone"
@onready var music_second_zone: AudioStreamPlayer = $"../MusicSecondZone"
@onready var music_third_zone: AudioStreamPlayer = $"../MusicThirdZone"
@onready var distortion_sound: AudioStreamPlayer = $"../DistortionSound"
@onready var area_2d_intro_second_zone: Area2D = $"../Area2DIntroSecondZone"
@onready var area_2d_intro_third_zone: Area2D = $"../Area2DIntroThirdZone"
@onready var area_2d_intro_final_zone: Area2D = $"../Area2DIntroFinalZone"
@onready var area_2d_intro_final_zone_2: Area2D = $"../Area2DIntroFinalZone2"
@onready var left_arrow_key: Sprite2D = $"../MoveTutorial/LeftArrowKey"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animation_player.play("fade_in")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Global.get_player_controller():
		left_arrow_key.texture = preload("res://icon.svg")
	else:
		left_arrow_key.texture = preload("res://assets/UI/Keyboard Letters and Symbols.png")

func _on_area_2d_intro_second_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation_player.play("outro_first_zone")
		area_2d_intro_second_zone.set_deferred("monitoring", false)

func _on_area_2d_intro_third_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation_player.play("outro_second_zone")
		area_2d_intro_third_zone.set_deferred("monitoring", false)

func _on_area_2d_intro_final_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation_player.play("outro_third_zone")
		area_2d_intro_final_zone.set_deferred("monitoring", false)
		area_2d_intro_final_zone_2.set_deferred("monitoring", false)

func _on_dead_god_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Engine.time_scale = 0.3
		distortion_sound.play()
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
