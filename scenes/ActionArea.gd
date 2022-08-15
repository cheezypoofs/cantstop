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

class Choice:
	var first: int
	var second: int
	var legal: bool
	var chosen: Callable

	func _init(first: int, second: int, legal: bool):
		self.first = first
		self.second = second
		self.legal = legal

var _choice_buttons = []
var choices: Array = [null, null, null]:
	set(c):
		assert(len(c) == 3)
		choices = c

		for i in range(3):
			var choice: Choice = choices[i]

			if choice == null:
				self._choice_buttons[i].text = ""
				self._choice_buttons[i].visible = false
			else:
				self._choice_buttons[i].visible = true
				self._choice_buttons[i].text = str(choice.first) + "," + str(choice.second)
				self._choice_buttons[i].disabled = !choice.legal

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

	self._choice_buttons = [$Choice0, $Choice1, $Choice2]
	$Choice0.connect("pressed", func(): self._on_choice(0))
	$Choice1.connect("pressed", func(): self._on_choice(1))
	$Choice2.connect("pressed", func(): self._on_choice(2))
	self.choices = [null, null, null]

func _on_choice(which: int) -> void:
	self.choices[which].chosen.call()

func prompt_roll_or_stop():
	$Roll.disabled = false
	$Stop.disabled = false

func _on_roll():
	print_debug("roll clicked")
	self.choices = [null, null, null]
	$Roll.disabled = true
	$Stop.disabled = true
	model.roll()

func _on_stop():
	print_debug("stop clicked")
	$Roll.disabled = true
	$Stop.disabled = true
	emit_signal("choice_stop")
