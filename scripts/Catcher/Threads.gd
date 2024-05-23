extends Node2D

var strings: Array[Line2D]
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
		# print("___")
		currentString.set_point_position(currentString.get_point_count()-1, get_global_mouse_position())
	if v:
		# print("yea " + (var_to_str(strings.size())))
		var v_pos = v.get_global_rect().get_center()
		# print(is_drawing)
		if currentString.get_point_count() == 0:
			is_drawing = true
			currentString.add_point(v_pos)
			currentString.add_point(v_pos)
		elif currentString.get_point_count() == 3:
			
			#Заверешение старой линнии
			strings.append(currentString)
			currentString.set_point_position(currentString.get_point_count()-1, v_pos)
			check_line_intersection()
			# Создание новой линнии
			currentString = threadLine.instantiate()
			currentString.clear_points()
			currentString.global_position = Vector2(0,0)
			add_child(currentString)
			is_drawing = false
			
		else:
			# print("___")
			currentString.set_point_position(currentString.get_point_count()-1, v_pos)
			currentString.add_point(v_pos)
		v.mouseover = false
		# print(currentString.get_point_count())

func check_line_intersection():
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
				# print(strings[i])
				# print("Start")
				# print(trPrimStart)
				# print(trPrimEnd)
				# print("End")
				# print(trIterStart)
				# print(trIterEnd)
				var intersect_point = Geometry2D.segment_intersects_segment(trPrimStart,trPrimEnd,trIterStart,trIterEnd)
				if intersect_point != null:
					# var sk = socket.instantiate()
					# sk.position = intersect_point
					# add_child(sk)
					add_pinky(intersect_point)
					line_created.emit(intersect_point,strings[i])
					# print(intersect_point)
					print("intersect!")
				# else: print(intersect_point)

#Функция отмены действия
func back():
	if is_drawing == true:
		currentString.clear_points();
		is_drawing = false
	else:
		# print("yep")
		if strings.size() > 0 :
			var string = strings.pop_back()
			string.queue_free()
