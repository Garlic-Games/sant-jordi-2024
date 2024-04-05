extends CanvasLayer;

@onready var settings_menu: Settings = %SettingsMenu;
@onready var credits: Credits = %Credits;
@onready var loading_panel: LoadingPanel = %LoadingPanel;
@export_file("*.tscn") var gameplay_scene: String;

func _ready():
	assert(gameplay_scene != "", "A gameplay scene resource must be provided to main menu")

func start_game() -> void:
	SceneLoader.load_scene(gameplay_scene);

func open_settings() -> void:
	settings_menu.open();

func open_credits() -> void:
	credits.open();

func close_game() -> void:
	get_tree().quit();
