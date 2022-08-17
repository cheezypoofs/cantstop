extends Node

var model: Die = null:
	get:
		return model
	set(d):
		assert(model == null)
		model = d
		model.connect("die_rolled", _update_value)
		self._update_value(Die.INVALID_VALUE)

func _update_value(v: int) -> void:
	if v == Die.INVALID_VALUE:
		$Value.text = ""
	else:
		$Value.text = str(v)
