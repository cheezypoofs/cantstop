extends Node
class_name Space

var _markers = []

var rank: int = -1:
	get:
		return rank

func init(rank: int) -> Space:
	self.rank = rank
	return self
	
func add_marker(marker: Marker) -> Space:
	self._markers.append(marker)
	return self
	
func remove_marker(marker: Marker) -> Space:
	for i in range(len(self._markers)):
		if self._markers[i].player.player_name == marker.player.player_name:
			self._markers.remove_at(i)
			return self
	return self
	
func has_marker_for(player: Player) -> bool:
	for m in self._markers:
		if m.player.player_name == player.player_name:
			return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(self.rank != -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var markers: String
	for m in self._markers:
		markers += str(m.player.color)
	
	get_node("Rank").text = "R: " + str(self.rank)
	get_node("Markers").text = "M: " + markers
