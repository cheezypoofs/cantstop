extends Node2D
class_name GameState
# GameState tracks the shared models like Board
# and the Player[]'s and then also the current Turn.

var players = []:
	get:
		return players

var board: Board = null:
	get:
		return board

var current_turn: Turn = null:
	get:
		return current_turn

var _current: int = -1

func _init(board: Board, players: Array):
	self.board = board
	self.players = players

# next_turn moves the current_turn to the next Player
# and returns the new Turn instance.
func next_turn() -> Turn:
	assert(players)
	_current += 1
	if _current >= len(players):
		_current = 0
	current_turn = Turn.new(players[_current])
	return current_turn
