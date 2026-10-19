extends Sprite2D

var dragging = false
var of = Vector2(0.0,0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(596.0, 307.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of
	pass



func _on_ship_button_up() -> void:
	dragging = false
	pass # Replace with function body.


func _on_ship_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position
	pass # Replace with function body.
