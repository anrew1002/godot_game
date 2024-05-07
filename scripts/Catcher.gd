extends Node2D

# Создание сокетов и линии окружности

@onready var socket = preload("uid://bb117svyyitnf")
@onready var threads: Node2D = $"Threads"
@onready var sockets: Node2D = $"Sockets"
var cur_index_point:int
var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# var sockets = []
	
func _draw():
	
	var center = get_viewport_rect().size / 2.0
	var radius = 160
	#var angle_from = 20
	#var angle_to = 360
	var color = Color(1.0, 0.0, 0.0)
	draw_circle_arc(center,radius, color)

func draw_circle_arc(center, radius, _color):
	var angle_from = 0
	var angle_to = 360
	var nb_points = 6
	var points_arc = PackedVector2Array()
	counter +=1
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points+1):
		#draw_circle(points_arc[index_point], 10, color)
		cur_index_point = index_point
		$"Ring".add_point(points_arc[index_point],-1)
		var instance = socket.instantiate()
		instance.ID = index_point
		# sockets.append(instance)
		instance.global_position = points_arc[index_point]
		sockets.add_child(instance)


func _on_back_pressed():
	threads.back()


func _on_threads_line_created(s_pos, thr):
	
	for sck in sockets.get_children():
		if is_equal_approx(s_pos[0],sck.global_position[0]) and is_equal_approx(s_pos[1],sck.global_position[1]):
			return
	print("Childs: " + var_to_str(sockets.get_child_count()))
	var instance = socket.instantiate()
	instance.ID = cur_index_point
	cur_index_point+=1
	sockets.add_child(instance)
	var loc_pos = thr.to_global(s_pos)
	instance.position =  loc_pos - Vector2(16,16)
	instance.z_index = 10
	pass


