extends AudioStreamPlayer

@export var button_group_name: String;
@export var signal_name: String;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group(button_group_name, "connect", signal_name, play);

