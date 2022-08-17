extends Node
class_name Die
# Die is a die. derp.

signal die_rolled(value: int)

const MIN_VALUE: int = 1
const MAX_VALUE: int = 6
const INVALID_VALUE: int = 0

var value: int = INVALID_VALUE:
	get:
		return value

func roll() -> void:
	value = randi_range(MIN_VALUE, MAX_VALUE)
	emit_signal("die_rolled", value)
