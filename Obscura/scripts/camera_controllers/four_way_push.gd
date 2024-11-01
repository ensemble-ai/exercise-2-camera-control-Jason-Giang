class_name SpeedupPushZoneCamera
extends CameraControllerBase

@export var push_ratio: float = 0.5
@export var pushbox_top_left: Vector2 = Vector2(0, 0)
@export var pushbox_bottom_right: Vector2 = Vector2(100, 100)
@export var speedup_zone_top_left: Vector2 = Vector2(10, 10)
@export var speedup_zone_bottom_right: Vector2 = Vector2(90, 90)

func _ready() -> void:
	position += Vector3(0.0, dist_above_target, 0.0)

func _process(delta: float) -> void:
	if target:
		update_camera_position()

	if Input.is_action_just_pressed("fire1"):
		draw_camera_logic = !draw_camera_logic

	draw_push_zone()

func update_camera_position() -> void:
	var target_position = target.global_transform.origin
	var target_velocity = target.get_velocity()
	var x_speed = target_velocity.x
	var y_speed = target_velocity.z

	var is_in_pushbox = target_position.x >= pushbox_top_left.x and target_position.x <= pushbox_bottom_right.x and target_position.z >= pushbox_top_left.y and target_position.z <= pushbox_bottom_right.y

	if draw_camera_logic:
		return

	var camera_velocity = Vector3.ZERO

	if is_in_pushbox:
		var touching_top = target_position.z >= pushbox_bottom_right.y
		var touching_bottom = target_position.z <= pushbox_top_left.y
		var touching_left = target_position.x <= pushbox_top_left.x
		var touching_right = target_position.x >= pushbox_bottom_right.x

		if touching_top:
			camera_velocity.z = y_speed
			camera_velocity.x = x_speed * push_ratio
		elif touching_bottom:
			camera_velocity.z = -y_speed
			camera_velocity.x = x_speed * push_ratio
		elif touching_left:
			camera_velocity.x = -x_speed
			camera_velocity.z = y_speed * push_ratio
		elif touching_right:
			camera_velocity.x = x_speed
			camera_velocity.z = y_speed * push_ratio
		else:
			camera_velocity.x = x_speed * push_ratio
			camera_velocity.z = y_speed * push_ratio

	position += Vector3(camera_velocity.x, 0, camera_velocity.z) * get_process_delta_time()

func draw_push_zone() -> void:
	if draw_camera_logic:
		var mesh_instance := MeshInstance3D.new()
		var immediate_mesh := ImmediateMesh.new()
		var material := StandardMaterial3D.new()
		mesh_instance.mesh = immediate_mesh
		mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

		immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
		immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
		immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
		immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
		immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
		immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
		immediate_mesh.surface_end()

		immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
		immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
		immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
		immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
		immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
		immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
		immediate_mesh.surface_end()

		material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		material.albedo_color = Color.RED

		add_child(mesh_instance)
		mesh_instance.global_transform = Transform3D.IDENTITY
		mesh_instance.global_position = Vector3((pushbox_top_left.x + pushbox_bottom_right.x) / 2, 0, (pushbox_top_left.y + pushbox_bottom_right.y) / 2)

		await get_tree().process_frame
		mesh_instance.queue_free()
