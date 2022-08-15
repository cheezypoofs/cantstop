extends Node2D
class_name Board

const LANE_MIN = 2
const LANE_MAX = 12

var _lanes = []

func lane_for_value(v: int) -> Lane:
	assert(v >= LANE_MIN && v <= LANE_MAX)
	return self._lanes[v - LANE_MIN]

func _ready():
	for n in range(LANE_MIN, LANE_MAX+1):
		var new_lane: Lane = load("res://scenes/Lane.tscn").instantiate()
		new_lane.init(n)
		self._lanes.append(new_lane)
		new_lane.position = Vector2((n-LANE_MIN) * 64, 0)
		add_child(new_lane)
	
	#var p1: Player = load("res://scripts/Player.gd").new()
	#p1.set_player_name("pickles")
	#p1.set_player_color(Color.RED)
	
	#self.lane_for_value(4).
	
	
func _process(delta):
	pass
