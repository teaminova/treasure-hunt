extends Control

@onready var result_label = $ResultLabel
@onready var play_again_button = $PlayAgainButton
@onready var quit_button = $QuitButton

var game_result = "You Won!\nAll treasures are found!"  # Default message

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Ensure mouse is unlocked
	result_label.text = game_result  # Update text when scene loads

	play_again_button.pressed.connect(_on_play_again_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_again_pressed():
	queue_free()
	get_tree().change_scene_to_file("res://MainScene.tscn")  # Restart the game
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Lock mouse again

func _on_quit_pressed():
	get_tree().quit()  # Quit the game
