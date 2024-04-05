extends Node;

signal load_start;
signal load_update(progress: float);
signal load_end;

var is_loading_scene = false;
var current_resource_load: String;

func _process(_delta):
	if is_loading_scene:
		assert(current_resource_load != "", "No reource path is being loaded and something its being loaded");
		var progress = []; # Vaya basura de implementación, viene a ser un array de salida,
						   # en c# seria load_threaded_get_status(gameplay.resource_path, out progress); 
		match ResourceLoader.load_threaded_get_status(current_resource_load, progress):
			ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
				load_update.emit(progress[0]);
			ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
				_load_ended();

func load_scene(scene: String) -> void:
	ResourceLoader.load_threaded_request(scene);
	load_start.emit();
	current_resource_load = scene;
	is_loading_scene = true;

func _load_ended() -> void:
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(current_resource_load));
	current_resource_load = "";
	is_loading_scene = false;
	load_end.emit();
