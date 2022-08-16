extends Node2D

const gdturn = preload("res://models/Turn.gd")
const gdaa = preload("res://scenes/ActionArea.gd")

var board: Board = null
var state: GameState = null
var aa: ActionArea = null
var engine: MoveEngine = null

func _ready():
	var p1: Player = load("res://models/Player.gd").new("Player 1", Color.BLUE)

	var p2: Player = load("res://models/Player.gd").new("Player 2", Color.GREEN)

	board = load("res://models/Board.gd").new()
	$Board.model = board

	engine = load("res://models/MoveEngine.gd").new(board)

	state = load("res://models/GameState.gd").new(board, [p1, p2])

	aa = load("res://models/ActionArea.gd").new()

	$ActionArea.model = aa
	$ActionArea.connect("choice_stop", self._player_stopped)
	aa.connect("dice_rolled", self._player_rolled)

	self._to_next_player()

func _to_next_player() -> void:
	var turn: Turn = self.state.next_turn()

	$ActionArea.current_player = turn.player
	$ActionArea.prompt_roll_or_stop()

func _player_stopped() -> void:
	# todo: capture cones. move markers.
	# todo: advance to next player

	self._to_next_player()

func _player_rolled() -> void:
	print_debug("dice=", aa.die_values)

	var vals = aa.die_values

	var moves = engine.calculate_moves(state.current_turn, aa)
	if len(moves) == 0:
		print_debug("must surrender")
	else:
		for move_set in moves:
			print_debug("moveset...")
			for move in [move_set.first, move_set.second]:
				if move != null:
					print_debug("  lane %d" % (move.lane.value))


	return
	$ActionArea.choices = [
		gdaa.Choice.new(
			vals[0] + vals[1],
			vals[2] + vals[3],
			true,
		),
		gdaa.Choice.new(
			vals[0] + vals[2],
			vals[1] + vals[3],
			true,
		),
		gdaa.Choice.new(
			vals[0] + vals[3],
			vals[1] + vals[2],
			true,
		),
	]

	# todo: all the things
