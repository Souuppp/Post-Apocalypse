extends Control





func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")



func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
