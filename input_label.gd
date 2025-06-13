extends Node2D
class_name InputLabel

@export var blue : Color = Color("#4682b4")
@export var green : Color = Color("#639765")
@export var red : Color = Color("#a65455")

@onready var prompt : RichTextLabel = $RichTextLabel

func _ready() -> void:
	prompt.text = prompt.text.strip_edges(true,true) # Strip spaces from left and right

func set_next_character(next_character_index : int):
	var blue_text : String = enclose_string_in_bbcode(blue, prompt.text.substr(0, next_character_index))
	var green_text : String = enclose_string_in_bbcode(green, prompt.text.substr(next_character_index, 1))
	var red_text : String = ""
	print("BLUE TEXT: ", blue_text)
	if next_character_index != prompt.text.length():
		red_text = enclose_string_in_bbcode(red, prompt.text.substr(next_character_index + 1, prompt.text.length() - next_character_index + 1))
	
	red_text = shake_effect(red_text)
	green_text = shake_effect(green_text)
	green_text = pulse_effect(green_text)
	
	prompt.parse_bbcode(blue_text + green_text + red_text)

func enclose_string_in_bbcode(color : Color, string : String) -> String:
	return "[color=#" + color.to_html(false) + "]" + string + "[/color]"

func wavy_effect(string: String) -> String:
	return "[wave amp=50.0 freq=5.0 connected=1]" + string + "[/wave]"

func shake_effect(string: String) -> String:
	return "[shake rate=20.0 level=5 connected=1]" + string + "[/shake]"

func pulse_effect(string: String) -> String:
	return "[pulse freq=3 color=#ffffff40 ease=-2.0]" + string + "[/pulse]"
	
