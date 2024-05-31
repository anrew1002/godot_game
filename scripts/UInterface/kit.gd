extends AnimatedSprite2D

var text_arrays = []
var current_section = 0
var current_line = 0



func start_tutorial():
	# Проверка на наличие текста
	if text_arrays.size() > 0:
		# Установка начального текста
		update_label_text()

func update_label_text():
	if current_section < text_arrays.size():
		var section = text_arrays[current_section]
		if current_line < section.size():
			var label = get_node("Label") # Измените путь к ноде Label
			label.text = section[current_line]
		else:
			# Переход к следующей секции
			if (current_section == 0 and GlobalInfo.firstSpider == true 
			or current_section == 1 and GlobalInfo.firstThread == true
			or current_section == 2 and GlobalInfo.firstScissors == true
			or current_section == 3 and GlobalInfo.firstCupOfBeads == true
			or current_section == 4 and GlobalInfo.firstBead == true
			or current_section == 5 and GlobalInfo.firstBeadInside == true
			or current_section == 6 and GlobalInfo.firstSpace == true):
				current_line = 0
				current_section += 1
				if current_section < text_arrays.size():
					update_label_text()
				else:
					print("Обучение завершено")
					
			elif current_section == 7:
				GlobalInfo.studied = true
				

func load_text_from_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		return content
	else:
		print("Файл не найден: %s" % path)
		return ""
		
func process_text(text):
	text = text.replace("\r", "") # Удаляем все символы \r
	var sections = text.split("$")
	var result = []
	for section in sections:
		var lines = section.strip_edges().split("\n")
		result.append(lines)
	return result
	
# Called when the node enters the scene tree for the first time.
func _ready():

	MessageBus.connect("thread_selected",on_thread_selected_script)

	var file_path = "res://assets/dialogs/kit_tutorial.txt" # Укажите путь к вашему текстовому файлу
	var text = load_text_from_file(file_path)
	text_arrays = process_text(text)
	#print(text_arrays) # Для проверки, что массивы созданы правильно
	if GlobalInfo.firstStep:
		GlobalInfo.firstStep = false
		start_tutorial()
	else:
		text_arrays = []
		
	if GlobalInfo.studied:
		get_node("Dialog").visible = false
	

# Обработчик кликов на спрайт
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = event.position
			if is_click_on_sprite(mouse_pos):
				if GlobalInfo.studied:
					get_tree().change_scene_to_file("res://scenes/card.tscn");
					GlobalInfo.firstAward = true
				elif current_section < text_arrays.size():
					current_line += 1
					update_label_text()

func on_thread_selected_script():
	update_label_text()
				

func is_click_on_sprite(mouse_pos):
	var frame_texture = sprite_frames.get_frame_texture(animation, frame)
	var sprite_size = frame_texture.get_size()
	var rect = Rect2(position - sprite_size * 0.5, sprite_size) # Центрируем прямоугольник на позиции спрайта
	return rect.has_point(mouse_pos)
