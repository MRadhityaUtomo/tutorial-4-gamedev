extends Area2D

@export var sceneName = "level2"

func _on_body_entered(body:Node2D):
	var current_scene = get_tree().get_current_scene().get_name()
	if body.get_name() == "Player":
		if current_scene == sceneName:
			global.lives -=1
		if (global.lives <= 0):
			get_tree().call_deferred("change_scene_to_file",(str("res://scenes/" + "gameover" + ".tscn")))
		else:
			get_tree().call_deferred("change_scene_to_file",(str("res://scenes/" + sceneName + ".tscn")))
