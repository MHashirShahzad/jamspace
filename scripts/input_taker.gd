extends Node2D
class_name InputTaker

var active_label : InputLabel = null
var current_letter_index : int = -1

## IF TRUE PLAYER DIES ON MAKING A MISTAKE
@export var perma_mistake : bool = true

func _ready() -> void:
	call_deferred("pick_new_active_label")
	Global.timer_stopped = false

func pick_new_active_label() -> void:
	var input_label = $"../InputLabelContainer".get_child(0) # First child
	
	if input_label.has_been_typed == true:
		input_label =  $"../InputLabelContainer".get_child(1) # Second child
	
	if input_label == null:
		game_end()
		return
		
	active_label = input_label
	active_label.label_focused()
	current_letter_index = 0
	active_label.set_next_character(current_letter_index)

func find_new_active_label(typed_character : String):
	var input_label = $"../InputLabelContainer".get_child(0) # First child
	if !(input_label is InputLabel):
		return
			
	var prompt_text : String = input_label.prompt.text.to_lower()
	
	if prompt_text.substr(0, 1) == typed_character:
		active_label = input_label
		active_label.label_focused()
		print("New label found: `%s`" % active_label)
		current_letter_index = 1
		active_label.set_next_character(current_letter_index)

func _unhandled_input(event: InputEvent) -> void:
	if !(event is InputEventKey and not event.is_pressed()):
		return
		
	var typed_event : InputEventKey = event as InputEventKey
		
	# get_window().set_ime_active(true) # necessary for unicode to work
		
	# print("TYPED EVENT: ", typed_event)
	# var key_typed = String.chr(typed_event.unicode) # for some reason unicode is 0
	var key_typed = OS.get_keycode_string(typed_event.keycode).to_lower()
		
	print("KEY TYPED: `%s`" %  key_typed)
	# print("Key Unicode: ", typed_event.unicode)
		
	if active_label == null:
		find_new_active_label(key_typed)
	else:
		var prompt_text : String = active_label.prompt.text.to_lower()
		
		var next_character = prompt_text.substr(current_letter_index, 1)
		
		if key_typed.length() > 1: # nullifies space and ctrl
			return 
		
		if key_typed == next_character:
			print("Success, typed '%s'" % key_typed)
			current_letter_index += 1
			active_label.set_next_character(current_letter_index)
			
			if current_letter_index == prompt_text.length():
				print("Label Completed: `%s`" % active_label)
				current_letter_index = -1
				active_label.label_completed()
				active_label = null
				pick_new_active_label()
		else:
			var mistake : String = "Typed '%s', while expected '%s'" % [key_typed, next_character]
			print(mistake)
			
			if perma_mistake:
				Global.lose_screen(mistake)

# i know i can use groups but whatever we need a game not a masterpiece of code
func game_end():
	if get_parent() is Level2D:
		TransitionManager.start_transition()
		await TransitionManager.transiton_finsihed
		get_tree().change_scene_to_packed(get_parent().next_level)
