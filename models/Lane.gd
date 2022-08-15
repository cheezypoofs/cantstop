extends Node
class_name Lane

var gdspace = preload("res://models/Space.gd")

var value: int = 0:
	get:
		return value
		
var spaces = []:
	get:
		return spaces
	
func player_space(player: Player) -> Space:
	for space in self.spaces:
		if space.has_marker_for(player):
			return space
	return null
	
func init(value: int) -> Lane:
	self.value = value
	var num: int = 12-(2*(abs(7-value)))
	
	# Create the Space instances
	for i in range(num):
		var new_space: Space = gdspace.new()
		new_space.init(i)
		self.spaces.append(new_space)

	return self

func _ready():
	assert(self.value != 0)
