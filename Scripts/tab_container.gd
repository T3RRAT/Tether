extends Control

@onready var top_Bar = $"Top Bar"
@onready var tab_Button_Container = $"Top Bar/TabButtonContainer"

@onready var power_Tab = $Power
@onready var ship_Tab = $Ship
@onready var tab3 = $Tab3

@onready var power_Button = $"Top Bar/TabButtonContainer/PowerTabButton"
@onready var ship_Button = $"Top Bar/TabButtonContainer/ShipTabButton"
@onready var tab_3 = $"Top Bar/TabButtonContainer/Tab3"
# Put Tab 3 Name here

@onready var panel = $"Top Bar/TabButtonContainer/PowerTabButton/Panel"
@onready var panel_Rect = $"Top Bar/TabButtonContainer/PowerTabButton/Panel/ColorRect"

var current_Tab_Button
var currentTab = 0
var tabMax = 2

var hoveringTop = false

var topBarOrgHeight
var topBarHoverHeight

var tabButContainerOrgSize
var tabButContainerLerpSize



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	topBarOrgHeight = top_Bar.size
	topBarHoverHeight = top_Bar.size + Vector2(0,20)
	
	tabButContainerOrgSize = tab_Button_Container.scale
	tabButContainerLerpSize = tab_Button_Container.scale + Vector2(0.3,0.3)
	
	current_Tab_Button = power_Button
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hoveringTop == true:
		top_Bar.size = lerp(top_Bar.size, topBarHoverHeight, delta * 5)
		tab_Button_Container.scale = lerp(tab_Button_Container.scale, tabButContainerLerpSize, delta * 5)
	else:
		top_Bar.size = lerp(top_Bar.size, topBarOrgHeight, delta * 5)
		tab_Button_Container.scale = lerp(tab_Button_Container.scale, tabButContainerOrgSize, delta * 5)
		pass
	
	
	if currentTab == 0:
		#print("Current tab is 1 chat")
		power_Tab.visible = true
		ship_Tab.visible = false
		tab3.visible = false
		
		current_Tab_Button = power_Button
		panel.reparent(current_Tab_Button)
		panel.global_position = power_Button.global_position
		panel.set_anchors_preset(Control.PRESET_FULL_RECT)
		panel_Rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	elif currentTab == 1:
		#print("yoollooooo")
		ship_Tab.visible = true
		power_Tab.visible = false
		tab3.visible = false
		
		current_Tab_Button = ship_Button
		panel.reparent(current_Tab_Button)
		panel.global_position = ship_Button.global_position
		panel.set_anchors_preset(Control.PRESET_FULL_RECT)
		panel_Rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	elif currentTab == 2:
		#print("chat is this coding fire?")
		tab3.visible = true
		ship_Tab.visible = false
		power_Tab.visible = false
		
		current_Tab_Button = tab_3
		panel.reparent(current_Tab_Button)
		panel.global_position = tab_3.global_position
		panel.set_anchors_preset(Control.PRESET_FULL_RECT)
		panel_Rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	

# Custom Funcs
func change_Tab_Outside(direction):
	if currentTab == tabMax && direction == 1:
		currentTab = 0
	elif currentTab == 0 && direction == -1:
		currentTab = tabMax
	else:
		currentTab = currentTab + direction
	



func _on_top_bar_mouse_entered() -> void:
	hoveringTop = true
func _on_top_bar_mouse_exited() -> void:
	hoveringTop = false


func _on_power_tab_button_pressed() -> void:
	currentTab = 0
func _on_ship_tab_button_pressed() -> void:
	currentTab = 1
func _on_tab_3_pressed() -> void:
	currentTab = 2
