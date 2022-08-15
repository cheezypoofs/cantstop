extends Node
class_name Space

var markers = []:
	get:
		return markers

var rank: int = -1:
	get:
		return rank

func init(rank: int) -> Space:
	self.rank = rank
	return self
	
func add_marker(marker: Marker) -> void:
	self.markers.append(marker)
	
func remove_marker(marker: Marker) -> Space:
	for i in range(len(self._markers)):
		if self.markers[i].player.player_name == marker.player.player_name:
			self.markers.remove_at(i)
			return self
	return self
	
func has_marker_for(player: Player) -> bool:
	for m in self.markers:
		if m.player.player_name == player.player_name:
			return true
	return false

func _ready():
	assert(self.rank != -1)
