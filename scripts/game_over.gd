extends Node

var timer: Timer
var menuTimer: Timer
var animPlayer: AnimationPlayer
var parent: Node

var statArr: Array
var totalDist: float

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	timer = $Timer
	menuTimer = $MenuTimer
	animPlayer = $AnimationPlayer
	animPlayer.play("fade_in")
	updateLabels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func setStats(arr: Array, dist: float):
	statArr = arr
	totalDist = dist

func updateLabels():
	$TotalDistance.text = "Total Distance:\t%.2fm" % [totalDist]
	$PerfectLabel.text = "Perfect x%d" % [statArr[0]]
	$GreatLabel.text = "Great x%d" % [statArr[1]]
	$MissedLabel.text = "Miss x%d" % [statArr[2]]
	$MaxComboLabel.text = "Max Combo x%d" % [statArr[3]]


func _on_menu_button_pressed():
	animPlayer.play("fade_out")
	menuTimer.start()
	
func _on_restart_button_pressed():
	animPlayer.play("fade_out")
	timer.start()
	
func _on_timer_timeout():
	get_tree().reload_current_scene()

func _on_menu_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
