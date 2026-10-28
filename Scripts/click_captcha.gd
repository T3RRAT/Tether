extends Button

@onready var button = $"."
@onready var loading_Image = $"Loading Image"
@onready var finished_Image = $"Finished Image"

@onready var captcha_Processing_Timer = $"Loading Timer"
@onready var captcha_Closing_Timer = $"Captcha Closing"

# 0 = inactive, 1 = active, 2 = loading, 3 = closing
var captchaState = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if captchaState == 0:
		# Button is invisible
		button.visible = false
		button.scale = lerp(button.scale, Vector2(0, 1), delta * 1)
		loading_Image.scale = lerp(loading_Image.scale, Vector2(0, 0), delta * 1)
	elif captchaState == 1:
		# Button is visible with icon
		button.visible = true
		button.scale = lerp(button.scale, Vector2(1, 1), delta * 1)
		loading_Image.scale = lerp(loading_Image.scale, Vector2(0, 0), delta * 1)
	elif captchaState == 2:
		# Button is loading. Icon should be invisible and loading circle should be working
		button.icon.visible = false
		loading_Image.scale = lerp(loading_Image.scale, Vector2(1, 1), delta * 1)
	elif captchaState == 3:
		# Button is closing. Icon changes to finished icon
		finished_Image.scale = lerp(finished_Image.scale, Vector2(1, 1), delta * 1)
		loading_Image.scale = lerp(loading_Image.scale, Vector2(0, 0), delta * 0.1)
		
		pass
	
	
	loading_Image.rotation_degrees = rotate_toward(loading_Image.rotation_degrees, loading_Image.rotation_degrees + 90, delta * 1)
	
	pass

func openCaptcha():
	pass


func closeCaptcha():
	captchaState = 0
	pass


func _on_pressed() -> void:
	# remove image
	# loading circle icon
	captchaState = 2
	captcha_Processing_Timer.start()
	pass # Replace with function body.

# 





func _on_captcha_state_2_timeout() -> void:
	pass # Replace with function body.


func _on_captcha_state_3_timeout() -> void:
	pass # Replace with function body.


func _on_captcha_state_end_timeout() -> void:
	pass # Replace with function body.
