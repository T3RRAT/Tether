extends Node3D

var center_Vision = null
var target_Vision = null
var screen_Size = DisplayServer.screen_get_size() #DisplayServer.screen_get_size()

var max_X_Value = null
var max_Y_Value = null

@onready var cam = $Camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_Vision = rotation
	target_Vision = center_Vision
	print(screen_Size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# What I have:
	# Screen Size, Center vision, our target vision which is our center
	
	# What to do
	# rotate camera based on where cursor is on screen.
	# will lerp camera rotation to target vision
	# target vision is the target vision plus the screen size.position?
	# if the cursor position is larger then half of the computer vision we will add the vision?
	# 
	
	cam.rotation.y = lerp(center_Vision.y, target_Vision.y + (get_viewport().get_mouse_position().x + screen_Size.x/2), delta * 0.005)
	cam.rotation.x = lerp(center_Vision.x, target_Vision.x + (get_viewport().get_mouse_position().y + screen_Size.y/2), delta * 0.005)
	
	pass
