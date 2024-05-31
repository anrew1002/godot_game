extends Line2D

@onready var ray: RayCast2D = $RayCast2D
var last_collide = false
var angle_step = 20.0
var active = false
var sockets: Array[Node]
var last_collision = false

signal line_collide(socket:Node)
# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().size / 2.0	
	# print(position)
	# print(global_position)
	add_point(Vector2(0,0))
	add_point(Vector2(0,0) - Vector2(0,200))
	
	for i in points.size() - 1:
		var new_shape = CollisionShape2D.new()
		$StaticBody2D.add_child(new_shape)
		var segment = SegmentShape2D.new()
		segment.a = points[i]
		segment.b = points[i + 1]
		new_shape.shape = segment
func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_SPACE) and just_pressed:
		active = !active
		# print(rad_to_deg(rotation))
		if active == true:
			# sockets.assign($"../Sockets".get_children())
			sockets = $"../Sockets".get_children()
			GlobalInfo.firstSpace = true

					# print(Vector2.from_angle(angle_point))
					# print(Vector2.from_angle(rotation))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		rotate(deg_to_rad(angle_step) * delta)
		if ray.is_colliding():
			# if !last_collide:
				# print("collide")
				var collider: Node = ray.get_collider()
				# var socket:  = collider.get_parent()
				line_collide.emit(collider)
				ray.add_exception(collider)
				
				# last_collide = true
		# else:
			# last_collide = false
		# print(fmod(rotation_degrees, 360.0))
		var mod_rotation = fmod(rotation_degrees, 360.0)
		if (mod_rotation > 358):
			ray.clear_exceptions()
			print("clear!")