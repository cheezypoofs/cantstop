extends Node
class_name Lane

const space_scene = preload("res://scenes/Space.tscn")

var value: int = 0:
	get:
		return value
		
var num_positions: int:
	get:
		return len(self._spaces)

var _spaces = []
	
func player_space(player: Player) -> Space:
	for space in self._spaces:
		if space.has_marker_for(player):
			return space
	return null
	
func init(value: int) -> Lane:
	self.value = value
	var num: int = 12-(2*(abs(7-value)))
	
	# Create the Space instances
	for i in range(num):
		var new_space: Space = space_scene.instantiate()
		new_space.init(i)
		self._spaces.append(new_space)

	# Align them bottom to top		
	for i in range(num):
		var space: Space = self._spaces[num-i-1]
		add_child(space)
		space.position = Vector2(0, 64 + (i * 64))
		
	return self

func _ready():
	assert(self.value != 0)

func _process(delta):
	get_node("Value").text = str(self.value)
