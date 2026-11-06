extends TextureRect

var drop_Down_Menu_Active = false


@onready var innerMenu = $"Drop Down/Inner Menu"
@onready var innerMenu_Element1 = $"Drop Down/Inner Menu/Inner Element 1"
@onready var innerMenu_Element2 = $"Drop Down/Inner Menu/Inner Element 1/Inner Element 2"


var trans = Color(1,1,1,0)
var notTrans = Color(1,1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# wait a second I can use emojis? 👍😘😘👌😊😊😂🤣❤️😍😒🙌👌🤷‍♀️🤦‍♀️😉😉😎🤷‍♀️🤷‍♀️🤦‍♀️🤦‍♀️💖💖😜😜😢😢
func _process(delta: float) -> void:
	
	# If the Drop down menu is active, visibility will be turned on and begin lerping
	if drop_Down_Menu_Active == true:
		innerMenu.self_modulate = notTrans
		var timer = Timer.new().start(0.1)
		
	elif drop_Down_Menu_Active == false:
		innerMenu.self_modulate = trans
	
	
	pass


func _on_drop_down_pressed() -> void:
	# holy shit am i genius? this is like, better than 2 if statements
	drop_Down_Menu_Active  = !drop_Down_Menu_Active
	print("pressed the button")
	pass # Replace with function body.
