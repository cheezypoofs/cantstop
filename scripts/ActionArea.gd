extends Node
class_name ActionArea

signal choice_stop
signal choice_rolled

var current_player: Player = null :
	get:
		return current_player
	set(p):
		current_player = p
		$Player.text = p.player_name
		
var die_values: Array :
	get:
		return [
			$Dice/Die0.model.value,
			$Dice/Die1.model.value,
			$Dice/Die2.model.value,
			$Dice/Die3.model.value,
		]

func _ready():
	$Roll.disabled = true
	$Stop.disabled = true
	
	$Roll.connect("pressed", self._on_roll)
	$Stop.connect("pressed", self._on_stop)
	
func prompt_roll_or_stop():
	$Roll.disabled = false
	$Stop.disabled = false

func _on_roll():
	print_debug("roll clicked")
	$Roll.disabled = true
	$Stop.disabled = true
	
	$Dice/Die0.model.roll()
	$Dice/Die1.model.roll()
	$Dice/Die2.model.roll()
	$Dice/Die3.model.roll()
	emit_signal("choice_rolled")
	
func _on_stop():
	print_debug("stop clicked")
	$Roll.disabled = true
	$Stop.disabled = true
	emit_signal("choice_stop")
