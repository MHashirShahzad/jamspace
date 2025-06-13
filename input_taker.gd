extends Node2D
class_name InputTaker

var active_label : InputLabel = null
var current_letter_index : int = -1

	
func find_new_active_label(typed_character : String):
	for input_label in $"../InputLabelContainer".get_children():
		if !(input_label is InputLabel):
			return
			
		var prompt_text : String = input_label.prompt.text.to_lower()
	
		if prompt_text.substr(0, 1) == typed_character:
			active_label = input_label
			print("New label found: `%s`" % active_label)
			current_letter_index = 1
			active_label.set_next_character(current_letter_index)
			break
		
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
		
		if key_typed == "space": key_typed = " " # still try not to use spaces in textLabels
		
		if key_typed == next_character:
			print("Success, typed '%s'" % key_typed)
			current_letter_index += 1
			active_label.set_next_character(current_letter_index)
			
			if current_letter_index == prompt_text.length():
				print("Label Completed: `%s`" % active_label)
				current_letter_index = -1
				active_label.queue_free()
				active_label = null
		else:
			print("INCORRECT, typed '%s' expected '%s'" % [key_typed, next_character])
