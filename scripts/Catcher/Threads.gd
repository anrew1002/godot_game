extends Node2D

var strings: Array[Line2D]
var currSockets: Array[Node]
var sockets = []

var layer = 0

# @export var currentString: Line2D
@onready var threadLine = preload("uid://cok2wkhtc1j05")
@export  var is_drawing = false
@onready var currentString: Line2D = threadLine.instantiate()
@onready var socket = preload("uid://bb117svyyitnf")
@onready var pink = preload("uid://caocptf86b8qs")

signal line_created(socket_pos:Vector2)

func buttonCenter():
	for v in $"../Sockets".get_children():
		if v.mouseover:
			return v
			
func add_pinky(pos:Vector2):
	var sk = pink.instantiate()
	sk.position = pos
	sk.z_index = -1
	add_child(sk)

func _ready():
	currentString.global_position = Vector2(0,0)
	add_pinky(currentString.global_position)
	add_child(currentString)
	var center = self.global_position
	add_pinky(center)

func _process(_delta):
	lineFunction()

func lineFunction():
	var v = buttonCenter()
	if is_drawing:
		# тяни нитку на местоположение курсора пока плетёшь
		currentString.set_point_position(currentString.get_point_count()-1, get_global_mouse_position())
	if v && v.ring:
		var v_pos = v.get_global_position() + Vector2(16,16)
		v.mouseover = false
		if currSockets.size() > 0 && currSockets[currSockets.size()-1] == v:
			return
		currSockets.append(v)
		# print(is_drawing)
		if currentString.get_point_count() == 0:
			print("start")
			is_drawing = true
			currentString.add_point(v_pos)
			currentString.add_point(v_pos)
		elif currentString.get_point_count() == 3:
			print("complete")
			#Заверешение старой линнии
			strings.append(currentString)
			sockets.append(currSockets)
			
			currentString.set_point_position(currentString.get_point_count()-1, v_pos)
			check_line_intersection()
			# Создание новой линнии
			currSockets = []
			currentString = threadLine.instantiate()
			currentString.clear_points()
			currentString.global_position = Vector2(0,0)
			add_child(currentString)
			is_drawing = false
			
		else:
			# print("___")
			print(currSockets.size())
			currentString.set_point_position(currentString.get_point_count()-1, v_pos)
			currentString.add_point(v_pos)
		
		# print(currentString.get_point_count())

func check_line_intersection():
	layer +=1 
	# print("hey")
	var last_index = len(strings)-1
	# var color = Color(1.0, 0.0, 0.0)
	for k in strings[last_index].get_point_count():
		var trPrimStart = strings[last_index].get_point_position(k)
		var trPrimEnd = strings[last_index].get_point_position((k+1)%3)
		# print(k)
		for i in range(last_index):
			#print(i)	
			for j in range(3):
				var trIterStart = strings[i].get_point_position(j)
				var trIterEnd = strings[i].get_point_position((j+1)%3)

				var intersect_point = Geometry2D.segment_intersects_segment(trPrimStart,trPrimEnd,trIterStart,trIterEnd)
				if intersect_point != null:
					# var sk = socket.instantiate()
					# sk.position = intersect_point
					# add_child(sk)
					# add_pinky(intersect_point)
					# print(sockets[last_index][k].note)
					# print(sockets[last_index][(k+1)%3].note)
					# print(sockets[i][j].note)
					# print(sockets[i][(j+1)%3].note)
					var chord = [sockets[last_index][k].note,sockets[last_index][(k+1)%3].note,sockets[i][j].note,sockets[i][(j+1)%3].note]
					line_created.emit(intersect_point,[strings[last_index].get_point_position(k),strings[i].get_point_position(j)],chord, layer)
					
					GlobalInfo.firstThread = true
					# print(intersect_point)
					# print("intersect!")
				# else: print(intersect_point)

#Функция отмены действия
func back():
	if is_drawing == true:
		currentString.clear_points();
		currSockets = []
		is_drawing = false
	else:
		# print("yep")
		if strings.size() > 0 :
			var string = strings.pop_back()
			string.queue_free()
