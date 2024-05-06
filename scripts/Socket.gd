extends CenterContainer

var ID: int 
var mouseover = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_button_down():
	pass


func _on_texture_button_left_click():
	print(ID,get_global_rect().get_area())
	mouseover = true
