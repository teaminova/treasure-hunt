extends Node

@onready var timer = $GameTimer
@onready var time_label = $TimeLabel

var total_treasures = 10
var treasures_found = 0  # Adjust based on your treasure count

func _ready():
	timer.start()
	update_ui()

func _process(delta):
	var time_left = int(timer.time_left)
	var minutes = time_left / 60
	var seconds = time_left % 60
	time_label.text = "Time: " + str(minutes) + "m " + str(seconds) + "s" + "\nTreasures: " + str(treasures_found) + "/" + str(total_treasures)

func update_ui():
	time_label.text = "Treasures: " + str(treasures_found) + "/" + str(total_treasures)

func _on_treasure_collected():
	treasures_found += 1
	update_ui()
	if treasures_found == total_treasures:
		end_game(true)

func _on_game_timer_timeout():
	end_game(false)
	
func end_game(won: bool):
	# Unlock the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Load the end screen
	var end_screen = load("res://EndScreen.tscn").instantiate()
	end_screen.game_result = "You Won!\nAll " + str(total_treasures) + " treasures are found!" if won else "Time's up! You lost!\nTreasures found: " + str(treasures_found) + "/" + str(total_treasures)
	
	get_tree().root.add_child(end_screen)  # Show end screen
	get_tree().current_scene.queue_free()  # Remove current game scene

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # 'ui_cancel' is mapped to Esc by default
		get_tree().quit()  # Quit the game
