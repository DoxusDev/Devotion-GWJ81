extends CanvasLayer

@onready var player_node = get_parent().get_node("../Player")
@onready var flag_count: RichTextLabel = $FlagCount
@onready var map_guide: TextureRect = $MapGuide
@onready var player_head: TextureRect = $MapGuide/PlayerHead

@export var world_min_y := 673.0  # parte más baja del mapa
@export var world_max_y := -5888.0     # cima (menor valor Y)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player_node:
		return
	
	if player_node.flags_left != 5:
		flag_count.text = str(player_node.get_flags())
		
	var player_y = player_node.global_position.y
	var t = inverse_lerp(world_min_y, world_max_y, player_y)
	t = lerp(0.1, 0.95, t)
	
	# Obtener el alto de la barra y mover la cabeza
	var bar_height = map_guide.size.y
	var icon_height = player_head.size.y
	
	var target_y = bar_height * (1.0 - t) - icon_height / 2
	target_y = clamp(target_y, 0.0, bar_height - icon_height)
		
	# Suavizado usando lerp: mueve poco a poco hacia la posición objetivo
	player_head.position.y = lerp(player_head.position.y, target_y, 5.0 * delta)
