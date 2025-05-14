extends CanvasLayer

@onready var enter_pause_sound: AudioStreamPlayer2D = $EnterPauseSound
@onready var change_focus_btn_sound: AudioStreamPlayer2D = $ChangeFocusBtnSound
@onready var continue_btn: Button = $ContinueBtn

var can_play = false

# De primeras el menú de pausa está oculto
func _ready():
	hide()

func toggle_pause():
	print(visible)
	if visible:
		hide()
		get_tree().paused = false
		can_play = false
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else:
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		enter_pause_sound.play()
		get_tree().paused = true
		continue_btn.grab_focus()
		can_play = true

# Cuando el btn de "Continuar" se pulsa se quita el menú de pausa y continua el juego
func _on_continue_btn_pressed() -> void:
	toggle_pause()

# Cuando el btn de "Salir" se pulsa se sale del juego
func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if  event.is_action_pressed("pause"):
		toggle_pause()

func _on_continue_btn_focus_entered() -> void:
	if can_play:
		change_focus_btn_sound.play()

func _on_quit_btn_focus_entered() -> void:
	change_focus_btn_sound.play()

#func _on_continue_btn_2_pressed() -> void:
	#toggle_pause()
