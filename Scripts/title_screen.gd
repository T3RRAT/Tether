extends Node3D

@onready var camera = $Camera
@onready var originalPosition = $"Original Position"

var cam_Offset: Vector3
var min_Offset = -0.5
var max_Offset = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cam_Offset = (Vector3(get_viewport().get_mouse_position().x, -get_viewport().get_mouse_position().y, originalPosition.position.z) - global_position)
	cam_Offset.x = clamp(cam_Offset.x, min_Offset, max_Offset)
	cam_Offset.y = clamp(cam_Offset.y, min_Offset, max_Offset)
	camera.position = lerp(camera.position, originalPosition.position + cam_Offset, delta * 1)
	pass


# Goal: Make it so that the camera pans depending on location of mouse


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.


func _on_test_timer_timeout() -> void:
	print(cam_Offset)
	pass # Replace with function body.
