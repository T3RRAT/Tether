extends Camera2D

var cam_Offset = Vector2(0,0)
var min_Offset = -25
var max_Offset = 25

var screen_Size = DisplayServer.screen_get_size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$"..".position = Vector2(DisplayServer.screen_get_size().x/4, DisplayServer.screen_get_size().y/3)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# how tf does this code works
	cam_Offset = ((get_viewport().get_mouse_position() - Vector2(screen_Size)/3) - position) * 0.05
	cam_Offset.x = clamp(cam_Offset.x, min_Offset, max_Offset)
	cam_Offset.y = clamp(cam_Offset.y, min_Offset/2, max_Offset/2)
	
	global_position = $"..".position + cam_Offset
	
	
	
	
	
	
	pass
