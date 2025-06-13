extends Node2D

# Timer
var time:float
var time_sec:int
var time_msec:int
var time_min:int
var timer_stopped : bool = true

@onready var time_label: Label = $TimerLayer/TimeLabel
@onready var death_screen: CanvasLayer = $DeathScreen

func _process(delta: float) -> void:
	update_time(delta)

func update_time(delta):
	if timer_stopped:
		return
	time += delta
	time_msec = fmod(time, 1) * 100
	time_sec = fmod(time, 60)
	time_min = fmod(time, 3600) / 60
	time_label.text = "%02d:%02d.%02d" % [time_min, time_sec, time_msec]
	#min_label.text = "%02d:" % time_min
	#sec_label.text = "%02d." % time_sec
	#msec_label.text = "%03d" % time_msec

func lose_screen(lose_text : String) -> void:
	$DeathScreen/VBoxContainer2/Mistake.text = lose_text
	$DeathScreen/VBoxContainer/RestartButton.grab_focus()
	timer_stopped = true
	print("You Survived for: ", time_label.text)
	death_screen.show()

func _on_restart_button_pressed() -> void:
	TransitionManager.start_transition()
	await TransitionManager.transiton_finsihed
	print("File Path: %s" % get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
	death_screen.hide()
	await TransitionManager.transition_fully_finished
	timer_stopped = false

func _on_quit_button_pressed() -> void:
	TransitionManager.start_transition()
	await TransitionManager.transiton_finsihed
	get_tree().quit()
