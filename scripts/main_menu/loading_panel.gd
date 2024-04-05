class_name LoadingPanel;
extends PanelContainer;
@onready var loading_progress_bar: ProgressBar = %LoadingProgressBar;

func _ready():
	SceneLoader.load_start.connect(open);
	SceneLoader.load_update.connect(update_progress);
	SceneLoader.load_end.connect(close);
	hide();

var progress: float:
	set(value):
		loading_progress_bar.value = value;

func open() -> void:
	progress = 0;
	show();

func update_progress(update: float) -> void:
	progress = update;

func close() -> void:
	hide();
