extends TextureRect

var drop_Down_Menu_Active = false
var mitesActive = false

@onready var p_drain_Timer = $"Power Drain Timer"

@onready var inner_Menu = $"Drop Down/Inner Menu"
@onready var computer = $"../../../.."

@onready var systems_Power = $"Drop Down/Inner Menu/Systems"
@onready var collection_Power = $"Drop Down/Inner Menu/Collection"
@onready var security_Power = $"Drop Down/Inner Menu/Security"
@onready var communications_Power = $"Drop Down/Inner Menu/Communications"
@onready var reverse_Button = $"Drop Down/Inner Menu/Reverse Button"


var powerDrainMultipler = 1
var powerDrainSpeed = 0.1

var tetherDrainMultipler = 1

var flashPowerDrain = 10

var charging = true
var chargingDestination = null
# Charge destination is based on number. 0 is to the tether, 1 is to systems, 2 collection, 3 security, and 4 comms

var samplesCollected = 0

var tetherPower = 100
var systemsPower = 100
var collectionPower = 100
var securityPower = 100
var communicationsPower = 100
var activeSelection = null


var trans = Color(1,1,1,0)
var notTrans = Color(1,1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p_drain_Timer.wait_time = powerDrainSpeed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# wait a second I can use emojis? 👍😘😘👌😊😊😂🤣❤️😍😒🙌👌🤷‍♀️🤦‍♀️😉😉😎🤷‍♀️🤷‍♀️🤦‍♀️🤦‍♀️💖💖😜😜😢😢
func _process(delta: float) -> void:
	
	# Power of each individual system
	
	
	systems_Power.text = ("Systems Power: %d" % round(systemsPower))
	collection_Power.text = ("Collection Power: %d" % round(collectionPower))
	security_Power.text = ("Security Power: %d" % round(securityPower))
	communications_Power = ("Communications Power %d" % round(collectionPower))
	
	
	
	
	# If the Drop down menu is active, visibility will be turned on and begin lerping
	if drop_Down_Menu_Active == true:
		
		pass
	elif drop_Down_Menu_Active == false:
		inner_Menu.self_modulate = trans



# Custom Functions

# Location is a string for reading sake. 
func power_Destination_Change(location):
	
	
	match location:
		"systems":
			chargingDestination = 1
		"collection":
			chargingDestination = 2
		"security":
			chargingDestination = 3
		"comms":
			chargingDestination = 4
			
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
	#tetherPower -= 0.1 * powerDrainMultipler
	communicationsPower -= 0.1 * powerDrainMultipler
	
	if mitesActive == true:
		tetherPower -= 0.025 * tetherDrainMultipler
	
	
	
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
				
			2:
				# Collection
				tetherPower -= 0.2 * tetherDrainMultipler
			3:
				# Security
				tetherPower -= 0.2 * tetherDrainMultipler
			4:
				# Comms
				tetherPower -= 0.2 * tetherDrainMultipler
		pass
	pass # Replace with function body.


func _on_reverse_button_button_down() -> void:
	chargingDestination = 0
	charging = true
	pass # Replace with function body.


func _on_reverse_button_button_up() -> void:
	chargingDestination = null
	charging = false
	pass # Replace with function body.


func _on_systems_pressed() -> void:
	activeSelection = systems_Power
	pass # Replace with function body.


func _on_collection_pressed() -> void:
	activeSelection = collection_Power
	pass # Replace with function body.


func _on_security_pressed() -> void:
	activeSelection = security_Power
	pass # Replace with function body.


func _on_communications_pressed() -> void:
	activeSelection = communications_Power
	pass # Replace with function body.
