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
	for i in range(num_spaces):
		var space_model: Space = spaces[num_spaces-i-1]
		var new_scene = space_scene.instantiate()
		new_scene.init(space_model)
		new_scene.position = Vector2(0, (i+1)*50)
		add_child(new_scene)

func _ready() -> void:
	$Value.text = str(self.model.value)
