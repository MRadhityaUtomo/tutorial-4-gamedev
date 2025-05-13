extends CharacterBody2D

@export var speed: int = 600
@export var gravity: int = 1600
@export var jump_speed: int = -680
@export var max_jumps: int = 2  # Allow double jump
@export var bullet_scene: PackedScene  # Add this line to reference the bullet scene
@export var shoot_cooldown: float = 0.3  # Cooldown between shots

var jump_count: int = 0  # Track how many times the player has jumped
var can_shoot: bool = true  # Track if player can shoot
@onready var particle = $GPUParticles2D


func get_input():
	velocity.x = 0
	
	# Handle Jumping
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			jump_count = 1  
		elif jump_count < max_jumps:  
			velocity.y = jump_speed
			jump_count += 1   

	# Horizontal Movement
	if Input.is_action_pressed('right'):
		velocity.x += speed
		if is_on_floor():
			particle.set_emitting(true)
	elif Input.is_action_pressed('left'):
		velocity.x -= speed
		if is_on_floor():
			particle.set_emitting(true)
	else:
		particle.set_emitting(false)
	if Input.is_action_just_pressed("fire") and can_shoot:
		shoot()

func shoot():
	# Create instance of bullet
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	
	# Position the bullet at the ShootMarker
	var marker = $Node2D/ShootMarker
	bullet.global_position = marker.global_position
	
	# Calculate direction from marker to mouse cursor
	var mouse_pos = get_global_mouse_position()
	var shoot_direction = (mouse_pos - marker.global_position).normalized()
	
	# Set bullet direction
	bullet.set_direction(shoot_direction)
	
	# Start cooldown
	can_shoot = false
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true

func _physics_process(delta):
	$Node2D.look_at(get_global_mouse_position())
	velocity.y += delta * gravity  # Apply gravity
	get_input()
	move_and_slide()

	# Reset jump count when touching the ground
	if is_on_floor():
		jump_count = 0

func _process(_delta):
	# Play animations based on movement
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	# Flip sprite based on movement direction
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0
