extends Node
class_name Board

const LANE_MIN = 2
const LANE_MAX = 12

var lanes = []:
	get:
		return lanes

func lane_for_value(v: int) -> Lane:
	assert(v >= LANE_MIN && v <= LANE_MAX)
	return lanes[v - LANE_MIN]

func _init():
	for n in range(LANE_MIN, LANE_MAX+1):
		var lane := Lane.new(n)
		lanes.append(lane)
