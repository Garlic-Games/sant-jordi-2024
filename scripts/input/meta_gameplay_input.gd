extends Node

@export var pause_menu: PauseMenu;

func _ready():
	assert(pause_menu, "Pause menu panel not assigned to metagameplay input");

func _input(event: InputEvent):
	if event.is_action_pressed("pause"):
		if !pause_menu:
			return;
		pause_menu.toogle();
