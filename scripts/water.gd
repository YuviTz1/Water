extends Node3D

@onready var water = $Area3D/MeshInstance3D;
@onready var camera = $Camera3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	water.mesh.material.set_shader_parameter("center", Vector3(10,0,0.0));
	set_process_input(true)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass
	
#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		##var camera = get_viewport().get_camera()
		#if camera:
			#var ray_origin = camera.project_ray_origin(get_viewport().get_mouse_position())
			#var ray_direction = camera.project_ray_normal(get_viewport().get_mouse_position())
			#var ray = RayCast3D.new()
			#add_child(ray)
			#ray.cast_to = Vector2(ray_direction.x, ray_direction.y) * 1000  # Adjust length of ray as needed
			#ray.global_transform.origin = ray_origin
			#var collision_point = ray.get_collision_point()
			#if collision_point:
				## Now `collision_point` contains the world coordinates where the ray intersects with the plane
				#print("Collision Point:", collision_point)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#var camera = get_viewport().get_camera()
		if camera:
			var ray_origin = camera.project_ray_origin(get_viewport().get_mouse_position())
			var ray_end = ray_origin + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000.0   # Adjust ray length as needed
			print(ray_origin)
			print(ray_end)
			var space_state = get_world_3d().direct_space_state
			var rayObject = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
			rayObject.collide_with_areas = true
			var intersection = space_state.intersect_ray(rayObject)
			print(intersection)
			if intersection:
				var collision_point = intersection.position
				# Now `collision_point` contains the world coordinates where the ray intersects with the plane
				print("Collision Point:", collision_point)
				water.mesh.material.set_shader_parameter("center", collision_point);
				water.mesh.material.set_shader_parameter("do_ripple", true);
