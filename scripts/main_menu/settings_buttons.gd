class_name SettingsButtons;
extends VBoxContainer

@onready var master_slider = %MasterSlider;
@onready var music_slider = %MusicSlider;
@onready var sfx_slider = %SFXSlider;
@onready var fullscreen_toggle = $FullscreenRow/FullscreenToggle

var master_index = AudioServer.get_bus_index("Master");
var music_index = AudioServer.get_bus_index("Music");
var sfx_index = AudioServer.get_bus_index("SFX");

func _ready():
	master_slider.value_changed.connect(_on_master_slider_value_changed);
	music_slider.value_changed.connect(_on_music_slider_value_changed);
	sfx_slider.value_changed.connect(_on_sfx_slider_value_changed);
	fullscreen_toggle.toggled.connect(_on_fullscreen_toggle_toggled);

func setup():
	master_slider.value = db_to_linear(master_index);
	music_slider.value = db_to_linear(music_index);
	sfx_slider.value = db_to_linear(sfx_index);

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_index, linear_to_db(value));

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value));

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value));

func _on_fullscreen_toggle_toggled(toggled_on):
	var window = get_window();
	var screen_size = DisplayServer.screen_get_size();
	
	if(toggled_on):
		window.mode = Window.MODE_FULLSCREEN;
	else:
		window.mode = Window.MODE_WINDOWED;
		window.size = Vector2i(screen_size.x - 66, screen_size.y - 1);
		window.position = Vector2i(
			(screen_size.x - window.size.x)*0.5, 
			(screen_size.y - window.size.y) + 200);
