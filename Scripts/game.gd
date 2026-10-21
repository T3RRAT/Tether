extends Node3D

var buttonInteract = false
var farRight = false
var farLeft = false
var flashing = false
var monsterActive = false

var tut = false

var powerDrain = 1
var powerDrainSpeed = 5
var flashPowerDrain = 10

var samplesCollected = 0

var systemsPower = 100
var collectionPower = 100
var tetherPower = 100
var reservePower = 100

var camLocation = 0
var shipPosition = 0
var computerState = -1
var inCutscene = false
var inUserInterface = false

var lvStatus = "normal"
var session = 0
var monsterAI = 20
var monsterAggroAmount = 0

# Monster 1 Objects
@onready var monsterOne = $"Monster1 Items/Monster"
@onready var monsterPositionActive = $"Monster1 Items/Active Position"
@onready var monsterPositionInactive = $"Monster1 Items/Inactive Position"
@onready var monsterKillTimer = $"Monster1 Items/Monster1 Timers/Monster Kill"
@onready var monsterActivityTimer = $"Monster1 Items/Monster1 Timers/Monster Timer"
@onready var monsterDisappearTimer = $"Monster1 Items/Monster1 Timers/Monster Disappear"
@onready var mon1AudioCue = $"Monster1 Items/AudioCue"


# Player and Ship Objects
@onready var cam = $"Player Camera"
@onready var tCam = $"Tether Camera"
@onready var lightRight = %FlashLightRight
@onready var lightLeft = %FlashLightLeft
@onready var player = $Player
@onready var flashSound = $"Player/Flash Sound"

# Gameplay Important Objects
@onready var camMoveTimer = %"Cam Move Timer"
@onready var powerDrainTimer = %"Power Timer"


# Computer Objects
@onready var computer = $"Computer Items/Computer"
@onready var computerDownPos = $"Computer Items/Computer Down Pos"
@onready var computerUpPos = $"Computer Items/Computer Up Pos"

# 2D Objects
@onready var buttonLeft = $"2D Overlay/Control/CanvasLayer/Left Button"
@onready var buttonRight = $"2D Overlay/Control/CanvasLayer/Right Button"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	powerDrainTimer.start(powerDrainSpeed)
	lightLeft.light_energy = 0
	lightRight.light_energy = 0
	
	monsterOne.position = monsterPositionInactive.position
	monsterActivityTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Camera Locations
	if camLocation == 1:
		farRight = true
		playerRotationSetter(1)
		computerState = -1
		#player.rotation_degrees = Vector3(0, -90, 0)
		#relocateShip(1)
	if camLocation == -1:
		farLeft = true
		playerRotationSetter(-1)
		computerState = -1
		#player.rotation_degrees = Vector3(0, 90, 0)
		#relocateShip(-1)
	if camLocation == 0:
		farLeft = false
		farRight = false
		playerRotationSetter(0)
		#player.rotation_degrees = Vector3(0, 0, 0)
		#relocateShip(0)
	if camLocation == 2: # Location 2 refers to back of ship
		farLeft = true
		farRight = true
		playerRotationSetter(2)
		pass

	
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
	cam.rotation.z = lerp(cam.rotation.z, player.rotation.z, 0.1)
	
	# Debug Command
	if Input.is_action_just_pressed("Check"):
		#print(player.rotation.y)
		#print("^ = player rotation")
		#print("below is cam rotation")
		#print(cam.rotation.y)
		print("Cam location = %d" % camLocation)
	
	
	# Handle Power
	
	
	
	
	
	# Handling Flashing Mechanic and Inputs
	if Input.get_action_strength("Confirm Action") && (flashing == false) && (camLocation == 0):
		if inCutscene == false && inUserInterface == false:
			systemsPower = systemsPower - flashPowerDrain
			lightLeft.light_energy = 40
			lightRight.light_energy = 40
			flashing = true
			flashSound.play(0.38) # Number is here to make sure flash sound isnt delayed
			checkMonster()
		elif inUserInterface == true:
			computer.call("callChangeTrueShipPosition")
	else:
		lightLeft.light_energy = lerp(lightLeft.light_energy, 0.0, delta * 6)
		lightRight.light_energy = lerp(lightRight.light_energy, 0.0, delta * 6)
	
	if Input.is_action_just_pressed("Go Left"):
		if inCutscene == false && buttonInteract == false:
			if inUserInterface:
				computer.call("changeComputerTab", -1)
				pass
			elif farLeft == false:
				camLocation -= 1
				interactionMade()
	
	if Input.is_action_just_pressed("Go Right"):
		if inCutscene == false && buttonInteract == false:
			if inUserInterface:
				computer.call("changeComputerTab", 1)
				pass
			elif farRight == false:
				camLocation += 1
				interactionMade()
	
	if Input.is_action_just_pressed("Go Backwards"):
		if buttonInteract == false:
			
			if camLocation == 0:
				camLocation = 2
				interactionMade()
			elif camLocation == 2:
				camLocation = 0
				interactionMade()
			# Location 2 refers to back of ship
	
	
	if Input.is_action_just_pressed("Flip Computer"):
		if camLocation == 0 && buttonInteract == false:
			computerState = computerState * -1
			if farLeft == false:
				farLeft = true
				farRight = true
			else:
				farLeft = false
				farRight = false
			interactionMade()
			
		
	
	
	
	# Computer Functionality
	if computerState == 1:
		computer.position.y = lerp(computer.position.y, computerDownPos.position.y, delta * 6)
		inUserInterface = true
	else:
		computer.position.y = lerp(computer.position.y, computerUpPos.position.y, delta * 6)
		inUserInterface = false
	
	
	if Input.is_action_just_pressed("One"):
		computer.call("callChangeShipPosition", 1)
	
	if Input.is_action_just_pressed("Two"):
		computer.call("callChangeShipPosition", 2)
	
	if Input.is_action_just_pressed("Three"):
		computer.call("callChangeShipPosition", 3)
	
	pass



# Custom Functions
func monsterSpawn(): 
	print("monster attacks")
	# Spawn Monster
	# Start time till death timer
	# If timer ends 
	# then player dies and death animation into tp into death screen
	# Else if player avoids Death 
	# sound plays aknowledging threat is gone and animation f them going away plays
	# Also if you flash the other monster you cna see them slightly but they wont move
	# thos this is more otherthing
	monsterActive = true
	mon1AudioCue.play()
	monsterOne.global_position = monsterPositionActive.global_position
	monsterKillTimer.start()
	
	pass

func secondMonsterSpawn():
	# Generate a a random number from 1 to 3
	# Spawn second Monster at location based off of rng
	# Start kill timer for second monster
	# If player repositions
	# Then player survives
	# Else
	# Play animation and kill player, send to death screen.
	
	var location = randi_range(1,3)
	

func checkMonster():
	if monsterActive == true:
		print("its a monsta!")
		monsterActive = false
		monsterDisappearTimer.start()
		pass

func relocateShip(positionRelocate):
	player.rotation.z = 1.2 * (shipPosition - position)
	shipPosition = positionRelocate
	pass

func playerRotationSetter(location):
	if location == 1:
		player.rotation_degrees = Vector3(0, -90, -5)
	elif location == -1:
		player.rotation_degrees = Vector3(0, 90, 5)
	elif location == 2:
		player.rotation_degrees = Vector3(0, 180, 0)
	else:
		player.rotation_degrees = Vector3(0, 0, shipPosition * location)

func interactionMade():
	buttonInteract = true
	camMoveTimer.start()








func _on_left_button_mouse_entered() -> void:
	if (buttonInteract == false) && (inUserInterface == false):
		#player.rotate(Vector3.UP, player.rotation.y + 90)
		#player.rotation.y = angle_difference(player.rotation.y, player.rotation.y + 90)
		interactionMade()
		camLocation = camLocation - 1
	pass # Replace with function body.


func _on_right_button_mouse_entered() -> void:
	if (buttonInteract == false) && (inUserInterface == false):
		#player.rotation.y = angle_difference(player.rotation.y, player.rotation.y - 90)
		#player.rotate(Vector3.DOWN, player.rotation.y - 90)
		interactionMade()
		camLocation = camLocation + 1
	pass # Replace with function body.


func _on_cam_move_timer_timeout() -> void:
	buttonInteract = false
	pass # Replace with function body.


func _on_flash_sound_finished() -> void:
	flashing = false
	pass # Replace with function body.


func _on_monster_timer_timeout() -> void:
	monsterAggroAmount += randi_range(10, monsterAI)
	if monsterAggroAmount > 20:
		monsterSpawn()
		monsterAggroAmount = 0
	monsterActivityTimer.start()
	pass # Replace with function body.


func _on_monster_kill_timeout() -> void:
	if monsterActive == true:
		if lvStatus.begins_with("n"):
			get_tree().change_scene_to_file("res://Scenes/game_over_normal.tscn")
			pass
		elif lvStatus.begins_with("s"):
			
			pass
		elif lvStatus.begins_with("A"):
			
			pass
	pass # Replace with function body.


func _on_power_timer_timeout() -> void:
	if collectionPower > 0:
		samplesCollected += 1
	collectionPower = collectionPower - powerDrain
	
	
	powerDrainTimer.start(powerDrainSpeed)
	#print("Collection Power: %d" % collectionPower)
	#print("Systems Power: %d" % systemsPower)
	
	pass # Replace with function body.


func _on_monster_disappear_timeout() -> void:
	monsterOne.global_position = monsterPositionInactive.global_position
	print("Should return to original position")
	pass # Replace with function body.


func _on_up_button_mouse_entered() -> void:
	if camLocation == 0 && buttonInteract == false:
			computerState = computerState * -1
			interactionMade()
	pass # Replace with function body.
