extends Line2D

var angle_step = 20.0
var active = false
var sockets: Array[Node]
# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().size / 2.0	
	print(position)
	add_point(Vector2(0,0))
	add_point(Vector2(0,0) - Vector2(0,200))
	
	for i in points.size() - 1:
		var new_shape = CollisionShape2D.new()
		$StaticBody2D.add_child(new_shape)
		var segment = SegmentShape2D.new()
		segment.a = points[i]
		segment.b = points[i + 1]
		new_shape.shape = segment
func _input(_event):
	if Input.is_key_pressed(KEY_SPACE):
		active = !active
		# print(rad_to_deg(rotation))
		if active == true:
			# sockets.assign($"../Sockets".get_children())
			sockets = $"../Sockets".get_children()
			for s in sockets:
				if s.id == 1:
					print(s.global_position) 
					print(self.global_position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		rotate(deg_to_rad(angle_step) * delta)
