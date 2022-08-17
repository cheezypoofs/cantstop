extends Node
class_name Turn
# Turn is an instance created at the start of a
# Player's turn and tracks the state of that turn.

signal pieces_used

# num_cones tracks the remaining Cone's left to be
# added to the board.
var num_cones: int = 3:
	get:
		return num_cones

var player: Player:
	get:
		return player

func _init(player: Player):
	self.player = player

# use_cone subtracts a cone from the turn and emits
# a "pieces_used" signal.
func use_cone():
	num_cones -= 1
	assert(num_cones >= 0)
	emit_signal("pieces_used")
