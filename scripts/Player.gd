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

func _ready():
	assert(self.player_name != "")
	assert(self.color != Color.BLACK)

func _process(delta):
	pass
