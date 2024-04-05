class_name Settings;

extends PanelContainer
@onready var settings_buttons: SettingsButtons = %SettingsButtons

signal opened;
signal closed;

func _ready() -> void:
	hide();

func open() -> void:
	opened.emit();
	settings_buttons.setup();
	show();

func close():
	closed.emit();
	hide();
