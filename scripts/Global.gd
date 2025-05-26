extends Node

var using_gamepad = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		using_gamepad = true
	elif event is InputEventKey or event is InputEventMouseButton:
		using_gamepad = false

func get_player_controller() -> bool:
	return using_gamepad
