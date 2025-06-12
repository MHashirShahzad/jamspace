extends Node2D
class_name InputTaker

var active_label : RichTextLabel = null
var current_letter_index : int = -1

func _ready() -> void:
	get_window().set_ime_active(true) # necessary for unicode to work
	
func find_new_active_labe(typed_character : String):
	var prompt = $"../RichTextLabel".text
	
	if prompt.substr(0, 1) == typed_character:
		active_label = $"../RichTextLabel"
		print("New label found")
		current_letter_index = 1
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.is_pressed():
		var typed_event : InputEventKey = event as InputEventKey
		
		print("TYPED EVENT: ", typed_event)
		var key_typed = String.chr(typed_event.unicode) # for some reason unicode is 0
		
		print("KEY TYPED: ", key_typed)
		print("Key Unicode: ", typed_event.unicode)
		
		if active_label == null:
			find_new_active_labe(key_typed)
		else:
			var prompt = active_label.text
			var next_character = prompt.substr(current_letter_index, 1)
			
			print("Next Character: ", next_character)
			if key_typed == next_character:
				print("Success")	
				current_letter_index += 1
				
				if current_letter_index == prompt.length():
					current_letter_index = -1
					active_label.queue_redraw()
					active_label = null
			else:
				print("INCORRECT")
