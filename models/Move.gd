extends Object
class_name Move

var lane: Lane
# We track the cone move
var from: Space
var to: Space
# The cone tracks the marker move should the player
# stop on the next turn.
var cone: Cone

func new_cone() -> bool:
	return from == null
