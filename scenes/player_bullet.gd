extends Area2D

@export var bullet_speed = 3000
@export var knockback_force = 1000
@export var lifetime = 2.0

var direction = Vector2.RIGHT

func _ready() -> void:
	
	# Set up a timer to destroy the bullet after lifetime seconds
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = lifetime
	timer.one_shot = true
	timer.timeout.connect(_on_lifetime_timeout)
	timer.start()

func _process(delta: float) -> void:
	# Move the bullet in the specified direction
	position += direction * bullet_speed * delta

func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()
	# Rotate the bullet to match its direction
	rotation = direction.angle()
	
	# Add a rotation offset if needed based on your sprite's default orientation
	# If your bullet points upward by default in the sprite, add this line:
	rotation += PI/2  # 90 degrees offset

func _on_lifetime_timeout():
	queue_free()

func _on_body_entered(body: Node2D):
	if body.is_in_group("projectile"):
		# Apply knockback if the body has the method
		if body.has_method("apply_knockback"):
			body.apply_knockback(direction * knockback_force)
		
		# Destroy the bullet
		queue_free()
