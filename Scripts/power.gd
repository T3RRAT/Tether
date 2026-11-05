extends TextureRect

var drop_Down_Menu_Active = false


@onready var innerMenu = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_drop_down_pressed() -> void:
	# holy shit am i genius? this is like, better than 2 if statements
	drop_Down_Menu_Active  = !drop_Down_Menu_Active
	print("pressed the button")
	pass # Replace with function body.
