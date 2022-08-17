extends Node
class_name Player
# Player holds information about the player.

var player_name: String :
	get:
		return player_name

var color: Color = Color.BLACK :
	get:
		return color

func _init(name: String, color: Color):
	self.player_name = name
	self.color = color
