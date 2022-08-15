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

func _init(value: int):
	self.value = value
	var num: int = 12-(2*(abs(7-value)))

	# Create the Space instances
	for i in range(num):
		var new_space: Space = gdspace.new(i)
		self.spaces.append(new_space)
