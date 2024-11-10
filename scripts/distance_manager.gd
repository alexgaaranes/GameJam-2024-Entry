extends Node

var distance: float
var maxCombo: int
var isSlowing: bool = false

# Labels
var distLabel: Label

# Object references
var parent: Node
var root: Node
var scoreManager: Node
var timer: Timer
var road: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	root = parent.get_parent()
	distLabel = root.get_node("Distance")
	scoreManager = parent.get_node("ScoreManager")
	road = root.get_node("Road")
	timer = $SlowdownTimer
	distance = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateDistance(delta)
	updateDistanceLabel()


func updateDistanceLabel():
	distLabel.text = "Distance: %.2fm" % [distance]
	
func updateDistance(delta):
	if isSlowing:
		road.updateRoad(timer.time_left*maxCombo*delta)
		distance += timer.time_left*maxCombo*delta
		return
	if scoreManager.getCombo() == 0 and not isSlowing:
		timer.start()
		isSlowing = true
	else:
		maxCombo = scoreManager.getCombo()
		if maxCombo == 1:
			road.updateRoad(2*delta)
			distance += 2*delta
			return
		road.updateRoad(maxCombo*delta)
		distance += maxCombo*delta


func _on_slowdown_timer_timeout():
	isSlowing = false
	maxCombo = 0
	

func getDistance():
	return distance
