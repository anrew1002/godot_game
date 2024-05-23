extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/root.tscn");


func _on_menu_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/awards.tscn");


func _on_menu_button_3_pressed():
	pass # Replace with function body.


func _on_menu_button_4_pressed():
	get_tree().quit();


