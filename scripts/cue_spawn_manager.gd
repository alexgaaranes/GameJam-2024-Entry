extends Node

var level: Node
var timer: Timer
var cueScene

# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_tree().get_root()
	timer = get_node("CueSpawnTimer")
	cueScene = preload("res://scenes/pedal_cue.tscn")
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_cue_spawn_timer_timeout():
	var cueNode = cueScene.instantiate()
	level.add_child(cueNode)
	timer.start()
