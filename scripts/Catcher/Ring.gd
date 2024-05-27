extends Line2D

@onready var socket = preload("uid://bb117svyyitnf")
@onready var sockets: Node2D = $"../Sockets"
@export var radius: int = 160
@export var nb_points: int = 6
@export var gamma: Array[String] = ["D","E","F#","A","B"]
@export	var color = Color(1.0, 0.0, 0.0)


# Called when the node enters the scene tree for the first time.
func _ready():
	draw_circle_arc()


func draw_circle_arc():
	var center = get_viewport_rect().size / 2.0	
	var angle_from = 0
	var angle_to = 360
	
	var points_arc = PackedVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		add_point(points_arc[index_point],-1)
		var instance = socket.instantiate() as socket_class
		instance.note = gamma[index_point]
		instance.ring = true
		instance.global_position = points_arc[index_point]
		instance.z_index = 10
		sockets.add_child(instance)
	return socket
