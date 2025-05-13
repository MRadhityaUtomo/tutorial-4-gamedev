extends Control
var is_paused = false

func _ready():
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$PanelContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_set_buttons_disabled(true)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if is_paused:
			_unpause()
		else:
			_pause()

func _pause():
	is_paused = true
	get_tree().paused = true
	visible = true
	
	mouse_filter = Control.MOUSE_FILTER_STOP
	$PanelContainer.mouse_filter = Control.MOUSE_FILTER_STOP
	_set_buttons_disabled(false)
	
	$AnimationPlayer.play("blur")

func _unpause():
	is_paused = false
	get_tree().paused = false
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	$PanelContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_set_buttons_disabled(true)
	
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	visible = false

func _set_buttons_disabled(disabled: bool):
	for button in $PanelContainer/VBoxContainer.get_children():
		if button is Button:
			button.disabled = disabled

func _on_resume_pressed():
	_unpause()

func _on_restart_pressed():
	global.lives = 3
	_unpause()
	get_tree().reload_current_scene()

func _on_level_select_pressed():
	_unpause()
	get_tree().change_scene_to_file("res://scenes/levelselect.tscn")

func _on_backtomenu_pressed():
	_unpause()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
