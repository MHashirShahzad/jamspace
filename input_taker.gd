extends Node2D
class_name InputTaker

var active_label : RichTextLabel = null
var current_letter_index : int = -1

	
func find_new_active_label(typed_character : String):
	var prompt : String = $"../RichTextLabel".text.to_lower()
	
	if prompt.substr(0, 1) == typed_character:
		active_label = $"../RichTextLabel"
		print("New label found")
		current_letter_index = 1
		
func _unhandled_input(event: InputEvent) -> void:
	if !(event is InputEventKey and not event.is_pressed()):
		return
		
	var typed_event : InputEventKey = event as InputEventKey
		
	# get_window().set_ime_active(true) # necessary for unicode to work
		
	# print("TYPED EVENT: ", typed_event)
	# var key_typed = String.chr(typed_event.unicode) # for some reason unicode is 0
	var key_typed = OS.get_keycode_string(typed_event.keycode).to_lower()
		
	print("KEY TYPED: ", key_typed)
	# print("Key Unicode: ", typed_event.unicode)
		
	if active_label == null:
		find_new_active_label(key_typed)
	else:
		var prompt : String = active_label.text.to_lower()
		var next_character = prompt.substr(current_letter_index, 1)
		if key_typed == next_character:
			print("Success, typed '%s'" % key_typed)
			current_letter_index += 1
				
			if current_letter_index == prompt.length():
				current_letter_index = -1
				active_label.queue_free()
				active_label = null
		else:
			print("INCORRECT, typed '%s' expected '%s'" % [key_typed, next_character])
