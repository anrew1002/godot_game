extends Node2D

# Создание сокетов и линии окружности

@onready var socket = preload("uid://bb117svyyitnf")
@onready var threads: Node2D = $"Threads"
@onready var sockets: Node2D = $"Sockets"
var cur_index_point:int
var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_back_pressed():
	var child_new = sockets.get_child_count()
	%UICounter.display(str(child_new), "_")
	threads.back()


func _on_threads_line_created(s_pos, thr):
	var child_old = sockets.get_child_count()
	for sck in sockets.get_children():
		if is_equal_approx(s_pos[0],sck.global_position[0]) and is_equal_approx(s_pos[1],sck.global_position[1]):
			
			return
	var instance = socket.instantiate()
	instance.ID = cur_index_point
	cur_index_point+=1
	sockets.add_child(instance)
	var child_new = sockets.get_child_count()
	%UICounter.display(str(child_new),"+"+str(child_new - child_old))
	var loc_pos = thr.to_global(s_pos)
	instance.position =  loc_pos - Vector2(16,16)
	instance.z_index = 10
	pass


