class_name Player;
extends CharacterBody3D

@export_group("Player Settings")
@export var walk_speed : float = 50.0;
@export var jump_speed : float = 4.4;
@export var sensitivity : float = 0.2;

@export_group("Dependencies")
@export var camera : Camera3D = null;


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_degrees.y -= event.relative.x * sensitivity;
		rotation_degrees.x = clamp(rotation_degrees.x - event.relative.y * sensitivity, -90, 90);


func _ready():
	# @TODO: Mover esto a un sitio más guay
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;


func _physics_process(delta):
	apply_gravity(delta);
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed;
	
	apply_velocity(get_direction(), walk_speed);
	move_and_slide();


func apply_velocity(direction: Vector3, speed: float) -> void:
	if !is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.01);
		velocity.z = lerp(velocity.z, 0.0, 0.01);
	else:
		if direction:
			velocity.x = direction.x * speed;
			velocity.z = direction.z * speed;
		else:
			velocity.x = move_toward(velocity.x, 0, speed);
			velocity.z = move_toward(velocity.z, 0, speed);


func get_direction() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_front", "move_back");
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * sensitivity;
	
	return direction;


func apply_gravity(delta : float) -> void:
	var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity");
	
	if not is_on_floor():
		velocity.y -= gravity * delta;
