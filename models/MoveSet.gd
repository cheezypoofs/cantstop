extends Object
class_name MoveSet
# MoveSet is a simple struct-like Object that holds
# a first and second move.

# first will always exist since otherwise there is no MoveSet.
var first: Move
# second is optional and will be null when there is no legal
# other move, for eample if the Player lacks additional cones
# or Lane's are already won.
var second: Move

# unique_key is a quick way to compare the intent of the
# two Move's in the MoveSet.
# A MoveSet is considered equal to another
# if the effective move result is the same.
# This happens if cones are not exhausted and
# the lanes are the same.
func unique_key() -> int:
	assert(first != null)

	var low: Move = first
	var high: Move = second

	# Order the two moves so that the compare is
	# deterministic.
	if high != null && low.lane.value > high.lane.value:
		low = second
		high = first

	# Map bits in for the lane value and the presence of
	# an existing cone.
	var key: int = (low.lane.value << 8)
	if low.new_cone():
		key |= 0x8000

	# Same on the second move.
	if high != null:
		high.lane.value
		if high.new_cone():
			key |= 0x0080

	return key
