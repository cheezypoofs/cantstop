extends Node
class_name Marker

var player: Player = null :
	get:
		return player
		
func init(p: Player) -> Marker:
	self.player = p
	return self
