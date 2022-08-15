extends Node

var model: Space:
	get:
		return model

func init(model: Space) -> void:
	self.model = model
	
func _ready():
	# todo: hookup listeners to changes instead of using
	# _process?
	assert(model != null)

func _process(delta):
	var markers: String
	for m in model.markers:
		markers += str(m.player.color)
	
	$Rank.text = "R: " + str(self.model.rank)
	$Markers.text = "M: " + markers
