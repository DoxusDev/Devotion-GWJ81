extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 2000
const FRICTION = 2000
const JUMP_VELOCITY = -600.0
const MAX_JUMP_TIME = 0.2
const GRAVITY = 1800
const FALL_GRAVITY = 3000
const COYOTE_TIME = 0.1

@export var max_flags = 100
var flags_left = max_flags
var last_flag_position = Vector2.ZERO
var coyote_time_left = 0.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2d
@onready var flag_scene = preload("res://scenes/flag.tscn")
@onready var effects: AnimatedSprite2D = $Effects

var current_flag: Node = null
var is_flagging = false

func _physics_process(delta: float) -> void:
	if is_flagging:
		return
	
	if is_on_floor():
		coyote_time_left = COYOTE_TIME
	else:
		coyote_time_left -= delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _get_gravity(velocity) * delta
		effects.visible = false

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

	# Handle jump.
	if Input.is_action_just_pressed("jump") and coyote_time_left > 0.0:
		#effects.visible = true
		#effects.play("jump_dust")
		velocity.y = JUMP_VELOCITY
		coyote_time_left = 0.0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
		effects.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		effects.flip_h = true
	
	if Input.is_action_just_pressed("flag") and is_on_floor():  # "interact" es tu acción E
		is_flagging = true
		animated_sprite_2d.play("flag")
		await get_tree().create_timer(0.3).timeout
		plant_flag()
		velocity.x = 0  # Detiene al personaje, opcional
		return
	
	if not is_on_floor():
		animated_sprite_2d.play("jump")  # si estás en el aire, mantén "jump"
	elif direction:
		animated_sprite_2d.play("run")
		effects.visible = true
		effects.play("run_dust")
	else:
		animated_sprite_2d.play("idle")
		effects.visible = false
		effects.stop()
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "flag":
		is_flagging = false
		animated_sprite_2d.play("idle")

func plant_flag():
	if flags_left <= 0:
		return
	
	if current_flag and current_flag.is_inside_tree():
		current_flag.queue_free()
	
	var flag = flag_scene.instantiate()
	flag.global_position = global_position
	get_tree().current_scene.add_child(flag)
	
	current_flag = flag
	last_flag_position = global_position
	flags_left -= 1
	print(flags_left)
	print(last_flag_position)

func _get_gravity(velocity):
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY
