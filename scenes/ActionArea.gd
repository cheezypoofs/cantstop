extends Node

signal choice_stop

var model: ActionArea = null:
	get:
		return model
	set(aa):
		# Bind to the model
		assert(model == null)
		model = aa
		
		# Also bind the dice models
		var dice = aa.dice
		$Dice/Die0.model = dice[0]
		$Dice/Die1.model = dice[1]
		$Dice/Die2.model = dice[2]
		$Dice/Die3.model = dice[3]

var current_player: Player = null :
	get:
		return current_player
	set(p):
		current_player = p
		$Player.text = p.player_name

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
	model.roll()
	
func _on_stop():
	print_debug("stop clicked")
	$Roll.disabled = true
	$Stop.disabled = true
	emit_signal("choice_stop")
