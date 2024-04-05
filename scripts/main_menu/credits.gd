class_name Credits;
extends PanelContainer;

signal opened;
signal closed;

func _ready():
	hide();

func open_link(link: String) -> void:
	OS.shell_open(link);

func open() -> void:
	opened.emit();
	show();

func close():
	closed.emit();
	hide();
