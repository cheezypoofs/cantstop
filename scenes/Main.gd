extends Node2D

const gdturn = preload("res://models/Turn.gd")

var board: Board = null
var state: GameState = null
var aa: ActionArea = null

func _ready():
	var p1: Player = load("res://models/Player.gd").new()
	p1.init("Player 1", Color.BLUE)

	var p2: Player = load("res://models/Player.gd").new()
	p2.init("Player 2", Color.GREEN)

	board = load("res://models/Board.gd").new()
	$Board.model = board.init()

	state = load("res://models/GameState.gd").new()
	state.init(board, [p1, p2])

	aa = load("res://models/ActionArea.gd").new().init()

	$ActionArea.model = aa
	$ActionArea.connect("choice_stop", self._player_stopped)
	aa.connect("dice_rolled", self._player_rolled)
		
	self._to_next_player()
	
func _to_next_player() -> void:
	var player: Player = self.state.next_player()

	$ActionArea.current_player = player
	$ActionArea.prompt_roll_or_stop()

	var turn: Turn = gdturn.new().init(player)

func _player_stopped() -> void:
	# todo: capture cones. move markers.
	# todo: advance to next player
	
	self._to_next_player()
	
func _player_rolled() -> void:
	print_debug("dice=", aa.die_values)
	
	# todo: all the things
