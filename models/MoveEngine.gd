extends Object
class_name MoveEngine

const gdcone = preload("res://models/Cone.gd")

class Move:
	var lane: Lane
	# We track the cone move
	var from: Space
	var to: Space
	# The cone tracks the marker move should the player
	# stop on the next turn.
	var cone: Cone

	func new_cone() -> bool:
		return from == null

class MoveSet:
	var first: Move
	var second: Move

	func unique_key() -> int:
		assert(first != null)
		# A MoveSet is considered equal to another
		# if the effective move result is the same.
		# This happens if cones are not exhausted and
		# the lanes are the same.
		var low: Move = first
		var high: Move = second
		if high != null && low.lane.value > high.lane.value:
			low = second
			high = first

		var key: int = (low.lane.value << 8)
		if low.new_cone():
			key |= 0x8000

		if high != null:
			high.lane.value
			if high.new_cone():
				key |= 0x0080

		return key

var _board: Board = null

func _calculate_move(val: int, turn: Turn, num_moves: int) -> Move:
	var lane: Lane = _board.lane_for_value(val)

	var move: Move = Move.new()
	move.lane = lane

	if lane.winner != null:
		print("%s already owns lane %d" % [lane.winner.player_name, lane.value])
		return null

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
		var cone: Cone = Cone.new(turn.player, space)

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

	# Allow advancing two if we wouldn't overrun
	if num_moves == 2 && !move.to.is_top:
		move.to = lane.spaces[move.to.rank + 1]

	return move

func _init(board: Board):
	_board = board

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
			num_moves = 2

		var first_move: Move = _calculate_move(first, turn, num_moves)
		if first_move == null:
			print("first move is not possible")
			continue

		var second_move: Move = null

		if first != second:
			second_move = _calculate_move(second, turn, 1)

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
