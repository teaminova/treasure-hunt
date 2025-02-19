extends Area3D

signal collected
@onready var collect_sound = $CollectSound  

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("collected")
		collect_sound.play()
		await collect_sound.finished
		queue_free()
