extends Node

var gdmodel = preload("res://models/Die.gd")

var model: Die:
	get:
		return model
	
func _ready() -> void:
	model = gdmodel.new()
	model.connect("die_rolled", _update_value)
	self._update_value()
	
func _update_value() -> void:
	if model.value == gdmodel.INVALID_VALUE:
		$Value.text = ""
	else:
		$Value.text = str(self.model.value)
