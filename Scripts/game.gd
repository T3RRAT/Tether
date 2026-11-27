extends Node3D

var buttonInteract = false
var inRight = false
var inLeft = false
var pulsing = false
var monsterActive = false
var captchaActive = false
var doorClose = false

var computerButtonOrgPos = null
var computerButtonLerpIn = null
var computerButtonLerpOut = null

var lButtonOrg
var lButtonLerp
var rButtonOrg
var rButtonLerp

var tut = false


var tether_Power_Drain = 0
var powerTransfering = false

var camLocation = 0
var shipPosition = 0
var computerState = -1
var inCutscene = false
var inUserInterface = false
var called_To_Change = 0

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
@onready var player = $"Player Lerp Position"
@onready var flashSound = $"Ship/Flash Sound"
@onready var door = $Ship/Door
var doorClosePos = null
var doorOpenPos = Vector3(-2,0,2.6)

# Gameplay Important Objects
@onready var camMoveTimer = %"Cam Move Timer"
@onready var powerDrainTimer = %"Power Timer"
@onready var pulse_Timer = $"Player Timers/Pulse Timer"
@onready var pulse_Count = $"Player Timers/Pulse Count Timer"
var pulseCount = 0

# CSG Items

# Mesh crazy, these are put into an array or directory in godot stuff and accessed through it
@onready var l1 = $"Cosmic Web/Layer1"
@onready var l2 = $"Cosmic Web/Layer2"
@onready var l3 = $"Cosmic Web/Layer3"
@onready var l4 = $"Cosmic Web/Layer4"
@onready var l5 = $"Cosmic Web/Layer5"
@onready var l6 = $"Cosmic Web/Layer6"
@onready var l7 = $"Cosmic Web/Layer7"
@onready var l8 = $"Cosmic Web/Layer8"
@onready var l9 = $"Cosmic Web/Layer9"

var meshArray

# Computer Objects
@onready var computer = $"Computer Items/Computer"
@onready var computerDownPos = $"Computer Items/Computer Down Pos"
@onready var computerUpPos = $"Computer Items/Computer Up Pos"

# 2D Objects
@onready var buttonLeft = $"2D Overlay/Control/CanvasLayer/Left Button"
@onready var buttonRight = $"2D Overlay/Control/CanvasLayer/Right Button"
@onready var buttonComputer = $"2D Overlay/Control/CanvasLayer/ComputerButton"


@onready var cosmic_web = $"Cosmic Web Full"

var darkColour = Color.BLACK
var lightColour = Color.WHITE_SMOKE
var scanningWebMaterial = StandardMaterial3D.new()
var notScanningMaterial = StandardMaterial3D.new()
@onready var cosmic_web_colour_ctrl = $SubViewport/ColorRect
var colourMult = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lightLeft.light_energy = 0
	lightRight.light_energy = 0
	
	monsterOne.position = monsterPositionInactive.position
	#monsterActivityTimer.start()
	
	computerButtonOrgPos = buttonComputer.position
	computerButtonLerpIn = computerButtonOrgPos + Vector2(0, 580)
	computerButtonLerpOut =computerButtonOrgPos - Vector2(0, 300)
	
	lButtonOrg = buttonLeft.position
	rButtonOrg = buttonRight.position
	
	lButtonLerp = buttonLeft.position + Vector2(-120, 0)
	rButtonLerp = buttonRight.position + Vector2(120, 0)
	
	# used later for accessing each layer of the mesh
	meshArray = {
		"l1": l1,
		"l2": l2,
		"l3": l3,
		"l4": l4,
		"l5": l5,
		"l6": l6,
		"l7": l7,
		"l8": l8,
		"l9": l9
	}
	
	
	
	doorClosePos = door.global_position
	doorOpenPos = doorClosePos - Vector3(1.5, 0, 0)
	
	#print(rad_to_deg(1))
	
	
	scanningWebMaterial.emission_enabled = true
	scanningWebMaterial.emission_texture = cosmic_web_colour_ctrl
	
	notScanningMaterial.emission_enabled = true
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Use later for maybe a final stage bg
	#cosmic_web.rotation = lerp_angle(cosmic_web.rotation, )
	
	
	# Camera Locations
	if camLocation == 0:
		playerRotationSetter(0)
		inLeft = false
		inRight = false
	elif camLocation == 1:
		playerRotationSetter(1)
		inRight = true
	elif camLocation == -1:
		playerRotationSetter(-1)
		inLeft = true
	elif camLocation == 2: # Location 2 refers to back of ship
		inLeft = true
		inRight = true
		playerRotationSetter(2)
	elif camLocation == 10: # In Computer
		inLeft = true
		inRight = true
	
	
	#while inLeft == true:
		#if player.rotation:
			#
			#pass
		#pass
	
	# when mouse is on left side of screen
	# slowly move player left (rotate -)
	# only if player rotation is not -90 or below.
	
	
	# Handles Pulsing
	if pulsing == true:
		pass
	
	
	# Handles Cosmic Space Mesh
	if pulseCount == 0:
		colourMult = 255
	elif pulseCount > 0:
		colourMult = lerp(colourMult, 0, delta * 2)
		cosmic_web_colour_ctrl.modulate = Color(colourMult,colourMult,colourMult)
	
	
	match pulseCount:
		0:
			# all materials shall be dark
			l1.material_override = notScanningMaterial
			l2.material_override = notScanningMaterial
			l3.material_override = notScanningMaterial
			l4.material_override = notScanningMaterial
			l5.material_override = notScanningMaterial
			l6.material_override = notScanningMaterial
			l7.material_override = notScanningMaterial
			l8.material_override = notScanningMaterial
			l9.material_override = notScanningMaterial
		1:
			# First layer begins
			l1.material_override = scanningWebMaterial
		2:
			# 2nd Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
		3:
			# 3rd Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
			l3.material_override = scanningWebMaterial
		4:
			# 4th Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
			l3.material_override = scanningWebMaterial
			l4.material_override = scanningWebMaterial
		5:
			# 5th Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
			l3.material_override = scanningWebMaterial
			l4.material_override = scanningWebMaterial
			l5.material_override = scanningWebMaterial
		6:
			# 6th Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
			l3.material_override = scanningWebMaterial
			l4.material_override = scanningWebMaterial
			l5.material_override = scanningWebMaterial
			l6.material_override = scanningWebMaterial
		7:
			# 7th Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
			l3.material_override = scanningWebMaterial
			l4.material_override = scanningWebMaterial
			l5.material_override = scanningWebMaterial
			l6.material_override = scanningWebMaterial
			l7.material_override = scanningWebMaterial
		8:
			# 8th Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
			l3.material_override = scanningWebMaterial
			l4.material_override = scanningWebMaterial
			l5.material_override = scanningWebMaterial
			l6.material_override = scanningWebMaterial
			l7.material_override = scanningWebMaterial
			l8.material_override = scanningWebMaterial
		9:
			# 9th Layer
			l1.material_override = scanningWebMaterial
			l2.material_override = scanningWebMaterial
			l3.material_override = scanningWebMaterial
			l4.material_override = scanningWebMaterial
			l5.material_override = scanningWebMaterial
			l6.material_override = scanningWebMaterial
			l7.material_override = scanningWebMaterial
			l8.material_override = scanningWebMaterial
			l9.material_override = scanningWebMaterial
	
	
	
	# Handle Camera Buttons
	if inRight == true:
		buttonRight.position = lerp(buttonRight.position, rButtonLerp, delta * 6)
		if computerState != 1:
			buttonComputer.position = lerp(buttonComputer.position, computerButtonLerpOut, delta * 6)
	if inLeft == true:
		buttonLeft.position = lerp(buttonLeft.position, lButtonLerp, delta * 6)
		if computerState != 1:
			buttonComputer.position = lerp(buttonComputer.position, computerButtonLerpOut, delta * 6)
	if not inLeft and not inRight:
		buttonLeft.position = lerp(buttonLeft.position, lButtonOrg, delta * 6)
		buttonRight.position = lerp(buttonRight.position, rButtonOrg, delta * 6)
	
	
	
	# Handling Player Camera
	cam.rotation.x = lerp_angle(cam.rotation.x, player.rotation.x, 0.2)
	cam.rotation.y = lerp_angle(cam.rotation.y, player.rotation.y, 0.2)
	cam.rotation.z = lerp(cam.rotation.z, player.rotation.z, 0.1)
	
	# Debug Command
	if Input.is_action_just_pressed("Check"):
		#print(player.rotation.y)
		#print("^ = player rotation")
		#print("below is cam rotation")
		#print(cam.rotation.y)
		print("Cam location = %d" % camLocation)
		pulseCount = 1
		
	
	
	
	
	
	# Handles Door Closing and Openning
	if doorClose == true:
		door.global_position = lerp(door.global_position, doorClosePos, 0.2)
	elif doorClose == false:
		door.global_position = lerp(door.global_position, doorOpenPos, 0.2)
	
	
	
	# Handling Pulse Mechanic and Inputs
	if Input.get_action_strength("Confirm Action"):
		if camLocation == 0 && (pulsing == false):
			if inCutscene == false && inUserInterface == false:
				lightLeft.light_energy = 40
				lightRight.light_energy = 40
				pulsing = true
				
				flashSound.play(0.38) # Number is here to make sure flash sound isnt delayed
				pulse_Timer.start()
				checkMonster()
		elif inUserInterface == true && called_To_Change <= 0:
			called_To_Change = called_To_Change + 1
			computer.call("callChangeTrueShipPosition")
			captchaActive = true
		# If we facing the back, we shall close da door
		# not sure why this isnt working
		elif camLocation == 2 && buttonInteract == false:
			# alternate door location and activate a variable saying that security power is draining from dis
			doorClose = !doorClose
			interactionMade()
			print(doorClose)
			
	else:
		lightLeft.light_energy = lerp(lightLeft.light_energy, 0.0, delta * 6)
		lightRight.light_energy = lerp(lightRight.light_energy, 0.0, delta * 6)
	
	if Input.is_action_just_pressed("Go Left"):
		if inCutscene == false && buttonInteract == false:
			if inUserInterface:
				if captchaActive == false:
					computer.call("changeComputerTab", -1)
				pass
			elif inLeft == false:
				camLocation -= 1
				interactionMade()
	
	if Input.is_action_just_pressed("Go Right"):
		if inCutscene == false && buttonInteract == false:
			if inUserInterface:
				computer.call("changeComputerTab", 1)
				pass
			elif inRight == false:
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
		if (camLocation == 0 || camLocation == 10) && buttonInteract == false:
			computerState = computerState * -1
			if inLeft == false:
				inLeft = true
				inRight = true
			else:
				inLeft = false
				inRight = false
			interactionMade()
			
		
	
	
	
	# Computer Functionality
	if computerState == 1:
		computer.position.y = lerp(computer.position.y, computerDownPos.position.y, delta * 6)
		buttonComputer.position = lerp(buttonComputer.position, computerButtonLerpIn, delta * 6)
		
		#buttonLeft.position = lerp(buttonLeft.position, lButtonLerp, delta * 6)
		#buttonRight.position = lerp(buttonRight.position, rButtonLerp, delta * 6)
		
		camLocation = 10
		inUserInterface = true
	else:
		computer.position.y = lerp(computer.position.y, computerUpPos.position.y, delta * 6)
		buttonComputer.position = lerp(buttonComputer.position, computerButtonOrgPos, delta * 6)
		
		if camLocation == 10:
				camLocation = 0
		#buttonLeft.position = lerp(buttonLeft.position, lButtonOrg, delta * 6)
		#buttonRight.position = lerp(buttonRight.position, rButtonOrg, delta * 6)
		
		
		inUserInterface = false
	
	# Computer Tab Switching Using Number Keys
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
	if location == 0:
		player.rotation_degrees = Vector3(15, 0, 0)
	elif location == -1:
		player.rotation_degrees = Vector3(7.5, 90, 0)
	elif location == 1:
		player.rotation_degrees = Vector3(7.5, -110, 0)
	elif location == 2:
		player.rotation_degrees = Vector3(0, 180, 0)
	else: # yo what even is this shipPosition times location even for
		player.rotation_degrees = Vector3(0, 0, shipPosition * location)

func interactionMade():
	buttonInteract = true
	camMoveTimer.start()

func updateCamera():
	#player.rotation_degrees = Vector3(0, player.rotation_degrees + mouse, 0)
	pass


# Functions that are called by inner scenes. i really need to learn if there is some better way of doing this
func clickCap_Computer_Game():
	called_To_Change = 0












func _on_left_button_mouse_entered() -> void:
	if (buttonInteract == false) && (inUserInterface == false):
		#player.rotate(Vector3.UP, player.rotation.y + 90)
		#player.rotation.y = angle_difference(player.rotation.y, player.rotation.y + 90)
		interactionMade()
		camLocation = camLocation - 1
		#inLeft = true
		pass
	pass # Replace with function body.


func _on_right_button_mouse_entered() -> void:
	if (buttonInteract == false) && (inUserInterface == false):
		#player.rotation.y = angle_difference(player.rotation.y, player.rotation.y - 90)
		#player.rotate(Vector3.DOWN, player.rotation.y - 90)
		interactionMade()
		camLocation = camLocation + 1
		#if player.rotation.y < 90:
			#player.rotation_degrees = Vector3(0, player.rotation.y - 1, 0)
		#inRight = true
		pass
	pass # Replace with function body.


func _on_cam_move_timer_timeout() -> void:
	buttonInteract = false
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
		elif lvStatus.begins_with("s"):
			
			pass
		elif lvStatus.begins_with("A"):
			
			pass
	pass # Replace with function body.

func _on_monster_disappear_timeout() -> void:
	monsterOne.global_position = monsterPositionInactive.global_position
	print("back to original position")


func _on_up_button_mouse_entered() -> void:
	if (camLocation == 0 || camLocation == 10) && buttonInteract == false:
			computerState = computerState * -1
			if computerState == -1:
				camLocation = 0
			interactionMade()


func _on_pulse_timer_timeout() -> void:
	pulsing = false
	
	pulse_Timer.stop()
	
	print("pulse finish")


func _on_pulse_count_timer_timeout() -> void:
	pulseCount += 1
