extends Node
class_name Player

var player_name: String :
	get:
		return player_name
		
var color: Color = Color.BLACK :
	get:
		return color
		
func init(name: String, color: Color) -> Player:
	self.player_name = name
	self.color = color
	return self
