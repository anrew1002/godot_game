extends Node2D

# Создание сокетов и линии окружности

@onready var socket = preload("uid://bb117svyyitnf")
@onready var threads: Node2D = $"Threads"
@onready var sockets: Node2D = $"Sockets"
@onready var sampler: Node = $"SamplerInstrument"
@onready var ring: Node2D = $"Ring"
@onready var pink = preload("uid://caocptf86b8qs")
var cur_index_point:int
var counter = 0

var created_sockets = []
var curr_creation = []
var prev_layer = -1



func add_pinky(pos:Vector2) -> Node:
	var sk = pink.instantiate()
	sk.position = pos
	sk.modulate = Color(0,0,1,0.2)
	sk.rotation = 90
	add_child(sk)
	return sk

# отмена слоя 
func _on_back_pressed():
	var child_new = sockets.get_child_count()
	%UICounter.display(str(child_new), "_")
	if !threads.is_drawing && created_sockets.size() > 0:
			var sck_arr = created_sockets.pop_back()
			for sck in sck_arr:
				sck.queue_free()
	threads.back()
	


# Создание сокета на месте пересечения, если есть место
func _on_threads_line_created(s_pos, thr, chord, layer):
	
	var child_old = sockets.get_child_count()
	# s_pos = thr.to_global(s_pos)
	# print(s_pos)
	if prev_layer != layer:
		created_sockets.append([])
		prev_layer = layer
	for sck in sockets.get_children():
		var sck_pos = sck.global_position

		if sck_pos.distance_to(s_pos  - Vector2(16,16)) < 20:
			print("end!")
			return

	var instance = socket.instantiate()
	instance.chord = chord as Array[String]
	instance.position =  s_pos 
	instance.z_index = 10
	var angle_point = instance.global_position.angle_to_point((thr[1]))
	instance.r1 = angle_point + deg_to_rad(45)
	angle_point = instance.global_position.angle_to_point((thr[0]))
	instance.r2 = angle_point + deg_to_rad(45)
	sockets.add_child(instance)


	created_sockets[created_sockets.size()-1].append(instance)

	var child_new = sockets.get_child_count()
	%UICounter.display(str(child_new),"+"+str(child_new - child_old))
	# var loc_pos = thr.to_global(s_pos)





func _on_pointer_line_collide(collided_socket:Node):
	collided_socket = collided_socket.get_parent() as socket_class
	if collided_socket.currState == socket_class.STATE.X:
		if collided_socket.chord.size() != 0:
			sampler.play_note(collided_socket.chord[0], 4)
			sampler.play_note(collided_socket.chord[1], 4)
			sampler.play_note(collided_socket.chord[2], 4)
			sampler.play_note(collided_socket.chord[3], 4)
			return
		if collided_socket.note != null:
			# print(collided_socket.note)
			sampler.play_note(collided_socket.note, 4)
		else:
			printerr("Sound is nul!")
		sampler.play_note("D", 4)
	if collided_socket.chord.size() != 0:
		if collided_socket.currState == socket_class.STATE.LONG:
			print(collided_socket.chord[0])
			sampler.play_note(collided_socket.chord[0], 4)
			print(collided_socket.chord[1])
			sampler.play_note(collided_socket.chord[1], 4)
		if collided_socket.currState == socket_class.STATE.LONG2:
			print(collided_socket.chord[0])
			sampler.play_note(collided_socket.chord[2], 4)
			print(collided_socket.chord[1])
			sampler.play_note(collided_socket.chord[3], 4)
			# sampler.play_note(collided_socket.chord[2], 4)
			# sampler.play_note(collided_socket.chord[3], 4)
			return