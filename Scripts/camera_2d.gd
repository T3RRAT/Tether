extends Camera2D

var cam_Offset = Vector2(0,0)
var min_Offset = -50
var max_Offset = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$"..".position = Vector2(DisplayServer.screen_get_size().x/4, DisplayServer.screen_get_size().y/3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cam_Offset = (get_viewport().get_mouse_position() - position) * 0.2
	cam_Offset.x = clamp(cam_Offset.x, min_Offset, max_Offset)
	cam_Offset.y = clamp(cam_Offset.y, min_Offset/2, max_Offset/2)
	
	global_position = $"..".position + cam_Offset
	pass
