extends Node
class_name Space

signal space_changed

var markers = []:
	get:
		return markers

var cone: Cone = null:
	get:
		return cone
	set(c):
		cone = c
		emit_signal("space_changed")

var rank: int = -1:
	get:
		return rank

var is_top: bool = false:
	get:
		return is_top
	set(it):
		is_top = it

func _init(rank: int):
	self.rank = rank

func remove_all() -> void:
	if len(markers) != 0:
		markers = []
		emit_signal("space_changed")

func add_marker_for(player: Player) -> void:
	markers.append(Marker.new(player))
	emit_signal("space_changed")

func remove_marker_for(player: Player) -> void:
	for i in range(len(markers)):
		if markers[i].player.player_name == player.player_name:
			markers.remove_at(i)
			emit_signal("space_changed")
			return

func has_marker_for(player: Player) -> bool:
	for m in markers:
		if m.player.player_name == player.player_name:
			return true
	return false
