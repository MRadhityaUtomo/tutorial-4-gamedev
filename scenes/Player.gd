extends CharacterBody2D

@export var speed: int = 600
@export var gravity: int = 1600
@export var jump_speed: int = -680
@export var max_jumps: int = 2  # Allow double jump

var jump_count: int = 0  # Track how many times the player has jumped

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
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed

func _physics_process(delta):
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
