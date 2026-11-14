extends Button


@onready var computer = $"../../../../.."
@onready var shipTab = $"../.."

@onready var button = $"."
@onready var checkbox_Image = $"Checkbox Image"
@onready var loading_Image = $"Loading Image"
@onready var finished_Image = $"Finished Image"

@onready var state_2_Timer = $"Captcha State 2"
@onready var state_3_Timer = $"Captcha State 3"
@onready var state_End_Timer = $"Captcha State End"

# 0 = inactive, 1 = active, 2 = loading, 3 = closing
var captchaState = 0
var loading_Time = 4

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
		loading_Image.visible = false
		button.scale = lerp(button.scale, Vector2(0,0), delta * 10)
		finished_Image.scale = Vector2(0, 0)
		checkbox_Image.visible = false
		finished_Image.visible = false
	elif captchaState == 1:
		# Button is visible with icon
		button.visible = true
		checkbox_Image.visible = true
		button.scale = lerp(button.scale, Vector2(1, 1), delta * 6)
		
	elif captchaState == 2:
		# Button is loading. Icon should be invisible and loading circle should be working
		checkbox_Image.visible = false
		loading_Image.visible = true
		loading_Image.scale = lerp(loading_Image.scale, loading_Image_Scale, delta * 5)
		
		# Holy moley (6.02x10^23), did i just figure out how to rotate this damned image? wow going out and taking a break does wonders to my brain
		# I should touch grass more. actually nah stats is gonna get my ass if i dont study
		loading_Image.rotation_degrees = lerp(loading_Image.rotation_degrees, loading_Image.rotation_degrees + 90, delta * 4)
		if s2T_On == false:
			s2T_On = true
			state_2_Timer.start(loading_Time)
	elif captchaState == 3:
		# Button is closing. Icon changes to finished icon
		finished_Image.visible = true
		finished_Image.scale = lerp(finished_Image.scale, finished_Image_Scale, delta * 10)
		loading_Image.scale = lerp(loading_Image.scale, Vector2(0, 0), delta * 5)
		if s3T_On == false:
			s3T_On = true
			state_3_Timer.start()
		pass
	

func openCaptcha():
	if captchaState == 0:
		#print("Open Seasasesaeme")
		captchaState = 1
		finsihed = false


func closeCaptcha():
	#print("Close for business")
	captchaState = 0
	finsihed = true
	computer.call("click_Captcha_Finished")
	s2T_On = false
	s3T_On = false
	pressedButton = false
	
	state_2_Timer.stop()
	state_3_Timer.stop()
	pass


func _on_pressed() -> void:
	#print("Pressed and loading")
	if pressedButton == false:
		captchaState = 2
		pressedButton = true
	


func _on_captcha_state_2_timeout() -> void:
	captchaState = 3
	shipTab.call("confirmPosition")
	pass # Replace with function body.


func _on_captcha_state_3_timeout() -> void:
	closeCaptcha()
	pass # Replace with function body.




# Get thing to rotate
# Get visibility right. KINDA DONE. 
# make it impossible to break
