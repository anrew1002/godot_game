extends Node2D

# Создание сокетов и линии окружности

@onready var socket = preload("uid://bb117svyyitnf")
@onready var threads: Node2D = $"Threads"
@onready var sockets: Node2D = $"Sockets"
@onready var ring: Node2D = $"Ring"
@onready var pink = preload("uid://caocptf86b8qs")
var cur_index_point:int
var counter = 0



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
	threads.back()

# Создание сокета на месте пересечения, если есть место
func _on_threads_line_created(s_pos, thr):
	var child_old = sockets.get_child_count()
	s_pos = thr.to_global(s_pos)
	print(s_pos)
	
	for sck in sockets.get_children():
		var sck_pos = sck.global_position

		if sck_pos.distance_to(s_pos  - Vector2(16,16)) < 20:
			print("end!")
			return

	var instance = socket.instantiate()
	sockets.add_child(instance)
	var child_new = sockets.get_child_count()
	%UICounter.display(str(child_new),"+"+str(child_new - child_old))
	# var loc_pos = thr.to_global(s_pos)
	instance.position =  s_pos  - Vector2(16,16)
	instance.z_index = 10
	


