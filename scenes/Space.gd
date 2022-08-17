extends Node

const marker_scene = preload("res://scenes/Marker.tscn")

var model: Space:
	get:
		return model

func init(model: Space) -> void:
	self.model = model
	model.connect("space_changed", self._update)
	self._update()

func _update() -> void:
	for child in $Markers.get_children():
		$Markers.remove_child(child)

	if model.cone != null:
		var ms = marker_scene.instantiate()
		ms.color = Color.WHITE
		$Markers.add_child(ms)

	for marker in model.markers:
		var ms = marker_scene.instantiate()
		ms.color = marker.player.color
		$Markers.add_child(ms)

	$Rank.text = "R: " + str(self.model.rank)
