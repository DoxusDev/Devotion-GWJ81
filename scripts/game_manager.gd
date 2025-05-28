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
@onready var down_arrow_key: Sprite2D = $"../PlatformDownTuto/DownArrowKey"
@onready var s_key: Sprite2D = $"../PlatformDownTuto/SKey"
@onready var down_joypad_btn: Sprite2D = $"../PlatformDownTuto/DownJoypadBtn"
@onready var platform_down_tuto: Node2D = $"../PlatformDownTuto"
@onready var move_tutorial: Node2D = $"../MoveTutorial"
@onready var jump_tuto: Node2D = $"../JumpTuto"
@onready var flag_tutorial: Node2D = $"../FlagTutorial"
@onready var teleport_flag_tutorial: Node2D = $"../TeleportFlagTutorial"
@onready var control_effects: AnimationPlayer = $"../ControlEffects"
@onready var controller_joystick: Sprite2D = $"../MoveTutorial/ControllerJoystick"
@onready var controller_direction_pad: Sprite2D = $"../MoveTutorial/ControllerDirectionPad"
@onready var direction_pad_up_btn: Sprite2D = $"../JumpTuto/DirectionPadUpBtn"
@onready var a_btn: Sprite2D = $"../JumpTuto/ABtn"
@onready var left_arrow_key: Sprite2D = $"../MoveTutorial/LeftArrowKey"
@onready var down_arrow_key_move: Sprite2D = $"../MoveTutorial/DownArrowKey"
@onready var right_arrow_key: Sprite2D = $"../MoveTutorial/RightArrowKey"
@onready var up_arrow_key: Sprite2D = $"../MoveTutorial/UpArrowKey"
@onready var up_arrow_key_jump: Sprite2D = $"../JumpTuto/UpArrowKey"
@onready var space_key: Sprite2D = $"../JumpTuto/SpaceKey"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animation_player.play("fade_in")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Global.get_player_controller():
		down_arrow_key.visible = false
		s_key.visible = false
		left_arrow_key.visible = false
		down_arrow_key_move.visible = false
		right_arrow_key.visible = false
		up_arrow_key.visible = false
		up_arrow_key_jump.visible = false
		space_key.visible = false
		
		controller_direction_pad.visible = true
		controller_joystick.visible = true
		down_joypad_btn.visible = true
		direction_pad_up_btn.visible = true
		a_btn.visible = true
	else:
		down_arrow_key.visible = true
		s_key.visible = true
		left_arrow_key.visible = true
		down_arrow_key_move.visible = true
		right_arrow_key.visible = true
		up_arrow_key.visible = true
		up_arrow_key_jump.visible = true
		space_key.visible = true
		
		controller_direction_pad.visible = false
		controller_joystick.visible = false
		down_joypad_btn.visible = false
		direction_pad_up_btn.visible = false
		a_btn.visible = false

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

func _on_area_2d_quit_tutorial_ui_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		control_effects.stop()
		platform_down_tuto.visible = false
		move_tutorial.visible = false
		jump_tuto.visible = false
		flag_tutorial.visible = false
		teleport_flag_tutorial.visible = false

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
