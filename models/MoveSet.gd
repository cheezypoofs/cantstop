extends Object
class_name MoveSet

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
