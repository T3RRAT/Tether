extends GridContainer

var grid = []
var height = 3
var width = 4
var mines = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func generateBoard(difficulty):
	## Array of board
	## select random tiles to have bombs.
	## tiles around generate numbers
	## right click to flag
	## left click to clear tile
	## boarc completiom = win
	## hitting a mine = lose
	#
	## Initializin the board
	#for i in width:
		#grid.append([])
		#for j in height:
			#grid[i].append([0])
			#pass
		#pass
	#
	#
	## Add Mines
	#for m in mines:
		#var minePosHeight = randi_range(0,height)
		#var minePosWidth = randi_range(0,width)
		#
		#while grid[minePosHeight][minePosWidth] != 10:
			#grid[minePosHeight][minePosWidth] = 10
		#
	#
	#
	pass
