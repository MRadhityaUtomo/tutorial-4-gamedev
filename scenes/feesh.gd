extends RigidBody2D

@export var sceneName: String = "LoseScreen"
@export var knockback_recovery_time: float
var original_modulate := Color(1, 1, 1)
var is_being_knocked_back = false

func _on_body_entered(body: Node2D) -> void:
	# Only transition to lose screen if not being knocked back and the collision is with the player
	if body.get_name() == "Player" and !is_being_knocked_back:
		get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))

func apply_knockback(force: Vector2):
	# Visual flash effect
	var flash_color = Color(100, 100, 100)
	$Sprite2D.modulate = flash_color
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", original_modulate, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	# Set particle direction (opposite to the force direction)
	var particle_direction = -force.normalized()
	$GPUParticles2D.process_material.direction = Vector3(particle_direction.x, particle_direction.y, 0)
	
	# Emit particles
	$GPUParticles2D.emitting = true
	
	# Apply knockback
	is_being_knocked_back = true
	apply_central_impulse(force)
	await get_tree().create_timer(knockback_recovery_time).timeout
	is_being_knocked_back = false
