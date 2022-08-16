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

func find_cone() -> Space:
	for space in self.spaces:
		if space.cone != null:
			return space
	return null

var winner: Player:
	get:
		var last: Space = spaces[len(spaces) - 1]
		assert(last.is_top)
		var markers = last.markers
		if len(markers) != 0:
			assert(len(markers) == 1)
			return markers[0].player
		return null

func _init(value: int):
	self.value = value
	var num: int = 12-(2*(abs(7-value)))+1

	# Create the Space instances
	for i in range(num):
		var new_space: Space = gdspace.new(i)
		if i == (num-1):
			new_space.is_top = true
		self.spaces.append(new_space)
