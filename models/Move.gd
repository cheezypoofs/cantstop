extends Object
class_name Move
# Move is a simple struct-like Object that tracks
# a potential player move (of a Cone) from a Space
# (or null if it's the first move into the Lane)
# to another Space.

var lane: Lane

# from can be null and represents whether this is the
# first move in the Lane (indicated by null)
var from: Space
# to is the Space to which the cone will be moved.
var to: Space
# The cone tracks the marker move should the player
# stop on the next turn.
var cone: Cone

# new_cone returns if the move requires a Cone is taken
# from the Player's Turn or if it's using one already
# in place.
func new_cone() -> bool:
	return from == null
