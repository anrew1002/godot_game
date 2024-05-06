extends Node2D

var strings: Array[Line2D]
# @export var currentString: Line2D
@onready var threadLine = preload("uid://cok2wkhtc1j05")
var is_drawing = false
@onready var currentString = threadLine.instantiate()


func buttonCenter():
	for v in $"../Sockets".get_children():
		if v.mouseover:
			return v

func _ready():
	add_child(currentString)

func _process(_delta):
	lineFunction()

func lineFunction():
	var v = buttonCenter()
	if is_drawing:
		currentString.set_point_position(currentString.get_point_count()-1, get_global_mouse_position())
	if v:
		print("yea")
		var v_pos = v.get_global_rect().get_center()
		if currentString.get_point_count() == 0:
			is_drawing = true
			print(is_drawing)
			currentString.add_point(v_pos)
			currentString.add_point(v_pos)
		elif currentString.get_point_count() == 3:
			#Заверешение старой линнии
			strings.append(currentString)
			currentString.set_point_position(currentString.get_point_count()-1, v_pos)
			# Создание новой линнии
			currentString = threadLine.instantiate()
			add_child(currentString)
			
			is_drawing = false
		else:
			currentString.set_point_position(currentString.get_point_count()-1, v_pos)
			currentString.add_point(v_pos)
		v.mouseover = false
		print(currentString.get_point_count())


func back():
	if is_drawing == true:
		currentString.clear_points();
		is_drawing = false
	else:
		print("yep")
		if strings.size() > 0 :
			var string = strings.pop_back()
			string.queue_free()
