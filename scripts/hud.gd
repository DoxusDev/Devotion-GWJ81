extends CanvasLayer

@onready var player_node = get_parent().get_node("../Player")
@onready var flag_count: RichTextLabel = $FlagCount
@onready var map_guide: TextureRect = $MapGuide
@onready var player_head: TextureRect = $MapGuide/PlayerHead

@export var world_min_y := 673.0
@export var world_max_y := -5888.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player_node:
		return
	
	if player_node.flags_left != 5:
		if player_node.get_flags() == 1:
			flag_count.text = "[shake rate=20.0 level=5][color=#e63946]" + str(player_node.get_flags()) + "[/color][/shake]"
		elif player_node.get_flags() == 0:
			flag_count.text = str(player_node.get_flags())
		else:
			flag_count.text = "[wave]" + str(player_node.get_flags()) + "[/wave]"
		
	var player_y = player_node.global_position.y
	var t = inverse_lerp(world_min_y, world_max_y, player_y)
	t = lerp(0.1, 0.95, t)
	
	var bar_height = map_guide.size.y
	var icon_height = player_head.size.y
	
	var target_y = bar_height * (1.0 - t) - icon_height / 2
	target_y = clamp(target_y, 0.0, bar_height - icon_height)
	
	player_head.position.y = lerp(player_head.position.y, target_y, 5.0 * delta)
