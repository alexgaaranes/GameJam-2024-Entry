extends Node

var multiplier: float = 0
var target: float = 250.0

# Label object references
var comboLabel: Label

# Score Component
var perfectAmt: int = 0
var greatAmt: int = 0
var missedAmt: int = 0
var comboAmt: int = 0

var root: Node
var parent: Node
var cueSpawnManager: Node
var comboAnim: AnimationPlayer
var distanceManager: Node
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	distanceManager = parent.get_node("DistanceManager")
	root = parent.get_parent()
	cueSpawnManager = parent.get_node("CueSpawnManager")
	comboLabel = root.get_node("Combo")
	comboAnim = comboLabel.get_node("AnimationPlayer")
	comboLabel.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateComboLabel()
	updateMultiplier()

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

func updateComboLabel():
	if comboAmt > 4:
		if comboLabel.visible == false: comboAnim.play("fade_in")
		comboLabel.visible = true
		comboLabel.text = "Combo x%d" % [comboAmt]
	else:
		comboLabel.visible = false

func getCombo():
	return comboAmt

func updateMultiplier():
	if distanceManager.getDistance() > target:
		multiplier += 1
		target += 250

func getMultiplier():
	return multiplier
