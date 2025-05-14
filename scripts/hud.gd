extends CanvasLayer

@onready var player_node = get_parent().get_node("../Player")
@onready var flag_count: RichTextLabel = $FlagCount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_node.flags_left != 5:
		flag_count.text = str(player_node.get_flags())
