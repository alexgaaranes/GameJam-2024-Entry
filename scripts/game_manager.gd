extends Node

var perfectAmt: int = 0
var greatAmt: int = 0
var missedAmt: int = 0

var perfectLabel: Label
var greatLabel: Label
var missedLabel: Label

var parent: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	perfectLabel = parent.get_node("Perfect")
	greatLabel = parent.get_node("Great")
	missedLabel = parent.get_node("Missed")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updatePerfectLabel()
	updateGreatLabel()
	updateMissedLabel()
	pass


# temp funcs
func updatePerfectLabel():
	perfectLabel.text = "Perfect: %d" % [perfectAmt]
	
func updateGreatLabel():
	greatLabel.text = "Great: %d" % [greatAmt]
	
func updateMissedLabel():
	missedLabel.text = "Missed: %d" % [missedAmt]
