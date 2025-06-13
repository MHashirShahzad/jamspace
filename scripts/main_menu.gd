extends Control


func _on_play_button_pressed() -> void:
	TransitionManager.start_transition()
	await TransitionManager.transiton_finsihed
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_quit_button_pressed() -> void:
	TransitionManager.start_transition()
	await TransitionManager.transiton_finsihed
	get_tree().quit()
