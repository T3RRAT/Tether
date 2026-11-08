extends TextureRect

var drop_Down_Menu_Active = false
var mitesActive = false

@onready var p_drain_Timer = $"Power Drain Timer"

@onready var inner_Menu = $"Drop Down/Inner Menu"
@onready var computer = $"../../../.."

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

var transferLerpPos = null
var tetherLerpPos = null
var systemsLerpPos = null
var collectionLerpPos = null
var securityLerpPos = null
var commmsLerpPos = null

var transferOrigin = null
var tetherOrigin = null
var systemsOrigin = null
var collectionOrigin = null
var securityOrigin = null
var commsOrigin = null


var powerDrainMultipler = 1
var powerDrainSpeed = 0.1

var tetherDrainMultipler = 1

var flashPowerDrain = 10

var charging = true

var charging_Org_Button = null
var chargingOrigin = null

var charging_Des_Button = null
var chargingDestination = null
# Charge destination/origin based on #. 0 = tether, 1 = system, 2 = collection, 3 = security, 4 = comms

var samplesCollected = 0

var tetherPower = 100
var systemsPower = 100
var collectionPower = 100
var securityPower = 100
var communicationsPower = 100
var activeSelection = null



var trans = Color(1,1,1,0)
var notTrans = Color(1,1,1,1)

var normFontColour = Color("dfdfdf")
var originFontColour = Color("c45100")
var destinFontColour = Color("4664ff")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p_drain_Timer.wait_time = powerDrainSpeed
	
	
	systemsLerpPos = systems_Power.position
	collectionLerpPos = collection_Power.position
	securityLerpPos = security_Power.position
	commmsLerpPos = communications_Power.position
	
	systemsOrigin = systems_Power.position - Vector2(0, 36)
	print("Systems Origin: ")
	print(systemsOrigin)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# wait a second I can use emojis? 👍😘😘👌😊😊😂🤣❤️😍😒🙌👌🤷‍♀️🤦‍♀️😉😉😎🤷‍♀️🤷‍♀️🤦‍♀️🤦‍♀️💖💖😜😜😢😢
func _process(delta: float) -> void:
	
	# Power of each individual system
	systems_Power.text = ("Systems : %d" % round(systemsPower))
	collection_Power.text = ("Collect : %d" % round(collectionPower))
	security_Power.text = ("Security: %d" % round(securityPower))
	communications_Power.text = ("Comms   : %d" % round(communicationsPower))
	tether_Text.text = str(snapped(tetherPower, 0.1))
	
	
	# Colour if any item is selected as origin or destination
	if chargingOrigin != null:
		charging_Org_Button.add_theme_color_override("font_color", originFontColour)
	if chargingDestination != null:
		charging_Des_Button.add_theme_color_override("font_color", destinFontColour)
	
	# If the Drop down menu is active, visibility will be turned on and begin lerping
	if drop_Down_Menu_Active == true:
		#systems_Power.position = lerp(sysystems_Power.position, systemsLerpPos)
		pass
	elif drop_Down_Menu_Active == false:
		inner_Menu.self_modulate = trans



# Custom Functions

# Location is a string for reading sake. 
func power_Destination_Change(location):
	
	
	match location:
		"systems":
			chargingDestination = null
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = systemsPower
			charging_Des_Button = systems_Power
		"collection":
			chargingDestination = null
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = collectionPower
			charging_Des_Button = collection_Power
		"security":
			chargingDestination = null
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = securityPower
			charging_Des_Button = security_Power
		"comms":
			chargingDestination = null
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = communicationsPower
			charging_Des_Button = communications_Power
		"tether":
			chargingDestination = null
			if charging_Des_Button:
				charging_Des_Button.add_theme_color_override("font_color", normFontColour)
			charging_Des_Button = null
			
			chargingDestination = tetherPower
			charging_Des_Button = tether_Power
	pass

func power_Origin_Change(location):
	
	
	match location:
		"systems":
			chargingOrigin = null
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = systemsPower
			charging_Org_Button = systems_Power
		"collection":
			chargingOrigin = null
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = collectionPower
			charging_Org_Button = collection_Power
		"security":
			chargingOrigin = null
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = securityPower
			charging_Org_Button = security_Power
		"comms":
			chargingOrigin = null
			if charging_Org_Button:
				charging_Org_Button.add_theme_color_override("font_color", normFontColour)
			charging_Org_Button = null
			
			chargingOrigin = communicationsPower
			charging_Org_Button = communications_Power
		"tether":
			chargingOrigin = null
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


# Functions Called by other scenes
func mites_Activity_Changed():
	mitesActive = !mitesActive
	print(mitesActive)




# Auto Functions
func _on_drop_down_pressed() -> void:
	# holy shit am i genius? this is like, better than 2 if statements
	drop_Down_Menu_Active  = !drop_Down_Menu_Active
	print("pressed the button")
	pass # Replace with function body.


func _on_power_drain_timer_timeout() -> void:
	systemsPower -= 0.1 * powerDrainMultipler
	collectionPower -= 0.1 * powerDrainMultipler
	securityPower -= 0.1 * powerDrainMultipler
	communicationsPower -= 0.1 * powerDrainMultipler
	
	tetherPower -= 0.1 * powerDrainMultipler
	
	
	pass # Replace with function body.


func _on_power_charge_timer_timeout() -> void:
	if charging == true:
		match chargingDestination:
			0:
				# Tether
				tetherPower += 0.2 * tetherDrainMultipler
				activeSelection -= 0.2 * tetherDrainMultipler
			1:
				# Systems
				tetherPower -= 0.2 * tetherDrainMultipler
				activeSelection -= 0.2 * tetherDrainMultipler
			2:
				# Collection
				tetherPower -= 0.2 * tetherDrainMultipler
				activeSelection -= 0.2 * tetherDrainMultipler
			3:
				# Security
				tetherPower -= 0.2 * tetherDrainMultipler
				activeSelection -= 0.2 * tetherDrainMultipler
			4:
				# Comms
				tetherPower -= 0.2 * tetherDrainMultipler
				activeSelection -= 0.2 * tetherDrainMultipler
		pass
	pass # Replace with function body.



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
func _on_transfer_power_button_up() -> void:
	charging = false
	print("released")

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
