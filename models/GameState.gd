extends Node2D
class_name GameState

var players = []:
	get:
		return players
		
var board: Board = null:
	get:
		return board
		
var _current: int = -1

func init(board: Board, players: Array) -> GameState:
	self.board = board
	self.players = players
	return self
	
func next_player() -> Player:
	assert(self.players)
	_current += 1
	if _current >= len(players):
		_current = 0
	return players[_current]	
