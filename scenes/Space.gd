extends Control

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
		$Cone.visible=true
	else:
		$Cone.visible=false

	if model.is_top:
		if len(model.markers) != 0:
			# Kind of a hack. Steal the cone slot and own it.
			$Cone.visible = true
			$Cone.color = model.markers[0].player.color
	else:
		for marker in model.markers:
			var ms = marker_scene.instantiate()
			ms.color = marker.player.color
			$Markers.add_child(ms)

	$Rank.text = "R: " + str(self.model.rank)
