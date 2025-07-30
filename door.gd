extends CharacterBody2D

func _on_body_entered():
	get_tree().change_scene_to_file("res://Scenes/world_2.tscn")
