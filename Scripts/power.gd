extends TextureRect

var drop_Down_Menu_Active = false
var mitesActive = false

@onready var p_drain_Timer = $"Power Drain Timer"
@onready var uiCount_Timer = $"UI Timer"

@onready var inner_Menu = $"Drop Down/Inner Menu"
@onready var computer = $"../../../.."
@onready var dropDown_Button = $"Drop Down"

@onready var systems_Power = $"Drop Down/Inner Menu/SystemsL"
@onready var systems_Pr = $"Drop Down/Inner Menu/SystemsL/SystemsR"

@onready var collection_Power = $"Drop Down/Inner Menu/CollectionL"
@onready var collection_Pr = $"Drop Down/Inner Menu/Collection/CollectionR"

@onready var security_Power = $"Drop Down/Inner Menu/SecurityL"
@onready var security_Pr = $"Drop Down/Inner Menu/SecurityL/SecurityR"

@onready var communications_Power = $"Drop Down/Inner Menu/CommsL"
@onready var communications_Pr = $"Drop Down/Inner Menu/CommsL/CommsR"

@onready var tether_Power = $"Drop Down/Inner Menu/Tether Left"
@onready var tether_Pr = $"Drop Down/Inner Menu/Tether Left/Tether Right"
@onready var tether_Text = $"Drop Down/Inner Menu/Tether Left/TetherText"

@onready var transfer_Button = $"Drop Down/Inner Menu/Transfer Power"

@onready var wireOrg = $"Drop Down/WireOrigin"
@onready var wire = $"Drop Down/WireOrigin/Wire"
@onready var backShip = $"Ship Side Sprite/WireBackShip"

var transferLerpPos
var tetherLerpPos
var systemsLerpPos
var collectionLerpPos
var securityLerpPos
var commsLerpPos

var transferOrigin
var tetherOrigin
var systemsOrigin
var collectionOrigin
var securityOrigin
var commsOrigin


var wireOrgPos
var wireLerpPos


var powerDrainMultipler = 1
var powerDrainSpeed = 0.1

var tetherDrainMultipler = 10

var flashPowerDrain = 1

var charging = false

var charging_Org_Button = null
var chargingOrigin = null

var charging_Des_Button = null
var chargingDestination = null
# Charge destination/origin based on #. 0 = tether, 1 = system, 2 = collection, 3 = security, 4 = comms

var hoveringOver = null
var hovering = false

var samplesCollected = 0

var tetherPower = 100
var systemsPower = 100
var collectionPower = 100
var securityPower = 100
var communicationsPower = 100
var activeSelection = null



var uiCounter = 0

var dropDownOffPos = null
var dropDownOnPos = null
var dropDownOffSize = null
var dropDownOnSize = null

var trans = Color(1,1,1,0)
var notTrans = Color(1,1,1,1)

var normFontColour = Color("dfdfdf")
var originFontColour = Color("c45100")
var destinFontColour = Color("4664ff")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable_Or_Enable_All()
	
	dropDownOnPos = dropDown_Button.position
	dropDownOffPos = dropDown_Button.position + Vector2(0, 100)
	
	dropDownOnSize = dropDown_Button.size
	dropDownOffSize = Vector2(304, 58)
	
	wireOrgPos = wireOrg.position
	wireLerpPos = wireOrg.position - Vector2(58,0)
	
	
	p_drain_Timer.wait_time = powerDrainSpeed
	
	
	systemsLerpPos = systems_Power.position
	collectionLerpPos = collection_Power.position
	securityLerpPos = security_Power.position
	commsLerpPos = communications_Power.position
	tetherLerpPos = tether_Power.position
	transferLerpPos = transfer_Button.position
	
	systemsOrigin = systems_Power.position - Vector2(0, 36)
	collectionOrigin = collection_Power.position - Vector2(0, 36*2)
	securityOrigin = security_Power.position - Vector2(0, 36*3)
	commsOrigin = communications_Power.position - Vector2(0, 36*4)
	tetherOrigin = tether_Power.position - Vector2(69, 0)
	transferOrigin = transfer_Button.position - Vector2(117, 0)
	
	
	
	inner_Menu.modulate = trans
	
	
	
	systems_Power.position = systemsOrigin
	collection_Power.position = collectionOrigin
	security_Power.position = securityOrigin
	communications_Power.position = commsOrigin
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# wait a second I can use emojis? 👍😘😘👌😊😊😂🤣❤️😍😒🙌👌🤷‍♀️🤦‍♀️😉😉😎🤷‍♀️🤷‍♀️🤦‍♀️🤦‍♀️💖💖😜😜😢😢
func _process(delta: float) -> void:
	
	
	#wire.look_at(backShip.position)
	wire.look_at(backShip.global_position)
	
	
	# Power of each individual system
	systems_Power.text = ("Systems : %d" % round(systemsPower))
	collection_Power.text = ("Collect : %d" % round(collectionPower))
	security_Power.text = ("Security: %d" % round(securityPower))
	communications_Power.text = ("Comms   : %d" % round(communicationsPower))
	tether_Text.text = str(snapped(tetherPower, 0.1))
	
	# Scales button that is being hovered on. Else will just lerp them to 1,1 scale
	if true:
		systems_Power.scale = lerp(systems_Power.scale, Vector2(1,1), delta * 7)
		collection_Power.scale = lerp(collection_Power.scale, Vector2(1,1), delta * 7)
		security_Power.scale = lerp(security_Power.scale, Vector2(1,1), delta * 7)
		communications_Power.scale = lerp(communications_Power.scale, Vector2(1,1), delta * 7)
		tether_Power.scale = lerp(tether_Power.scale, Vector2(1,1), delta * 7)
		transfer_Button.scale = lerp(transfer_Button.scale, Vector2(1,1), delta * 7)
	if hovering == true:
		hoveringOver.scale = lerp(hoveringOver.scale, hoveringOver.scale + Vector2(0.1,0.1), delta * 7)
	
	
	# Colour if any item is selected as origin or destination
	if chargingOrigin != null:
		charging_Org_Button.add_theme_color_override("font_color", originFontColour)
	if chargingDestination != null:
		charging_Des_Button.add_theme_color_override("font_color", destinFontColour)
	
	# If the Drop down menu is active, visibility will be turned on and begin lerping
	if drop_Down_Menu_Active == true:
		#systems_Power.position = lerp(sysystems_Power.position, systemsLerpPos)
		dropDown_Button.position = lerp(dropDown_Button.position, dropDownOnPos, delta * 5)
		dropDown_Button.size = lerp(dropDown_Button.size, dropDownOnSize, delta * 5)
		inner_Menu.modulate = notTrans
		
		wireOrg.position = lerp(wireOrg.position, wireOrgPos, delta * 5)
		
		if uiCounter == 0:
			systems_Power.position = lerp(systems_Power.position, systemsLerpPos, delta * 5)
			
			systems_Power.modulate = lerp(systems_Power.modulate, notTrans, delta * 5)
		elif uiCounter <= 1:
			systems_Power.position = lerp(systems_Power.position, systemsLerpPos, delta * 5)
			collection_Power.position = lerp(collection_Power.position, collectionLerpPos, delta * 5)
			
			systems_Power.modulate = lerp(systems_Power.modulate, notTrans, delta * 5)
			collection_Power.modulate = lerp(collection_Power.modulate, notTrans, delta * 5)
		elif uiCounter <= 2:
			systems_Power.position = lerp(systems_Power.position, systemsLerpPos, delta * 5)
			collection_Power.position = lerp(collection_Power.position, collectionLerpPos, delta * 5)
			security_Power.position = lerp(security_Power.position, securityLerpPos, delta * 5)
			
			systems_Power.modulate = lerp(systems_Power.modulate, notTrans, delta * 5)
			collection_Power.modulate = lerp(collection_Power.modulate, notTrans, delta * 5)
			security_Power.modulate = lerp(security_Power.modulate, notTrans, delta * 5)
		elif uiCounter <= 3:
			systems_Power.position = lerp(systems_Power.position, systemsLerpPos, delta * 5)
			collection_Power.position = lerp(collection_Power.position, collectionLerpPos, delta * 5)
			security_Power.position = lerp(security_Power.position, securityLerpPos, delta * 5)
			communications_Power.position = lerp(communications_Power.position, commsLerpPos, delta * 5)
			tether_Power.position = lerp(tether_Power.position, tetherLerpPos, delta * 5)
			
			systems_Power.modulate = lerp(systems_Power.modulate, notTrans, delta * 5)
			collection_Power.modulate = lerp(collection_Power.modulate, notTrans, delta * 5)
			security_Power.modulate = lerp(security_Power.modulate, notTrans, delta * 5)
			communications_Power.modulate = lerp(communications_Power.modulate, notTrans, delta * 5)
			tether_Power.modulate = lerp(tether_Power.modulate, notTrans, delta * 5)
		elif uiCounter <= 4:
			systems_Power.position = lerp(systems_Power.position, systemsLerpPos, delta * 5)
			collection_Power.position = lerp(collection_Power.position, collectionLerpPos, delta * 5)
			security_Power.position = lerp(security_Power.position, securityLerpPos, delta * 5)
			communications_Power.position = lerp(communications_Power.position, commsLerpPos, delta * 5)
			tether_Power.position = lerp(tether_Power.position, tetherLerpPos, delta * 5)
			transfer_Button.position = lerp(transfer_Button.position, transferLerpPos, delta * 5)
			
			systems_Power.modulate = lerp(systems_Power.modulate, notTrans, delta * 5)
			collection_Power.modulate = lerp(collection_Power.modulate, notTrans, delta * 5)
			security_Power.modulate = lerp(security_Power.modulate, notTrans, delta * 5)
			communications_Power.modulate = lerp(communications_Power.modulate, notTrans, delta * 5)
			tether_Power.modulate = lerp(tether_Power.modulate, notTrans, delta * 5)
			transfer_Button.modulate = lerp(transfer_Button.modulate, notTrans, delta * 5)
		
	elif drop_Down_Menu_Active == false:
		
		dropDown_Button.position = lerp(dropDown_Button.position, dropDownOffPos, delta * 5)
		dropDown_Button.size = lerp(dropDown_Button.size, dropDownOffSize, delta * 5)
		
		wireOrg.position = lerp(wireOrg.position, wireLerpPos, delta * 5)
		# Vector2(304, 58)
		if uiCounter == 4:
			systems_Power.position = lerp(systems_Power.position, systemsOrigin, delta * 5)
			collection_Power.position = lerp(collection_Power.position, collectionOrigin, delta * 5)
			security_Power.position = lerp(security_Power.position, securityOrigin, delta * 5)
			communications_Power.position = lerp(communications_Power.position, commsOrigin, delta * 5)
			tether_Power.position = lerp(tether_Power.position, tetherOrigin, delta * 5)
			transfer_Button.position = lerp(transfer_Button.position, transferOrigin, delta * 5)
			inner_Menu.modulate = trans
			
			systems_Power.modulate = lerp(systems_Power.modulate, trans, delta * 5)
			collection_Power.modulate = lerp(collection_Power.modulate, trans, delta * 5)
			security_Power.modulate = lerp(security_Power.modulate, trans, delta * 5)
			communications_Power.modulate = lerp(communications_Power.modulate, trans, delta * 5)
			tether_Power.modulate = lerp(tether_Power.modulate, trans, delta * 5)
			transfer_Button.modulate = lerp(transfer_Button.modulate, trans, delta * 5)
			
		elif uiCounter == 3:
			collection_Power.position = lerp(collection_Power.position, collectionOrigin, delta * 5)
			security_Power.position = lerp(security_Power.position, securityOrigin, delta * 5)
			communications_Power.position = lerp(communications_Power.position, commsOrigin, delta * 5)
			tether_Power.position = lerp(tether_Power.position, tetherOrigin, delta * 5)
			transfer_Button.position = lerp(transfer_Button.position, transferOrigin, delta * 5)
			
			collection_Power.modulate = lerp(collection_Power.modulate, trans, delta * 5)
			security_Power.modulate = lerp(security_Power.modulate, trans, delta * 5)
			communications_Power.modulate = lerp(communications_Power.modulate, trans, delta * 5)
			tether_Power.modulate = lerp(tether_Power.modulate, trans, delta * 5)
			transfer_Button.modulate = lerp(transfer_Button.modulate, trans, delta * 5)
		elif uiCounter == 2:
			security_Power.position = lerp(security_Power.position, securityOrigin, delta * 5)
			communications_Power.position = lerp(communications_Power.position, commsOrigin, delta * 5)
			tether_Power.position = lerp(tether_Power.position, tetherOrigin, delta * 5)
			transfer_Button.position = lerp(transfer_Button.position, transferOrigin, delta * 5)
			
			security_Power.modulate = lerp(security_Power.modulate, trans, delta * 5)
			communications_Power.modulate = lerp(communications_Power.modulate, trans, delta * 5)
			tether_Power.modulate = lerp(tether_Power.modulate, trans, delta * 5)
			transfer_Button.modulate = lerp(transfer_Button.modulate, trans, delta * 5)
		elif uiCounter == 1:
			communications_Power.position = lerp(communications_Power.position, commsOrigin, delta * 5)
			tether_Power.position = lerp(tether_Power.position, tetherOrigin, delta * 5)
			transfer_Button.position = lerp(transfer_Button.position, transferOrigin, delta * 5)
			
			communications_Power.modulate = lerp(communications_Power.modulate, trans, delta * 5)
			tether_Power.modulate = lerp(tether_Power.modulate, trans, delta * 5)
			transfer_Button.modulate = lerp(transfer_Button.modulate, trans, delta * 5)
		elif uiCounter == 0:
			transfer_Button.position = lerp(transfer_Button.position, transferOrigin, delta * 5)
			
			transfer_Button.modulate = lerp(transfer_Button.modulate, trans, delta * 5)
	
	



# Custom Functions

# Location is a string for reading sake. 
func power_Destination_Change(location):
	
	
	match location:
		"systems":
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = systemsPower
			charging_Des_Button = systems_Power
		"collection":
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = collectionPower
			charging_Des_Button = collection_Power
		"security":
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = securityPower
			charging_Des_Button = security_Power
		"comms":
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = communicationsPower
			charging_Des_Button = communications_Power
		"tether":
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = tetherPower
			charging_Des_Button = tether_Power
			print("stuff????")
	pass

func power_Origin_Change(location):
	
	
	match location:
		"systems":
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = systemsPower
			charging_Org_Button = systems_Power
		"collection":
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = collectionPower
			charging_Org_Button = collection_Power
		"security":
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = securityPower
			charging_Org_Button = security_Power
		"comms":
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = communicationsPower
			charging_Org_Button = communications_Power
		"tether":
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = tetherPower
			charging_Org_Button = tether_Power
	pass

func change_Lerp_Positions():
	# Changes lerp position
	inner_Menu.self_modulate = notTrans
	await get_tree().create_timer(0.1)
	
	
	pass

func disable_Or_Enable_All():
	if systems_Power.disabled == false:
		systems_Power.disabled = true
		collection_Power.disabled = true
		security_Power.disabled = true
		communications_Power.disabled = true
		tether_Power.disabled = true
		transfer_Button.disabled = true
		
		systems_Power.mouse_filter = MOUSE_FILTER_IGNORE
		collection_Power.mouse_filter = MOUSE_FILTER_IGNORE
		security_Power.mouse_filter = MOUSE_FILTER_IGNORE
		communications_Power.mouse_filter = MOUSE_FILTER_IGNORE
		tether_Power.mouse_filter = MOUSE_FILTER_IGNORE
		transfer_Button.mouse_filter = MOUSE_FILTER_IGNORE
		
	elif systems_Power.disabled == true:
		systems_Power.disabled = false
		collection_Power.disabled = false
		security_Power.disabled = false
		communications_Power.disabled = false
		tether_Power.disabled = false
		transfer_Button.disabled = false
		
		systems_Power.mouse_filter = MOUSE_FILTER_STOP
		collection_Power.mouse_filter = MOUSE_FILTER_STOP
		security_Power.mouse_filter = MOUSE_FILTER_STOP
		communications_Power.mouse_filter = MOUSE_FILTER_STOP
		tether_Power.mouse_filter = MOUSE_FILTER_STOP
		transfer_Button.mouse_filter = MOUSE_FILTER_STOP

# Functions Called by other scenes
func mites_Activity_Changed():
	mitesActive = !mitesActive
	print(mitesActive)




# Auto Functions
func _on_drop_down_pressed() -> void:
	# holy shit am i genius? this is like, better than 2 if statements
	uiCounter = 0
	uiCount_Timer.start()
	drop_Down_Menu_Active  = !drop_Down_Menu_Active
	disable_Or_Enable_All()
	print("pressed the button")
	pass # Replace with function body.


func _on_power_drain_timer_timeout() -> void:
	systemsPower -= 0.1 * powerDrainMultipler
	collectionPower -= 0.1 * powerDrainMultipler
	securityPower -= 0.1 * powerDrainMultipler
	communicationsPower -= 0.1 * powerDrainMultipler
	
	#tetherPower -= 0.1 * powerDrainMultipler
	
	


func _on_power_charge_timer_timeout() -> void:
	if charging == true:
		chargingDestination += 0.2 * tetherDrainMultipler
		chargingOrigin -= 0.2 * tetherDrainMultipler
		#match chargingDestination:
			#tetherPower:
				## Tether
				#chargingDestination += 0.2 * tetherDrainMultipler
				#chargingOrigin -= 0.2 * tetherDrainMultipler
			#systemsPower:
				## Systems
				##tetherPower -= 0.2 * tetherDrainMultipler
				##activeSelection -= 0.2 * tetherDrainMultipler
				#chargingDestination += 0.2
				#chargingOrigin -= 0.2
			#collectionPower:
				## Collection
				#chargingDestination += 0.2
				#chargingOrigin -= 0.2
			#securityPower:
				## Security
				#chargingDestination += 0.2
				#chargingOrigin -= 0.2
			#communicationsPower:
				## Comms
				#chargingDestination += 0.2
				#chargingOrigin -= 0.2
				#print(charging_Des_Button)



# Left Click Buttons (Destination)
func _on_systems_pressed() -> void:
	power_Destination_Change("systems")
func _on_collection_pressed() -> void:
	power_Destination_Change("collection")
func _on_security_pressed() -> void:
	power_Destination_Change("security")
func _on_communications_pressed() -> void:
	power_Destination_Change("comms")
func _on_tether_power_pressed() -> void:
	power_Destination_Change("tether")

# Transfer buttons
func _on_transfer_power_button_down() -> void:
	charging = true
	print("pressed down")
	chargingDestination = chargingDestination + 0.2
	chargingOrigin = chargingOrigin - 0.2
	await get_tree().create_timer(0.05)
func _on_transfer_power_button_up() -> void:
	charging = false
	print("released")
	chargingDestination = chargingDestination + 0.2
	chargingOrigin = chargingOrigin - 0.2
	await get_tree().create_timer(0.05)

# Right Click Buttons (Origin)
func _on_systems_r_pressed() -> void:
	power_Origin_Change("systems")
func _on_collection_r_pressed() -> void:
	power_Origin_Change("collection")
func _on_security_r_pressed() -> void:
	power_Origin_Change("security")
func _on_comms_r_pressed() -> void:
	power_Origin_Change("comms")
func _on_tether_right_pressed() -> void:
	power_Origin_Change("tether")


func _on_tether_p_drain_timeout() -> void:
	pass # Replace with function body.


func _on_ui_timer_timeout() -> void:
	if uiCounter < 4:
		uiCounter += 1
	else:
		uiCount_Timer.stop()
	print(uiCounter)
	pass # Replace with function body.


func _on_systems_l_mouse_entered() -> void:
	hovering = true
	hoveringOver = systems_Power
	pass # Replace with function body.
func _on_systems_l_mouse_exited() -> void:
	hovering = false
	hoveringOver = null
	pass # Replace with function body.
func _on_collection_l_mouse_entered() -> void:
	hovering = true
	hoveringOver = collection_Power
	pass # Replace with function body.
func _on_collection_l_mouse_exited() -> void:
	hovering = false
	hoveringOver = null
	pass # Replace with function body.
func _on_security_l_mouse_entered() -> void:
	hovering = true
	hoveringOver = security_Power
	pass # Replace with function body.
func _on_security_l_mouse_exited() -> void:
	hovering = false
	hoveringOver = null
	pass # Replace with function body.
func _on_comms_l_mouse_entered() -> void:
	hovering = true
	hoveringOver = communications_Power
	pass # Replace with function body.
func _on_comms_l_mouse_exited() -> void:
	hovering = false
	hoveringOver = null
	pass # Replace with function body.
func _on_tether_left_mouse_entered() -> void:
	hovering = true
	hoveringOver = tether_Power
	pass # Replace with function body.
func _on_tether_left_mouse_exited() -> void:
	hovering = false
	hoveringOver = null
	pass # Replace with function body.
func _on_transfer_power_mouse_entered() -> void:
	hovering = true
	hoveringOver = transfer_Button
	pass # Replace with function body.
func _on_transfer_power_mouse_exited() -> void:
	hovering = false
	hoveringOver = null
	pass # Replace with function body.
