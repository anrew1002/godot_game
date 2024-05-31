extends TextureButton

var needleTexture = preload("res://assets/textures/sewing-needle.svg")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	GlobalInfo.player_state = GlobalInfo.PLAYER_STUFF.THREAD
	GlobalInfo.firstSpider = true
	MessageBus.emit_signal("thread_selected")
	Input.set_custom_mouse_cursor(needleTexture, 0, Vector2(20,0))
	# display/mouse_cursor/custom_image