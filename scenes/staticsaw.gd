extends StaticBody2D

@export var rotation_speed: float = 1.0  # Speed of rotation (radians per second)

func _process(delta: float) -> void:
	rotation += rotation_speed * delta  # Rotate the object over time
