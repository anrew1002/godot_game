extends PanelContainer


@onready var Label1 = $"VC/Label"
@onready var Label2 = $"VC/Label2"

func display(l1:String,l2:String):
	Label1.text = l1
	Label2.text = l2
