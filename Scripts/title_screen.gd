extends Node3D

@onready var Overlay = $"2D Overlay"
@onready var Elements_Control_Position = $"2D Overlay/Elements Control".position
@onready var cam2d_Offset = null

var center_Vision = Vector2(0,0)
var target_Vision = Vector2(0,0)
var screen_Size = DisplayServer.screen_get_size() #DisplayServer.screen_get_size()

var max_X_Value = null
var max_Y_Value = null


var cam_Offset: Vector2
var min_Offset = -200
var max_Offset = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_Vision = Elements_Control_Position
	target_Vision = center_Vision
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#cam_Offset = (get_viewport().get_mouse_position() - Elements_Control_Position) * 0.5
	#cam_Offset.x = clamp(cam_Offset.x, min_Offset, max_Offset)
	#cam_Offset.y = clamp(cam_Offset.y, min_Offset, max_Offset)
	
	#camera.position = lerp(camera.position, originalPosition.position + cam_Offset, delta * 1)
	
	
	
	
	#Elements_Control_Position = lerp(center_Vision, target_Vision + get_viewport().get_mouse_position(), delta * 2)
	Elements_Control_Position = target_Vision + get_viewport().get_mouse_position()
	
	pass


# Goal: Make it so that the camera pans depending on location of mouse


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.


func _on_test_timer_timeout() -> void:
	#print(get_viewport().get_mouse_position())
	print(Elements_Control_Position)
	pass # Replace with function body.
