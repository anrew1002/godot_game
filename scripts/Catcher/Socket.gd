extends CenterContainer
class_name socket_class

static var max_id = 0
var id: int 
var mouseover = false
var note: String = "D"
var chord: Array
var active: bool = false
enum STATE {NONE, X, LONG, LONG2}
var currState = STATE.NONE
var states_num = 4

var ring: bool = false

var r1
var r2

var noneTexture = preload("res://assets/textures/socket.svg")
var beadTexture = preload("res://assets/textures/pink_bead (1).svg")
var longTexture = preload("res://assets/textures/bead_long.svg")

@onready var textButton = $TextureButton
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureButton/Label.text = var_to_str(id)
	$TextureButton/Label.text = note
	update_state()
	if ring:
		states_num = 2
	

func _init():
	id = GlobalInfo.sockets_id 
	GlobalInfo.sockets_id +=1

func _on_texture_button_button_down():
	pass

func update_state():
	rotation = 0
	if currState == STATE.NONE:
		textButton.texture_normal = noneTexture
	if currState == STATE.X:
		textButton.texture_normal = beadTexture
		GlobalInfo.firstBead = true
	if currState == STATE.LONG:
		textButton.texture_normal = longTexture
		rotation = r1
		GlobalInfo.firstBeadInside = true
	if currState == STATE.LONG2:
		textButton.texture_normal = longTexture
		rotation = r2
		GlobalInfo.firstBeadInside = true

func _on_texture_button_left_click():
	# print(id,get_global_rect().get_area())
	if GlobalInfo.player_state == GlobalInfo.PLAYER_STUFF.NONE:
		active = !active
		currState = (currState + 1) % states_num as STATE
		update_state()
		
	if GlobalInfo.player_state == GlobalInfo.PLAYER_STUFF.THREAD:
		mouseover = true
