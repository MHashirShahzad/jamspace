extends Node2D

# Timer
var time:float
var time_sec:int
var time_msec:int
var time_min:int
var timer_stopped:bool
@onready var time_label: Label = $CanvasLayer/TimeLabel


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
