extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func escapepressed():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	global.lives = 3
	resume()
	get_tree().reload_current_scene()


func _on_level_select_pressed() -> void:
	resume()
	get_tree().change_scene_to_file(str("res://scenes/" + "levelselect" + ".tscn"))


func _on_backtomenu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file(str("res://scenes/" + "main_menu" + ".tscn"))
	
func _process(delta):
	escapepressed()
