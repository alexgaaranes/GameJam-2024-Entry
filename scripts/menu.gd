extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_start_button_pressed():	# Start Button Signal
	get_tree().change_scene_to_file("res://scenes/main_level.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
