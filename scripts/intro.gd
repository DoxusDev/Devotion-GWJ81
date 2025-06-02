extends Control

@onready var skip_key: Sprite2D = $SkipKey
@onready var skip_btn: Sprite2D = $SkipBtn
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	change_ui()
	
	if Input.is_action_pressed("pause"):
		animation_player.play("skip")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro":
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	
	if anim_name == "skip":
		get_tree().change_scene_to_file("res://scenes/game.tscn")

func change_ui():
	if Global.get_player_controller():
		skip_btn.visible = true
		skip_key.visible = false
	else:
		skip_btn.visible = false
		skip_key.visible = true
