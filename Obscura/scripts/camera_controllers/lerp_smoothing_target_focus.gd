class_name LerpTargetFocusCamera
extends CameraControllerBase

@export var lead_speed: float = 10.0
@export var catchup_delay_duration: float = 1.0
@export var catchup_speed: float = 5.0
@export var leash_distance: float = 15.0

var debug_mesh_instance: MeshInstance3D
var _is_moving: bool = false
var _time_since_stop: float = 0.0

func _ready() -> void:
	position += Vector3(0.0, dist_above_target, 0.0)

func _process(delta: float) -> void:
	if !current or target == null:
		return

	var input_vector = Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0,
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	var target_pos = target.global_position + input_vector * lead_speed * delta
	var cam_pos = global_transform.origin

	if input_vector.length() > 0:
		_is_moving = true
		_time_since_stop = 0.0
	else:
		if _is_moving:
			_is_moving = false
			_time_since_stop = 0.0
		else:
			_time_since_stop += delta

	if _is_moving and cam_pos.distance_to(target_pos) > leash_distance:
		cam_pos = cam_pos.linear_interpolate(target_pos, lead_speed * delta)
	elif !_is_moving and _time_since_stop >= catchup_delay_duration:
		cam_pos = cam_pos.linear_interpolate(target.global_position, catchup_speed * delta)

	global_transform.origin = cam_pos + Vector3(0, dist_above_target, 0)

	if draw_camera_logic:
		draw_logic()

func draw_logic() -> void:
	var immediate_mesh = ImmediateMesh.new()
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	var cross_size = 5
	var center = global_transform.origin

	immediate_mesh.surface_add_vertex(center + Vector3(-cross_size, 0, 0))
	immediate_mesh.surface_add_vertex(center + Vector3(cross_size, 0, 0))
	immediate_mesh.surface_add_vertex(center + Vector3(0, 0, -cross_size))
	immediate_mesh.surface_add_vertex(center + Vector3(0, 0, cross_size))

	immediate_mesh.surface_end()
	
	var mesh_instance = debug_mesh_instance
	mesh_instance.mesh = immediate_mesh
	mesh_instance.material_override = material
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	await get_tree().process_frame
	mesh_instance.queue_free()
