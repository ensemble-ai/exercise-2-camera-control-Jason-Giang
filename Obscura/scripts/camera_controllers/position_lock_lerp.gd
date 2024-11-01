class_name PositionLockLerpCamera
extends CameraControllerBase

@export var follow_speed: float = 5.0
@export var catchup_speed: float = 10.0
@export var leash_distance: float = 10.0

func _ready() -> void:
	position += Vector3(0.0, dist_above_target, 0.0)

func _process(delta: float) -> void:
	if !current or target == null:
		return

	var target_pos = target.global_position
	var cam_pos = global_transform.origin
	var distance = cam_pos.distance_to(target_pos)

	if distance > leash_distance:
		cam_pos = cam_pos.linear_interpolate(target_pos, catchup_speed * delta)
	else:
		cam_pos = cam_pos.linear_interpolate(target_pos, follow_speed * delta)

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
	
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.material_override = material
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(mesh_instance)

	await get_tree().process_frame
	mesh_instance.queue_free()
