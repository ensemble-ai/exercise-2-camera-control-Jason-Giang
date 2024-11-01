class_name PositionLock
extends CameraControllerBase

var debug_mesh_instance: MeshInstance3D

func _ready() -> void:
	position += Vector3(0.0, dist_above_target, 0.0)
	debug_mesh_instance = MeshInstance3D.new()
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED
	debug_mesh_instance.material_override = material
	add_child(debug_mesh_instance)

func _process(delta: float) -> void:
	if target:
		global_transform.origin.x = target.global_transform.origin.x
		global_transform.origin.z = target.global_transform.origin.z
		global_transform.origin.y = target.global_transform.origin.y + dist_above_target

	if Input.is_action_just_pressed("fire1"):
		draw_camera_logic = !draw_camera_logic
		
	if draw_camera_logic:
		draw_logic()

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	var cross_size = 5
	var center = target.global_position

	immediate_mesh.surface_add_vertex(center + Vector3(-cross_size, 0, 0))
	immediate_mesh.surface_add_vertex(center + Vector3(cross_size, 0, 0))
	immediate_mesh.surface_add_vertex(center + Vector3(0, 0, -cross_size))
	immediate_mesh.surface_add_vertex(center + Vector3(0, 0, cross_size))

	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.RED

	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = center

	await get_tree().process_frame
	mesh_instance.queue_free()
