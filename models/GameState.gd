extends Node2D
class_name GameState

const gdturn = preload("res://models/Turn.gd")

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

func next_turn() -> Turn:
	assert(players)
	_current += 1
	if _current >= len(players):
		_current = 0
	current_turn = gdturn.new(players[_current])
	return current_turn

func next_player() -> Player:
	assert(players)
	_current += 1
	if _current >= len(players):
		_current = 0
	return players[_current]
