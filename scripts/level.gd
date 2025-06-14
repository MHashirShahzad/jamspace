extends Node2D
class_name Level2D

@export var next_level : PackedScene

@export var is_last_level : bool = false

func _ready() -> void:
	if !is_last_level:
		return
		
	Global.set_deferred("timer_stopped", true)
	
	if ! $CanvasLayer/VBoxContainer/TimerLabel:
		return
		
	$CanvasLayer/VBoxContainer/TimerLabel.text = Global.time_label.text
