extends Node2D

var model: Board:
	get:
		return model
		
func _ready():
	# Board and lanes are dynamically rendered by us
	# so we insantiate the board model on scene
	# creation.
	# todo: Do I like this?
	model = load("res://models/Board.gd").new()
	model.init()
	var lanes = model.lanes
	
	var num_lanes = len(lanes)
	for n in range(num_lanes):
		var new_lane = load("res://scenes/Lane.tscn").instantiate()
		new_lane.init(lanes[n])
		new_lane.position = Vector2(n * 64, 0)
		add_child(new_lane)
