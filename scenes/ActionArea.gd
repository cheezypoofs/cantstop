extends Node

signal choice_stop
signal move_selected
signal move_chosen

var moves = []

var selected_move = null:
	get:
		return selected_move

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

var current_turn: Turn = null:
	get:
		return current_turn
	set(t):
		t.connect("pieces_used", _cones_used)
		current_turn = t
		$Player.text = current_turn.player.player_name
		_cones_used()

func _cones_used() -> void:
	$Cones.text = "Cones: " + str(current_turn.num_cones)

func _ready():
	$Roll.disabled = true
	$Stop.disabled = true

	$Roll.connect("pressed", _on_roll)
	$Stop.connect("pressed", _on_stop)
	$Move.connect("item_selected", _on_move)
	$MoveSelect.connect("pressed", _on_move_select)

func prompt_roll_or_stop():
	$Roll.disabled = false
	$Stop.disabled = false

func _on_move(index: int) -> void:
	if index < 0:
		return

	print("move %d selected" % (index))
	if index < len(moves):
		print("setting to %s"%(moves[index]))
		selected_move = self.moves[index]
	emit_signal("move_selected")
	print("selected_move=%s" % (selected_move))

func _on_move_select() -> void:
	print("move chosen")
	$MoveSelect.disabled = true
	$Move.clear()
	emit_signal("move_chosen")

func _on_roll():
	print("roll clicked")
	$Roll.disabled = true
	$Stop.disabled = true
	model.roll()

func _on_stop():
	print("stop clicked")
	$Roll.disabled = true
	$Stop.disabled = true
	emit_signal("choice_stop")

func set_move_choices(moves: Array) -> void:
	selected_move = null
	self.moves = moves

	$MoveSelect.disabled = false

	if len(moves) == 0:
		$MoveSelect.text = "surrender"
		return

	$MoveSelect.text = "go"
	var index: int = 0
	for move in moves:
		var label: String
		assert(move.first != null)
		label = str(move.first.lane.value)
		if move.second != null:
			label += "," + str(move.second.lane.value)
		$Move.add_item(label, index)
		index += 1

	_on_move($Move.get_selected_id())
