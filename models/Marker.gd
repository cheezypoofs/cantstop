extends Node
class_name Marker

var player: Player = null :
	get:
		return player
		
func _init(p: Player):
	self.player = p
