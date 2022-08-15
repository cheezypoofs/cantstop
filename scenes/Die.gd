extends Node

var gdmodel = preload("res://models/Die.gd")

var model: Die = null:
	get:
		return model
	set(d):
		assert(model == null)
		model = d
		model.connect("die_rolled", _update_value)
		self._update_value()
	
func _update_value() -> void:
	if model.value == gdmodel.INVALID_VALUE:
		$Value.text = ""
	else:
		$Value.text = str(self.model.value)
