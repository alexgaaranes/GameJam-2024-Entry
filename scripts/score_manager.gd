extends Node

var multiplier: float = 0

# Label object references
var perfectLabel: Label
var greatLabel: Label
var missedLabel: Label

# Score Component
var perfectAmt: int = 0
var greatAmt: int = 0
var missedAmt: int = 0
var comboAmt: int = 0

var root: Node
var parent: Node
var cueSpawnManager: Node
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	root = parent.get_parent()
	cueSpawnManager = parent.get_node("CueSpawnManager")
	perfectLabel = root.get_node("Perfect")
	greatLabel = root.get_node("Great")
	missedLabel = root.get_node("Missed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updatePerfectLabel()
	updateGreatLabel()
	updateMissedLabel()

# Setters & Getters
func updateCombo():
	comboAmt += 1
	cueSpawnManager.reduceTime(comboAmt/150.0)

func resetCombo():
	comboAmt = 0
	cueSpawnManager.resetTime()

func addPerfect(amount: int):
	perfectAmt += amount
	parent.updateHP(0.5)

func addGreat(amount: int):
	greatAmt += amount

func addMissed(amount: int):
	missedAmt += amount
	resetCombo()
	parent.updateHP(-3)
	
# temp funcs
func updatePerfectLabel():
	perfectLabel.text = "Perfect: %d" % [perfectAmt]
	
func updateGreatLabel():
	greatLabel.text = "Great: %d" % [greatAmt]
	
func updateMissedLabel():
	missedLabel.text = "Missed: %d" % [missedAmt]

func getCombo():
	return comboAmt
