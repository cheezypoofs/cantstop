extends Node

var model: Space:
	get:
		return model

func init(model: Space) -> void:
	self.model = model
	model.connect("space_changed", self._update)
	self._update()
	
func _update() -> void:
	var markers: String
	for m in model.markers:
		markers += str(m.player.color)
	
	$Rank.text = "R: " + str(self.model.rank)
	$Markers.text = "M: " + markers
