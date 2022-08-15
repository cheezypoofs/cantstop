extends Node2D

const gdturn = preload("res://models/Turn.gd")

var _players = []
var _current: int = -1

func _ready():
	var aa: ActionArea = $ActionArea
	aa.connect("choice_stop", self._player_stopped)
	aa.connect("choice_rolled", self._player_rolled)
	
	var p1: Player = load("res://models/Player.gd").new()
	p1.init("Player 1", Color.BLUE)
	self._players.append(p1)

	var p2: Player = load("res://models/Player.gd").new()
	p2.init("Player 2", Color.GREEN)
	self._players.append(p2)
	
	self._to_next_player()
	
func _to_next_player() -> void:
	var aa: ActionArea = $ActionArea

	self._current += 1
	if self._current >= len(self._players):
		self._current = 0
	
	var player: Player = self._players[self._current]
	var turn: Turn = gdturn.new()
	turn.init(player)

	aa.current_player = player
	aa.prompt_roll_or_stop()

func _player_stopped() -> void:
	# todo: capture cones. move markers.
	# todo: advance to next player
	
	self._to_next_player()
	
func _player_rolled() -> void:
	var aa: ActionArea = $ActionArea
	print_debug("dice=", aa.die_values)
	
	# todo: all the things
