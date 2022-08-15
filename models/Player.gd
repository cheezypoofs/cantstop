extends Node
class_name Player

var player_name: String :
	get:
		return player_name

var color: Color = Color.BLACK :
	get:
		return color

func _init(name: String, color: Color):
	self.player_name = name
	self.color = color
