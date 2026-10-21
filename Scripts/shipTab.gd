extends TextureRect

var dragging = false
var of = Vector2(0.0,0.0)


@onready var shipHovering = $"Ship/Hovering Colour"
@onready var ShipIcon = $Ship
@onready var pos1 = $Pos1.position
@onready var pos2 = $Pos2.position
@onready var pos3 = $Pos3.position
@onready var shipLerpPos = $Ship/ShipLerpPos.position
@onready var trueShipPos = $"True Ship Position".position


@onready var aniPlayer = $"../../AnimationPlayer"


@onready var game = $"../../../../../.."
@onready var tabs = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		ShipIcon.position = get_local_mouse_position() - of
		#shipHovering.color = Color(shipHovering.color, 5)
		# could be cool for like a horro effect of it being a face when moved
		ShipIcon.self_modulate = Color.DIM_GRAY
		
		if abs(ShipIcon.position.x - pos1.x) < abs(ShipIcon.position.x - pos2.x):
			# Lerp Draggable Ship to position 1
			shipLerpPos = pos1
		# Else If Draggable Ship is closer to position 3 compared to position 2
		elif abs(ShipIcon.position.x - pos3.x) < abs(ShipIcon.position.x - pos2.x):
			# Lerp Draggable Ship to position 3
			shipLerpPos = pos3
		# Else If Draggable Ship isn't closer to pos 1 or pos 3 compared to pos 2
		else:
			# Lerp shipLerpPos obj to pos2
			shipLerpPos = pos2
	else:
		# If the Draggable Ship is closer to position 1 compared to position 2
		if abs(shipLerpPos.x - pos1.x) < abs(shipLerpPos.x - pos2.x):
			# Lerp Draggable Ship to position 1
			ShipIcon.position = lerp(ShipIcon.position, shipLerpPos, delta * 6)
		# Else If Draggable Ship is closer to position 3 compared to position 2
		elif abs(shipLerpPos.x - pos3.x) < abs(shipLerpPos.x - pos2.x):
			# Lerp Draggable Ship to position 3
			ShipIcon.position = lerp(ShipIcon.position, shipLerpPos, delta * 6)
		# Else If Draggable Ship isn't closer to pos 1 or pos 3 compared to pos 2
		else:
			# Lerp Draggable Ship to position 2
			ShipIcon.position = lerp(ShipIcon.position, shipLerpPos, delta * 6)
			
		#shipHovering.color = Color(shipHovering.color, 0)
		if shipLerpPos == trueShipPos:
			ShipIcon.self_modulate = Color.WHITE
		else:
			ShipIcon.self_modulate = Color.BLUE_VIOLET
	
	
	
	
	
	pass


func _on_ship_button_down() -> void:
	dragging = true
	of = get_local_mouse_position() - ShipIcon.position
	pass # Replace with function body.
	
func _on_ship_button_up() -> void:
	dragging = false
	pass # Replace with function body.




func confirmRepositionMinigame():
	var minigameType = randi_range(1, 10)
	match minigameType:
		# go on neal.fun to see captcha game for ideas for some very diabolical ones
		# among us tasks can work here
		1:
			print("Forsaken Generator Puzzle")
		2:
			print("Minesweeper")
			# Fredsweeper frank where are youuuuu
		3: 
			print("Click Box Captcha")
		4:
			print("Select What Applies Captcha")
		5:
			print("Wavy Text Captcha")
		6:
			print("Math")
			#Statistics, #Calculus, #IHateMyself
		7:
			print("Scratch Coding")
		8:
			print("Type To Confirm")
		9:
			print("Adjust Counter")
		10:
			print("Fix Wires")
	trueShipPos = shipLerpPos
	pass


func changeShipPosition(location):
	if tabs.current_tab == 1:
		if location == 1:
			shipLerpPos = pos1
		elif location == 2:
			shipLerpPos = pos2
		elif location == 3:
			shipLerpPos = pos3
	
	print("changed!")
	pass

func changeTrueShipPosition(location):
	#if location == 1:
		#trueShipPos = pos1
	#elif location == 2:
		#trueShipPos = pos2
	#elif location == 3:
		#trueShipPos = pos3
	confirmRepositionMinigame()
	pass

func confirmPosition():
	trueShipPos = shipLerpPos
	pass
