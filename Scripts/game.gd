extends Node3D

var buttonInteract = false
var farRight = false
var farLeft = false
var flashing = false
var monsterActive = false

var points = 0
var camLocation = 0
var monsterAI = 20
var monsterAggroAmount = 0

@onready var cam = $"Player Camera"
@onready var light = %FlashLight
@onready var player = $Player
@onready var camMoveTimer = $"Cam Move Timer"
@onready var flashSound = $"Player/Flash Sound"

@onready var buttonLeft = $"2D Overlay/Control/Left Button"
@onready var buttonRight = $"2D Overlay/Control/Right Button"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if camLocation == 1:
		farRight = true
		player.rotation_degrees = Vector3(0, -90, 0)
	if camLocation == -1:
		farLeft = true
		player.rotation_degrees = Vector3(0, 90, 0)
	if camLocation == 0:
		farLeft = false
		farRight = false
		player.rotation_degrees = Vector3(0, 0, 0)

	
	# Handle Camera Buttons
	if farRight == true:
		buttonRight.visible = false
	if farLeft == true:
		buttonLeft.visible = false
	if not farLeft and not farRight:
		buttonLeft.visible = true
		buttonRight.visible = true
	
	# Handling Player Camera
	cam.rotation.y = lerp_angle(cam.rotation.y, player.rotation.y, 0.2)
	
	if Input.get_action_strength("Check"):
		print(player.rotation.y)
		print("^ = player rotation")
		print("below is cam rotation")
		print(cam.rotation.y)
		print(camLocation)
	
	# Handling Flashing Mechanic and Inputs
	if Input.get_action_strength("ui_accept") && flashing == false && camLocation == 0:
		light.light_energy = 40
		flashing = true
		flashSound.play(0.38)
		checkMonster()
	else:
		light.light_energy = lerp(light.light_energy, 0.0, delta * 6)
	pass

# Custom Functions
func monsterAttack():
	print("monster attacks")
	pass

func checkMonster():
	if monsterActive == true:
		print("its a monsta!")
		pass








func _on_left_button_mouse_entered() -> void:
	if (buttonInteract == false):
		print("mouse entered Left Body")
		#player.rotate(Vector3.UP, player.rotation.y + 90)
		#player.rotation.y = angle_difference(player.rotation.y, player.rotation.y + 90)
		buttonInteract = true
		camLocation = camLocation - 1
		camMoveTimer.start()
	pass # Replace with function body.


func _on_right_button_mouse_entered() -> void:
	if (buttonInteract == false):
		print("mouse entered Right Body")
		#player.rotation.y = angle_difference(player.rotation.y, player.rotation.y - 90)
		#player.rotate(Vector3.DOWN, player.rotation.y - 90)
		buttonInteract = true
		camLocation = camLocation + 1
		camMoveTimer.start()
	pass # Replace with function body.


func _on_cam_move_timer_timeout() -> void:
	buttonInteract = false
	pass # Replace with function body.


func _on_flash_sound_finished() -> void:
	flashing = false
	pass # Replace with function body.


func _on_monster_timer_timeout() -> void:
	monsterAggroAmount += randi_range(1, monsterAI)
	if monsterAggroAmount > 5:
		monsterAttack()
	pass # Replace with function body.
