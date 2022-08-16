extends Node
class_name Cone

var from: Space:
	get:
		return from

var player: Player:
	get:
		return player

func _init(player: Player, from: Space):
	self.from = from
	self.player = player
