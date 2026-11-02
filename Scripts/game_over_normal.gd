extends Node3D

@onready var spL1 = $SpotLight1
@onready var spL2 = $SpotLight2
@onready var spL3 = $SpotLight3

@onready var focus = $Skull

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spL1.look_at(focus.position)
	spL2.look_at(focus.position)
	spL3.look_at(focus.position)
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.
