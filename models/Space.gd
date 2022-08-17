extends Node
class_name Space
# Space is a position in a Lane that can hold progress
# Marker's and Cone's.

# space_changed is emitted if any Marker's or Cone's are
# added or removed.
signal space_changed

var _markers = {}
var markers = []:
	get:
		return _markers.values()

var cone: Cone = null:
	get:
		return cone
	set(c):
		cone = c
		emit_signal("space_changed")

# rank is the 0-index'd position on the Lane
# where 0 is the lowest.
var rank: int = -1:
	get:
		return rank

# is_top holds whether this Space is the winning Space.
var is_top: bool = false:
	get:
		return is_top
	set(it):
		is_top = it

func _init(rank: int):
	self.rank = rank

# remove_all clears all pieces from the Space.
func remove_all() -> void:
	if len(_markers) != 0:
		_markers = {}
		emit_signal("space_changed")

# add_marker_for adds a new Player Marker to the Space.
func add_marker_for(player: Player) -> void:
	_markers[player.color] = Marker.new(player)
	emit_signal("space_changed")

# remove_marker_for removes an existing Player's Marker
# from the Space.
func remove_marker_for(player: Player) -> void:
	if _markers.erase(player.color):
		emit_signal("space_changed")

# has_marker_for checks if the Player occupies the current
# Space.
func has_marker_for(player: Player) -> bool:
	return _markers.has(player.color)
