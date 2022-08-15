extends Node
class_name Die

signal die_rolled

const MIN_VALUE: int = 1
const MAX_VALUE: int = 6
const INVALID_VALUE: int = 0

var value: int = INVALID_VALUE:
	get:
		return value
		
func roll() -> void:
	self.value = randi_range(MIN_VALUE, MAX_VALUE)
	emit_signal("die_rolled")
