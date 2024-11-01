class_name FramingAutoScroll
extends CameraControllerBase

@export var top_left: Vector2
@export var bottom_right: Vector2
@export var autoscroll_speed: Vector3

func _ready() -> void:
	position = target.position + Vector3(0, dist_above_target, 0)

func _process(delta: float) -> void:
	if !current:
		return

	position += autoscroll_speed * delta

	var tpos = target.global_position
	var cpos = global_position

	if tpos.x < cpos.x + top_left.x:
		target.global_position.x = cpos.x + top_left.x
		
	if draw_camera_logic:
		draw_logic()

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.RED
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	await get_tree().process_frame
	mesh_instance.queue_free()
