extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start_sound: AudioStreamPlayer = $StartSound

var already_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("accept") and not already_started:
		start_sound.play()
		animation_player.play("fade_out")
		already_started = true
	
	if Input.is_action_pressed("cancel"):
		get_tree().quit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://scenes/intro.tscn")
