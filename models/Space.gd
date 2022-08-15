extends Node
class_name Space

signal space_changed

var markers = []:
	get:
		return markers

var rank: int = -1:
	get:
		return rank

func _init(rank: int):
	self.rank = rank

func add_marker(marker: Marker) -> void:
	self.markers.append(marker)
	emit_signal("space_changed")

func remove_marker(marker: Marker) -> Space:
	for i in range(len(self._markers)):
		if self.markers[i].player.player_name == marker.player.player_name:
			self.markers.remove_at(i)
			emit_signal("space_changed")
			return self
	return self

func has_marker_for(player: Player) -> bool:
	for m in self.markers:
		if m.player.player_name == player.player_name:
			return true
	return false
