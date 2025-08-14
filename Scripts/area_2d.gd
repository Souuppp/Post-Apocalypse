extends Area2D

func _on_body_entered(body: Node2D):
	if body.scene_file_path == "res://Scenes/player.tscn":
		get_tree().change_scene_to_file("res://Scenes/world_2.tscn")
		
