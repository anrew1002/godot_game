extends CenterContainer

static var max_id = 0
var id: int 
var mouseover = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureButton/Label.text = var_to_str(id)
	

func _init():
	id = GlobalInfo.sockets_id 
	GlobalInfo.sockets_id +=1

func _on_texture_button_button_down():
	pass


func _on_texture_button_left_click():
	# print(id,get_global_rect().get_area())
	if GlobalInfo.player_state == GlobalInfo.PLAYER_STUFF.THREAD:
		mouseover = true
