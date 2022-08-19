extends Node2D

var board: Board = null
var state: GameState = null
var aa: ActionArea = null
var engine: MoveEngine = null

signal game_winner(player: Player)

func _init() -> void:
	board = Board.new()
	aa = ActionArea.new()
	engine = MoveEngine.new(board)

func _ready():
	# todo: players can come in on initialization of the
	# scene.
	# todo: This is where we can also provide a class
	# that listens to the state changes and makes choices
	# so we can have NPCs.
	var p1: Player = Player.new("Player 1", Color.BLUE)
	var p2: Player = Player.new("Player 2", Color.GREEN)
	var p3: Player = Player.new("Player 3", Color.ORANGE)

	state = GameState.new(board, [p1, p2, p3])

	$Board.model = board
	$ActionArea.model = aa

	# Setup player decisions
	$ActionArea.connect("choice_stop", self._player_stopped)
	$ActionArea.connect("move_selected", self._move_selected)
	$ActionArea.connect("move_chosen", self._move_chosen)

	# Hook to completion of a dice roll
	aa.connect("dice_rolled", self._player_rolled)

	self._to_next_player()

func _to_next_player() -> void:
	var turn: Turn = state.next_turn()

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
				self._on_lane_captured(lane.owner)

	self._to_next_player()

func _on_lane_captured(player: Player) -> void:
	var total: int = 0
	for lane in board.lanes:
		if lane.owner != null && lane.owner.color == player.color:
			total += 1
	if total == 3:
		print("%s is the winner" % [player.player_name])
		emit_signal("game_winner", player)

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
		# Remove cone from old space
		move.from.cone = null
	else:
		# Subtract a cone from the player's stash
		state.current_turn.use_cone()

	# Place the cone
	move.to.cone = move.cone
