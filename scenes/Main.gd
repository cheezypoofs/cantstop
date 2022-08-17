extends Node2D

var board: Board = null
var state: GameState = null
var aa: ActionArea = null
var engine: MoveEngine = null

signal lane_captured

func _ready():
	var p1: Player = Player.new("Player 1", Color.BLUE)
	var p2: Player = Player.new("Player 2", Color.GREEN)

	board = Board.new()
	$Board.model = board

	engine = MoveEngine.new(board)

	state = GameState.new(board, [p1, p2])

	aa = ActionArea.new()

	$ActionArea.model = aa
	$ActionArea.connect("choice_stop", self._player_stopped)
	aa.connect("dice_rolled", self._player_rolled)
	$ActionArea.connect("move_selected", self._move_selected)
	$ActionArea.connect("move_chosen", self._move_chosen)

	self._to_next_player()

func _to_next_player() -> void:
	var turn: Turn = self.state.next_turn()

	$ActionArea.current_turn = turn
	$ActionArea.prompt_roll_or_stop()

func _player_stopped() -> void:
	print("player stopped. capturing progress")

	# "pickup" cones and move/place markers
	for lane in board.lanes:
		var space = lane.find_cone()
		if space != null:
			# Pickup marker of previous progress
			if space.cone.from != null:
				space.cone.from.remove_marker_for(state.current_turn.player)
			space.add_marker_for(state.current_turn.player)
			space.cone = null

			if space.is_top:
				lane.clear_losers()
				emit_signal("lane_captured")

	self._to_next_player()

func _player_rolled() -> void:
	var moves = engine.calculate_moves(state.current_turn, aa)
	# Even 0 legal moves, which requires a surrender, will
	# come back as a null selection
	$ActionArea.set_move_choices(moves)

func _move_selected() -> void:
	print("todo: highlight the selected move on the board")

func _move_chosen() -> void:
	var move = $ActionArea.selected_move
	if move == null:
		print("player must surrender")
		# Collect all cones
		for lane in board.lanes:
			var space = lane.find_cone()
			if space != null:
				space.cone = null
		self._to_next_player()
		return

	self._execute_move(move.first)
	if move.second != null:
		self._execute_move(move.second)

	$ActionArea.prompt_roll_or_stop()

func _execute_move(move) -> void:
	if move.from != null:
		move.from.cone = null
	else:
		state.current_turn.use_cone()

	move.to.cone = move.cone
