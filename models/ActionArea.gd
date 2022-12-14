extends Node
class_name ActionArea
# ActionArea holds models that are action happens, like
# dice rolls.

signal dice_rolled

var dice: Array = []:
	get:
		return dice

func _init():
	dice = [
		Die.new(),
		Die.new(),
		Die.new(),
		Die.new(),
	]

var die_values: Array :
	get:
		return [
			dice[0].value,
			dice[1].value,
			dice[2].value,
			dice[3].value,
		]

func roll() -> void:
	dice[0].roll()
	dice[1].roll()
	dice[2].roll()
	dice[3].roll()
	emit_signal("dice_rolled")
