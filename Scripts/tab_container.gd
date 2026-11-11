extends Control

@onready var top_Bar = $"Top Bar"

var hoveringTop = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hoveringTop == true:
		
		pass
	pass


func _on_top_bar_mouse_entered() -> void:
	hoveringTop = true


func _on_top_bar_mouse_exited() -> void:
	pass # Replace with function body.
