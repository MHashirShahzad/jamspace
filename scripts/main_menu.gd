extends Control


func _ready() -> void:
	$CanvasLayer/VBoxContainer/PlayButton.grab_focus()
	SfxManager.play_music(SfxManager.CLOCK, -10)

func _on_play_button_pressed() -> void:
	$CanvasLayer/VBoxContainer/PlayButton.disabled = true
	$CanvasLayer/VBoxContainer/QuitButton.disabled = true
	
	TransitionManager.start_transition()
	await TransitionManager.transiton_finsihed
	Global.time = 0
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_quit_button_pressed() -> void:
	$CanvasLayer/VBoxContainer/PlayButton.disabled = true
	$CanvasLayer/VBoxContainer/QuitButton.disabled = true
	TransitionManager.start_transition()
	await TransitionManager.transiton_finsihed
	get_tree().quit()
