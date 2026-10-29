extends Button


@onready var computer = $"../../../../../.."

@onready var button = $"."
@onready var checkbox_Image = $"Checkbox Image"
@onready var loading_Image = $"Loading Image"
@onready var finished_Image = $"Finished Image"

@onready var state_2_Timer = $"Captcha State 2"
@onready var state_3_Timer = $"Captcha State 3"
@onready var state_End_Timer = $"Captcha State End"

# 0 = inactive, 1 = active, 2 = loading, 3 = closing
var captchaState = 0
var loading_Time = 1

var loading_Image_Scale = null
var finished_Image_Scale = null
var checkbox_Image_Scale = null

var s2T_On = false
var s3T_On = false
var pressedButton = false
var finsihed = false

var loading_Image_Rotation_Stuff = deg_to_rad(90)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loading_Image_Scale = loading_Image.scale
	finished_Image_Scale = finished_Image.scale
	checkbox_Image_Scale = checkbox_Image.scale
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	# Based on Captcha State, will change stuff ig
	if captchaState == 0:
		# Button is invisible
		button.visible = false
		loading_Image.visible = false
		button.scale = Vector2(0, 0)
		finished_Image.scale = Vector2(0, 0)
		checkbox_Image.visible = false
		finished_Image.visible = false
		#button.scale = lerp(button.scale, Vector2(0, 1), delta * 1)
		#loading_Image.scale = Vector2(0, 0)
		#loading_Image.scale = lerp(loading_Image.scale, Vector2(0, 0), delta * 1)
		#checkbox_Image.scale = lerp(checkbox_Image.scale, checkbox_Image_Scale, delta * 1)
	elif captchaState == 1:
		# Button is visible with icon
		button.visible = true
		checkbox_Image.visible = true
		button.scale = lerp(button.scale, Vector2(0.8, 1), delta * 6)
		
		if s2T_On == false:
			state_2_Timer.start(loading_Time)
			s2T_On == true
	elif captchaState == 2:
		# Button is loading. Icon should be invisible and loading circle should be working
		#button.icon.visible = false
		checkbox_Image.visible = false
		loading_Image.visible = true
		loading_Image.scale = lerp(loading_Image.scale, loading_Image_Scale, delta * 1)
		
		
	elif captchaState == 3:
		# Button is closing. Icon changes to finished icon
		finished_Image.visible = true
		finished_Image.scale = lerp(finished_Image.scale, finished_Image_Scale, delta * 1)
		loading_Image.scale = lerp(loading_Image.scale, Vector2(0, 0), delta * 10)
		if s3T_On == false:
			state_3_Timer.start()
			s3T_On = true
		pass
	
	# Should constantly just rotate the loading image
	loading_Image.rotation = lerp_angle(loading_Image.rotation, loading_Image_Rotation_Stuff, delta * 2)

func openCaptcha():
	if captchaState == 0:
		print("Open Seasasesaeme")
		captchaState = 1
		finsihed = false


func closeCaptcha():
	print("Close for business")
	captchaState = 0
	finsihed = true
	computer.call("click_Captcha_Finished")
	pass


func _on_pressed() -> void:
	print("Pressed and loading")
	if pressedButton == false:
		captchaState = 2
		pressedButton = true
	


func _on_captcha_state_2_timeout() -> void:
	captchaState = 3
	s2T_On = false
	pass # Replace with function body.


func _on_captcha_state_3_timeout() -> void:
	button.visible = false
	closeCaptcha()
	pass # Replace with function body.




# Get thing to rotate
# Get visibility right. KINDA DONE. 
# make it impossible to break
