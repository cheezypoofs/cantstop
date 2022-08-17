extends Node
class_name Lane
# Lane is the model that represents the vertical line
# of Space's on the game board.

# value is the number at the top of the board (2-12)
var value: int = 0:
	get:
		return value

# spaces holds the Space instances in order bottom to top.
# The n-1's Space is the winning Space.
var spaces = []:
	get:
		return spaces

# player_space returns the Space (or null) occupied by
# a Player's marker (not a cone).
func player_space(player: Player) -> Space:
	for space in self.spaces:
		if space.has_marker_for(player):
			return space
	return null

# clear_losers removes all Player Marker's except for the
# single Marker at the top.
func clear_losers() -> void:
	for space in spaces:
		if !space.is_top:
			space.remove_all()

# find_cone returns the Space (or null) that has a cone
# placed on it.
func find_cone() -> Space:
	for space in self.spaces:
		if space.cone != null:
			return space
	return null

# winner returns the Player (or null) that occupies the
# top-most Space.
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
		var new_space := Space.new(i)
		if i == (num-1):
			new_space.is_top = true
		self.spaces.append(new_space)
