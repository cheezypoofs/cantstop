extends Node
class_name Cone
# Cone is a piece used during a turn to track progress.
# (the white piece). It tracks the Space the player started
# in the Lane (or null) so that at the end of the turn, we
# know from where to pickup the previous progress marker.

var from: Space:
	get:
		return from

var player: Player:
	get:
		return player

func _init(player: Player, from: Space):
	self.from = from
	self.player = player
