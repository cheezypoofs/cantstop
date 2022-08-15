extends Node
class_name Turn

signal pieces_used

var num_cones: int = 3:
	get:
		return num_cones
		
var player: Player:
	get:
		return player
		
func _init(player: Player):
	self.player = player
		
func use_cone():
	num_cones -= 1
	emit_signal("pieces_used")
