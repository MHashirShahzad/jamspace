extends Control
@onready var word_label = $RichTextLabel
@onready var input_line = $LineEdit
@onready var timer = $Timer
@onready var game_over_screen: Node2D = $GameOverScreen

var words = ["Apple", "Mango", "Fruit", "Me"]
var current_word := ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	word_label.bbcode_enabled = true
	next_word()
	input_line.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func next_word():
	current_word = words[randi() % words.size()]
	input_line.text = ""
	update_word_label("")
	timer.start()

func update_word_label(typed_text: String):
	var correct_len = typed_text.length()
	var correct_part = "[color=green]" + current_word.substr(0, correct_len) + "[/color]"
	var remaining_part = current_word.substr(correct_len)
	word_label.bbcode_text = correct_part + remaining_part

func _on_LineEdit_text_changed(new_text: String) -> void:
	if not current_word.begins_with(new_text):
		game_over()
	elif new_text == current_word:
		next_word()
	else:
		update_word_label(new_text)

func _on_Timer_timeout() -> void:
	game_over()

func game_over():
	game_over_screen.visible = true
