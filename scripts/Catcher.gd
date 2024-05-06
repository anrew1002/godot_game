extends Node2D

# Создание сокетов и линии окружности

@onready var socket = preload("uid://bb117svyyitnf")

var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var sockets = []
	
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
	var nb_points = 12
	var points_arc = PackedVector2Array()
	counter +=1
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points+1):
		#draw_circle(points_arc[index_point], 10, color)
		$"Ring".add_point(points_arc[index_point],-1)
		var instance = socket.instantiate()
		instance.ID = index_point
		sockets.append(instance)
		instance.global_position = points_arc[index_point]
		$"Sockets".add_child(instance)


func _on_back_pressed():
	$"Threads".back()
