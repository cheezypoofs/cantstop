extends Node
class_name Marker
# Marker is a Player's piece in a Space marking the
# progress in that Lane between Turn's.

var player: Player = null :
	get:
		return player

func _init(p: Player):
	self.player = p
