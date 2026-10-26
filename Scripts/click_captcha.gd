extends Button

@onready var button = $"."
@onready var captcha_Processing_Timer = $"Loading Timer"
@onready var captcha_Closing_Timer = $"Captcha Closing"
var loading_circle = "res://icon.svg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func closeCaptcha():
	
	pass


func _on_pressed() -> void:
	#button.icon = loading_circle
	captcha_Processing_Timer.start()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	closeCaptcha()
	pass # Replace with function body.


func _on_captcha_closing_timeout() -> void:
	pass # Replace with function body.
