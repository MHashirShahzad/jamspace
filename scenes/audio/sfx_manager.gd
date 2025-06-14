extends Node2D

#@export var music_array : Array[AudioStream] = [
	#preload("res://assets/audio/music/hashir/a-video-game-248444.mp3"),
	#preload("res://assets/audio/music/hashir/fast-paced-boss-battle-230222.mp3"),
	#preload("res://assets/audio/music/hashir/game-music-teste-1-204326.mp3"),
	#preload("res://assets/audio/music/hashir/intense-electro-trailer-music-243987.mp3"),
	#preload("res://assets/audio/music/hashir/space-station-247790.mp3"),
	#preload("res://assets/audio/music/hashir/stranger-things-124008.mp3"),
	#preload("res://assets/audio/music/hashir/electric-horizons-239006.mp3"),
	#preload("res://assets/audio/music/hashir/galactic-overture-241181.mp3"),
	## didnt like this one :C
	## preload("res://assets/audio/music/hashir/let-the-games-begin-21858.mp3"),
	#preload("res://assets/audio/music/hashir/synth-city-80x27s-loop-167222.mp3"),
	#preload("res://assets/audio/music/hashir/to-the-death-159171.mp3")
#]
#
#const SHOOT : AudioStream = preload("res://assets/audio/shoot.ogg")
#const NO_AMMO : AudioStream = preload("res://assets/audio/no_ammo.ogg")
#const BULLET_REFILLED : AudioStream = preload("res://assets/audio/bullet_refilled3.ogg")

@export var typing_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/key_press1.mp3"),
	preload("res://assets/audio/key_press2.mp3"),
	preload("res://assets/audio/key_press3.mp3"),
	preload("res://assets/audio/key_press4.mp3"),
	preload("res://assets/audio/key_press5.mp3")
]
@export var wrong_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/blue-screen.mp3"),
	preload("res://assets/audio/windows-error-sound-effect.mp3"),
	preload("res://assets/audio/error-4.mp3")
	
]
@export var correct_sfx_array : Array[AudioStream] = [
	preload("res://assets/audio/coin-pickup.mp3"),
	preload("res://assets/audio/game-start.mp3"),
	# preload("res://assets/audio/game-bonus-2.mp3"),
	# preload("res://assets/audio/video-game-bonus.mp3")
]
const INCORRECT_BUZZER_SOUND = preload("res://assets/audio/incorrect-buzzer-sound.mp3")

@onready var music_player: AudioStreamPlayer = $MusicPlayer

func play_music(stream : AudioStream, volume = 1, fade_dur = 0, pitch_scale = 1) -> void:
	# fade previous music
	var tween := get_tree().create_tween()
	tween.tween_property(music_player, "volume_db", -70, fade_dur)
	await tween.finished
	tween.kill()
	
	music_player.bus = &"Music"
	music_player.stream = stream
	music_player.pitch_scale = pitch_scale
	music_player.play()
	# fade in new music
	var tween_2 := get_tree().create_tween()
	tween_2.tween_property(music_player, "volume_db", volume, fade_dur)
	await tween_2.finished
	tween_2.kill()
	

func play_FX(stream: AudioStream, volume = 10, lower_bound: int = 0.9, upper_bound: int = 1.1):
	# Create new stream player
	var fx_player = AudioStreamPlayer.new()
	# Assign its variables
	fx_player.bus = &"SFX"
	fx_player.stream = stream
	fx_player.name = "fx_player"
	fx_player.volume_db = volume
	# Add random pitch
	fx_player.pitch_scale = randf_range(lower_bound, upper_bound)
	add_child(fx_player)
	fx_player.play()
	# Destroy when completed
	await fx_player.finished
	fx_player.queue_free()

func play_FX_2D(stream: AudioStream,pos : Vector2, volume = 10, lower_bound: int = 1, upper_bound: int = 1.5):
	# Create new stream player
	var fx_player = AudioStreamPlayer2D.new()
	# Assign its variables
	fx_player.global_position = pos
	# fx_player.bus = &"SFX"
	fx_player.stream = stream
	fx_player.name = "fx_player"
	fx_player.volume_db = volume
	# Add random pitch
	fx_player.pitch_scale = randf_range(lower_bound, upper_bound)
	add_child(fx_player)
	fx_player.play()
	# Destroy when completed
	await fx_player.finished
	fx_player.queue_free()

#func adjust_music_volume():
	## if any player is invalid
	#if !(GameManager.p1 or GameManager.p2):
		#return
	#
	#var lowest_health : float
	#if GameManager.p1.health < GameManager.p2.health:
		#lowest_health = GameManager.p1.health
	#else:
		#lowest_health = GameManager.p2.health
	#
#
	#print_debug("---- Music Speed Increased ----")
#
	#var music_speed : float = lerp(1.06, 1.0, lowest_health / 100)
	#
	#print("- Music_Speed : ", music_speed," - health : ", (lowest_health / 100))
	#var tween := get_tree().create_tween()
	#tween.tween_property(music_player, "pitch_scale", music_speed, 1)
	#await tween.finished
	#tween.kill()

#func play_random_bg_music() -> void:
	#var music : AudioStream = music_array.pick_random()
	#var index : int = music_array.find(music)
	#
	#if index == GameManager.level_prefs.prev_music_index:
		#music = music_array.pick_random()
		#index = music_array.find(music)
	#
	#GameManager.level_prefs.prev_music_index = index
	#
	#SFXManager.play_music(music, -10)
