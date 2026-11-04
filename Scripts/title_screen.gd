extends Node3D

@onready var Overlay = $"2D Overlay"
@onready var Elements_Control_Position = $"2D Overlay/Elements Control".position
@onready var cam2d_Offset = null
@onready var CRT_Filter = $"2D Overlay/CanvasLayer/CRT Filter Adjusred"

@onready var spotlight_For_Ship = $"Camera Pivot Point/Camera/SpotLight3D"
@onready var light_Pointer = $"Background Meshes/Ship/Light Pointer"

@onready var light_Source_Ship = $"Background Meshes/Ship/OmniLight3D2"
@onready var flashing_Light_Timer = $"Background Meshes/Ship/Flashing Timer"

@onready var ship = $"Background Meshes/Ship"

var center_Vision = Vector2(0,0)
var target_Vision = Vector2(0,0)
var screen_Size = DisplayServer.screen_get_size() #DisplayServer.screen_get_size()

var max_X_Value = null
var max_Y_Value = null


var cam_Offset: Vector2
var min_Offset = -200
var max_Offset = 200

var flash_Cycle_Ship = 0
var flash_Light_On = false
var flash_Ship_Power = null

var ship_Lerp_Position = null
var ship_Init_Position = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_Vision = Elements_Control_Position
	target_Vision = center_Vision
	CRT_Filter.visible = true
	
	flash_Ship_Power = light_Source_Ship.light_energy
	
	ship_Init_Position = ship.position
	ship_Lerp_Position = ship.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#cam_Offset = (get_viewport().get_mouse_position() - Elements_Control_Position) * 0.5
	#cam_Offset.x = clamp(cam_Offset.x, min_Offset, max_Offset)
	#cam_Offset.y = clamp(cam_Offset.y, min_Offset, max_Offset)
	
	#camera.position = lerp(camera.position, originalPosition.position + cam_Offset, delta * 1)
	
	
	spotlight_For_Ship.look_at(light_Pointer.global_position)
	
	#Elements_Control_Position = lerp(center_Vision, target_Vision + get_viewport().get_mouse_position(), delta * 2)
	Elements_Control_Position = target_Vision + get_viewport().get_mouse_position()
	
	# should just idly move the ship so the title screen is less static
	ship.position = lerp(ship.position, ship_Lerp_Position, delta * 0.1)
	
	
	
	
	
	
	
	pass


# Goal: Make it so that the camera pans depending on location of mouse


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.


func _on_test_timer_timeout() -> void:
	#print(get_viewport().get_mouse_position())
	print(Elements_Control_Position)
	pass # Replace with function body.


func _on_flashing_timer_timeout() -> void:
	var num_Of_Flashes = randi_range(3, 8)
	
	if flash_Light_On == true:
		if flash_Cycle_Ship < num_Of_Flashes:
			if flash_Cycle_Ship % 2 == 0:
				light_Source_Ship.light_energy = flash_Ship_Power
			elif flash_Cycle_Ship % 2 ==1:
				light_Source_Ship.light_energy = 0
			flashing_Light_Timer.start(0.05)
			flash_Cycle_Ship += 1
		else:
			flash_Light_On = false
			flash_Cycle_Ship = 0
	elif flash_Light_On == false:
		light_Source_Ship.light_energy = flash_Ship_Power
		var lightTime = randi_range(3, 9)
		flash_Light_On = true
		flashing_Light_Timer.start(lightTime)
	#print("timer working")
	pass # Replace with function body.


func _on_ship_lerp_pos_change_timeout() -> void:
	var sLP_x = ship_Init_Position.x + randf_range(-2.0, 2.0)
	var sLP_y = ship_Init_Position.y + randf_range(-1.0, 1.0)
	var sLP_z = ship_Init_Position.z + randf_range(-1.0, 1.0)
	ship_Lerp_Position = Vector3(sLP_x, sLP_y, sLP_z)
	print(ship_Lerp_Position)
	pass # Replace with function body.
