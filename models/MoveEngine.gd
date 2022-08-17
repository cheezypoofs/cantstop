extends Object
class_name MoveEngine
# MoveEngine is the logic that computes legal moves
# on the game board. It can also annotate and rank
# those moves for NPCs or providing game hints to
# a player.

var _board: Board = null

func _init(board: Board):
	_board = board

# _calculate_move is used internally to see what
# Move can be made in the Lane in this Turn.
func _calculate_move(val: int, turn: Turn, num_moves: int) -> Move:
	var lane: Lane = _board.lane_for_value(val)

	if lane.winner != null:
		print("%s already owns lane %d" % [lane.winner.player_name, lane.value])
		return null

	var move: Move = Move.new()
	move.lane = lane

	# Let's see if we have a cone already on this lane.
	var space: Space = lane.find_cone()
	if space != null:
		if space.is_top:
			print("lane %d already has a cone at the top" % [lane.value])
			return null

		# Moving the exsting cone from its current space
		# to the next.
		move.from = space
		move.to = lane.spaces[space.rank + 1]
		move.cone = space.cone
	else:
		# See what space is next for this user
		space = lane.player_space(turn.player)

		# Always allocate a cone. The caller will decide
		# if the player has enough.
		var cone := Cone.new(turn.player, space)

		# Advance space to the 0th or next rank
		if space == null:
			space = lane.spaces[0]
		else:
			space = lane.spaces[space.rank + 1]

		# move.from remains null
		move.to = space
		move.cone = cone

	assert(move.to != null)
	assert(move.cone != null)

	# Allow advancing two if we can
	if num_moves == 2 && !move.to.is_top:
		move.to = lane.spaces[move.to.rank + 1]

	return move

# calculate_moves returns a []MoveSet that represents
# the legal moves a player may make. It looks at all
# combinations of the current dice in the ActionArea
# and de-dupes MoveSet's that are the same. Moves that
# require cones will be removed if the Turn lacks sufficient
# cones to execute.
# An empty array will be returned if there are no legal
# moves, which indicates the player must surrender the turn.
func calculate_moves(turn: Turn, aa: ActionArea) -> Array:

	# Consider each of the 6 combinations of dice values.
	# (We have to consider all 6 because the order may
	# 	matter if there is only one cone left to play).
	# Our MoveSet unique_key will dedupe anything that
	# is functionally the same though.
	var vals = aa.die_values
	var move_pairs = [
		[vals[0] + vals[1], vals[2] + vals[3]],
		[vals[2] + vals[3], vals[0] + vals[1]],

		[vals[0] + vals[3], vals[1] + vals[2]],
		[vals[1] + vals[2], vals[0] + vals[3]],

		[vals[0] + vals[2], vals[1] + vals[3]],
		[vals[1] + vals[3], vals[0] + vals[2]],
	]

	var dedup = {}

	for mp in move_pairs:
		var first = mp[0]
		var second = mp[1]

		print("considering move %d,%d" % [first, second])

		var num_moves: int = 1
		if first == second:
			# for example, user has two 7's.
			# we will attempt to see if we can move two
			# in that Lane.
			num_moves = 2

		var first_move: Move = _calculate_move(first, turn, num_moves)
		if first_move == null:
			print("first move is not possible")
			continue

		var second_move: Move = null

		if first != second:
			second_move = _calculate_move(second, turn, 1)

		# Eliminate moves that require more cones than
		# we have.
		if first_move.new_cone():
			if turn.num_cones == 0:
				# This move set is invalid
				print("first move requires a cone but player has none")
				continue

			if second_move != null && second_move.new_cone() && turn.num_cones == 1:
				# First move is OK, but second isn't.
				print("second remove requires cone but player has only one")
				second_move = null
		elif second_move != null && second_move.new_cone() && turn.num_cones == 0:
			# First move is OK, but second isn't.
			print("second remove requires cone but player has none")
			second_move = null

		var ms := MoveSet.new()
		ms.first = first_move
		ms.second = second_move

		dedup[ms.unique_key()] = ms

	return dedup.values()
