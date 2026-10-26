extends Button

@onready var button = $"."
<<<<<<< HEAD
<<<<<<< HEAD
@onready var captcha_Processing_Timer = $"Loading Timer"
@onready var captcha_Closing_Timer = $"Captcha Closing"

=======
>>>>>>> parent of beb0701 (Captcha buton work)
=======
>>>>>>> parent of beb0701 (Captcha buton work)
var loading_circle = "res://icon.svg"
var captchaState = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if captchaState == true:
		scale = lerp(scale, Vector2(1,1), delta * 1)
		pass
	else:
		scale = lerp(scale, Vector2(0,0), delta * 1)
	
	pass

func openCaptcha():
	pass

<<<<<<< HEAD
<<<<<<< HEAD
func closeCaptcha():
	# remove loading circle with a checkmark
	# ding sound
	# scale captcha down to 0
	# send back to game that captcha was completed and movement confirmed
	pass


func _on_pressed() -> void:
	#button.icon = loading_circle
	captcha_Processing_Timer.start()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	closeCaptcha()
	pass # Replace with function body.


func _on_captcha_closing_timeout() -> void:
	
=======
func _on_pressed() -> void:
	#button.icon = loading_circle
>>>>>>> parent of beb0701 (Captcha buton work)
=======
func _on_pressed() -> void:
	#button.icon = loading_circle
>>>>>>> parent of beb0701 (Captcha buton work)
	pass # Replace with function body.
