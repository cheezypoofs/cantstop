extends Node

var model: Lane:
	get:
		return model

func init(lane: Lane) -> void:
	var space_scene = load("res://scenes/Space.tscn")

	self.model = lane

	var scenes = []
	var spaces = self.model.spaces

	# Create scenes for each space model and align them
	# bottom to top.

	var num_spaces: int = len(spaces)
	const space_size: int = 40
	var v_size: int = num_spaces * space_size
	var y_offset: int = (640 - v_size) / 2

	for i in range(num_spaces):
		var space_model: Space = spaces[num_spaces-i-1]
		var new_scene = space_scene.instantiate()
		new_scene.init(space_model)
		new_scene.position = Vector2(0, y_offset + (i*space_size))
		new_scene.size = Vector2(32, 32)
		add_child(new_scene)

func _ready() -> void:
	$Value.text = str(self.model.value)
