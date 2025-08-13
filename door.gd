extends CharacterBody2D

func _on_area_2d_area_shape_entered():
	get_tree().change_scene_to_file("res://Scenes/world_2.tscn")
