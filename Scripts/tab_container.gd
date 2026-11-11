extends Control

@onready var top_Bar = $"Top Bar"
@onready var tab_Button_Container = $"Top Bar/TabButtonContainer"

@onready var power_Tab = $Power
@onready var ship_Tab = $Ship
@onready var tab3 = $Tab3


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
	pass


func _on_top_bar_mouse_entered() -> void:
	hoveringTop = true
func _on_top_bar_mouse_exited() -> void:
	hoveringTop = false


func _on_power_tab_button_pressed() -> void:
	power_Tab.visible = true
	ship_Tab.visible = false
	tab3.visible = false


func _on_ship_tab_button_pressed() -> void:
	ship_Tab.visible = true
	power_Tab.visible = false
	tab3.visible = false
	pass # Replace with function body.


func _on_tab_3_pressed() -> void:
	tab3.visible = true
	ship_Tab.visible = false
	power_Tab.visible = false
	pass # Replace with function body.
