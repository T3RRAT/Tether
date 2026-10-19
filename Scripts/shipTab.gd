extends TextureRect

var dragging = false
var of = Vector2(0.0,0.0)

var shipPos = 2

@onready var ShipIcon = $Ship
@onready var pos1 = $Pos1
@onready var pos2 = $Pos2
@onready var pos3 = $Pos3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		ShipIcon.position = get_local_mouse_position() - of
	else:
		if shipPos == 2:
			ShipIcon.position = lerp(ShipIcon.position, pos2.position, delta * 6)
		elif shipPos == 1:
			ShipIcon.position = lerp(ShipIcon.position, pos1.position, delta * 6)
		elif shipPos == 3:
			ShipIcon.position = lerp(ShipIcon.position, pos3.position, delta * 6)
	pass


func _on_ship_button_down() -> void:
	dragging = true
	of = get_local_mouse_position() - ShipIcon.position
	pass # Replace with function body.


func _on_ship_button_up() -> void:
	dragging = false
	pass # Replace with function body.
