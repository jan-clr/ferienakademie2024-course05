extends Node

var dig_sounds: Array = []  # Array to store the 5 different dig sounds
var current_dig_sound: AudioStreamPlayer = null  # Reference to the currently playing sound

var click_sound : AudioStreamPlayer = null
var main_menu_music : AudioStreamPlayer = null
var level_music : AudioStreamPlayer = null
var win_music : AudioStreamPlayer = null
var lose_music : AudioStreamPlayer = null
var dig_music : AudioStreamPlayer = null
var water_music : AudioStreamPlayer = null
var build_music : AudioStreamPlayer = null
var elec_music : AudioStreamPlayer = null
var dig_music_1: AudioStreamPlayer = null
var dig_music_2: AudioStreamPlayer = null
var dig_music_3: AudioStreamPlayer = null
var dig_music_4: AudioStreamPlayer = null
var dig_music_5: AudioStreamPlayer = null
var gong_music: AudioStreamPlayer = null
var village_music: AudioStreamPlayer = null

var click_sound_path : String = "res://assets/music/click_music.mp3"
var main_menu_music_path : String = "res://assets/music/menu_music.mp3"
var level_music_path : String = "res://assets/music/level_music.mp3"
var win_music_path : String = "res://assets/music/win_music.mp3"
var lose_music_path : String = "res://assets/music/lose_music.mp3"
var dig_music_path : String = "res://assets/music/dig_music.mp3"
var water_music_path : String = "res://assets/music/water_music.mp3"
var build_music_path : String = "res://assets/music/build_music.mp3"
var elec_music_path : String = "res://assets/music/elec_music.mp3"
var gong_music_path : String = "res://assets/music/gong_music.mp3"
var dig_music_1_path : String = "res://assets/music/dig_music_1.mp3"
var dig_music_2_path : String = "res://assets/music/dig_music_2.mp3"
var dig_music_3_path : String = "res://assets/music/dig_music_3.mp3"
var dig_music_4_path : String = "res://assets/music/dig_music_4.mp3"
var dig_music_5_path : String = "res://assets/music/dig_music_5.mp3"
var village_music_path : String = "res://assets/music/village_music.mp3"

var is_digging: bool = false  # Track if the RMB is pressed
var is_building: bool = false  # Track if the RMB is pressed
var random_loop_active: bool = false  # To manage the loop state
var is_elec: bool = false
var is_village: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize the audio players
	click_sound = AudioStreamPlayer.new()
	main_menu_music = AudioStreamPlayer.new()
	level_music = AudioStreamPlayer.new()
	win_music = AudioStreamPlayer.new()
	lose_music = AudioStreamPlayer.new()
	dig_music = AudioStreamPlayer.new()
	water_music = AudioStreamPlayer.new()
	build_music = AudioStreamPlayer.new()
	elec_music = AudioStreamPlayer.new()
	gong_music = AudioStreamPlayer.new()
	dig_music_1 = AudioStreamPlayer.new()
	dig_music_2 = AudioStreamPlayer.new()
	dig_music_3 = AudioStreamPlayer.new()
	dig_music_4 = AudioStreamPlayer.new()
	dig_music_5 = AudioStreamPlayer.new()
	village_music = AudioStreamPlayer.new()
	
	# Assign the audio buses
	click_sound.bus = "sfx"  # Set to 'sfx' bus
	main_menu_music.bus = "music"  # Set to 'music' bus
	level_music.bus = "music"
	win_music.bus = "sfx"
	lose_music.bus = "sfx"
	dig_music.bus = "sfx"
	water_music.bus = "sfx"
	build_music.bus = "sfx"
	gong_music.bus = "sfx"
	elec_music.bus = "sfx"
	dig_music_1.bus = "sfx"
	dig_music_2.bus = "sfx"
	dig_music_3.bus = "sfx"
	dig_music_4.bus = "sfx"
	dig_music_5.bus = "sfx"
	village_music.bus = "sfx"
	
	# Load the audio files
	click_sound.stream = load(click_sound_path)
	main_menu_music.stream = load(main_menu_music_path)
	level_music.stream = load(level_music_path)
	win_music.stream = load(win_music_path)
	lose_music.stream = load(lose_music_path)
	dig_music.stream = load(dig_music_path)
	water_music.stream = load(water_music_path)
	build_music.stream = load(build_music_path)
	gong_music.stream = load(gong_music_path)
	elec_music.stream = load(elec_music_path)
	dig_music_1.stream = load(dig_music_1_path)
	dig_music_2.stream = load(dig_music_2_path)
	dig_music_3.stream = load(dig_music_3_path)
	dig_music_4.stream = load(dig_music_4_path)
	dig_music_5.stream = load(dig_music_5_path)
	village_music.stream = load(village_music_path)
	
	dig_music.stream.loop = false  # Ensure loop is disabled
	build_music.stream.loop = false  # Ensure loop is disabled
	elec_music.stream.loop = false  # Ensure loop is disabled
	village_music.stream.loop = false
	
	# Set the volume for main menu music
	main_menu_music.volume_db = 0
	click_sound.volume_db = -10
	level_music.volume_db = -20
	win_music.volume_db = 0
	lose_music.volume_db = 0
	dig_music.volume_db = -5
	water_music.volume_db = -15
	build_music.volume_db = 0
	elec_music.volume_db = 0
	gong_music.volume_db = 0
	village_music.volume_db = 0

	# Add them to the scene tree
	add_child(click_sound)
	add_child(main_menu_music)
	add_child(level_music)
	add_child(win_music)
	add_child(lose_music)
	add_child(dig_music)
	add_child(water_music)
	add_child(build_music)
	add_child(elec_music)
	add_child(dig_music_1)
	add_child(dig_music_2)
	add_child(dig_music_3)
	add_child(dig_music_4)
	add_child(dig_music_5)
	add_child(gong_music)
	add_child(village_music)
	
	dig_sounds = [dig_music_1, dig_music_2, dig_music_3, dig_music_4, dig_music_5]

# Function to play click sound
func play_click_sound() -> void:
	if click_sound:
		click_sound.play()
		
# Function to play water sound
func play_water_sound() -> void:
	if water_music:
		water_music.play()
		
# Function to stop water sound
func stop_water_sound() -> void:
	if water_music and water_music.playing:
		water_music.stop()
		
		
		

func play_gong_sound() -> void:
	if gong_music:
		gong_music.play()
		

func stop_gong_sound() -> void:
	if gong_music and gong_music.playing:
		gong_music.stop()
		

# Function to play main menu music
func play_main_menu_music() -> void:
	if main_menu_music:
		# Ensure it's not playing multiple times
		if not main_menu_music.playing:
			main_menu_music.play()

# Function to stop the main menu music
func stop_main_menu_music() -> void:
	if main_menu_music and main_menu_music.playing:
		main_menu_music.stop()
		

# Function to fade out the main menu music
func fade_out_main_menu_music() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(main_menu_music, "volume_db", -15, 0.2).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	
func fade_in_main_menu_music() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(main_menu_music, "volume_db", 0, 0.5).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	
	
	
# Function to play win music and handle volume transition
func play_win_music() -> void:
	# Ensure win music only plays once
	if win_music and not win_music.playing:
		win_music.play()

	# Wait for win music to finish
	var win_music_length = win_music.stream.get_length()  # Get the length of the win music
	await get_tree().create_timer(win_music_length).timeout

	# Fade in main menu music after win music finishes
	await fade_in_main_menu_music()
		
func play_lose_music() -> void:
	# Ensure lose music only plays once
	if lose_music and not lose_music.playing:
		lose_music.play()

	# Wait for lose music to finish
	var lose_music_length = lose_music.stream.get_length()  # Get the length of the lose music
	await get_tree().create_timer(lose_music_length).timeout

	# Fade in main menu music after lose music finishes
	await fade_in_main_menu_music()

# Function to handle the entire process when transitioning to the win screen
func handle_win_screen_transition() -> void:
	await fade_out_main_menu_music()  # Fade out the main menu music
	await play_win_music()  # Play win music
	
func handle_lose_screen_transition() -> void:
	await fade_out_main_menu_music()  # Fade out the main menu music
	await play_lose_music()  # Play win music
	
	

	
	
	
	
	
	
	
	
	
	
	
	

# Function to play dig sound once or loop if held
func start_digging() -> void:
	if not is_digging:
		is_digging = true
		dig_music.stream.loop = true  # Set loop while the button is held
		if not dig_music.playing:
			dig_music.play()

# Function to stop looping but allow dig_music to finish
func stop_digging() -> void:
	if is_digging:
		is_digging = false
		dig_music.stream.loop = false  # Stop looping
		# Let the music finish its current cycle but not loop further
		

		













	
	
	
	
	

func start_building() -> void:
	if not is_building:
		is_building = true
		build_music.stream.loop = true  # Set loop while the button is held
		if not build_music.playing:
			build_music.play()


func stop_building() -> void:
	if is_building:
		is_building = false
		build_music.stream.loop = false  # Stop looping
		# Let the music finish its current cycle but not loop further	
	
	
# Function to forcefully stop all ongoing sounds (digging and building)
func force_stop_all_sounds() -> void:
	# Stop the dig music if it's playing
	if dig_music.playing:
		dig_music.stop()
	is_digging = false
	
	# Stop the build music if it's playing
	if build_music.playing:
		build_music.stop()
	is_building = false
	
	
	if elec_music.playing:
		elec_music.stop()
	is_elec = false
	
	
	
	
	
	
	# Function to play electric sound once or loop if held
func start_electricity() -> void:
	if not is_elec:
		is_elec = true
		elec_music.stream.loop = true  # Set loop while the button is held
		if not elec_music.playing:
			elec_music.play()

# Function to stop looping but allow electric to finish
func stop_electricity() -> void:
	if is_elec:
		is_elec = false
		elec_music.stream.loop = false  # Stop looping
		# Let the music finish its current cycle but not loop further
	
	
	
	

func start_village() -> void:
	if not is_village:
		is_village = true
		village_music.stream.loop = true  # Set loop while the button is held
		if not village_music.playing:
			village_music.play()

func stop_village() -> void:
	if is_village:
		is_village = false
		village_music.stream.loop = false  # Stop looping
		# Let the music finish its current cycle but not loop further
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
