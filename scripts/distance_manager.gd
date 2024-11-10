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

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	root = parent.get_parent()
	distLabel = root.get_node("Distance")
	scoreManager = parent.get_node("ScoreManager")
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
		# TODO: Slowing Down Anim when missed
		# PUT THE SLOWING DOWN ANIMATION HERE
		distance += timer.time_left*maxCombo*delta
		return
	if scoreManager.getCombo() == 0 and not isSlowing:
		timer.start()
		isSlowing = true
	else:
		maxCombo = scoreManager.getCombo()
		if maxCombo == 1:
			distance += 2*delta
			return
		distance += maxCombo*delta


func _on_slowdown_timer_timeout():
	isSlowing = false
	maxCombo = 0
	

func getDistance():
	return distance
